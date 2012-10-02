//
// Copyright 2011 Atlantis, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "AdLantisSDKBinding.h"
#import "AdlantisView.h"
#import "AdlantisAdManager.h"

#ifdef GREE_DEPLOY_TARGET
#import "GreeAdManager.h"
#import "Gree.h"
#import "GreeSDKViewController.h"
#import "GreeLoginStatusView.h"
#import "GreeSDKNavigationController.h"
#endif

#import "AdLantisGeometryUtils.h"

extern "C++" void UnityPause( bool pause );  // needs to be linked as C++ function

///////////////////////////////////////////////////////////////////////////////////////////////////
@interface AdLantisNotificationListener : NSObject {
}
@end

AdlantisView *gAdView = nil;
AdLantisNotificationListener *gNotificationListener = nil;

///////////////////////////////////////////////////////////////////////////////////////////////////
AdlantisView* AdView_Init() {
  CGSize suggestedViewSize = AdlantisViewSizeForOrientation(UIApplication.sharedApplication.statusBarOrientation);
  CGRect adViewFrame = CGRectMake(0, 0, suggestedViewSize.width, suggestedViewSize.height);
  AdlantisView *adView = [[[AdlantisView alloc] initWithFrame:adViewFrame] autorelease];
  adView.backgroundColor = [UIColor clearColor];
  
  AdView_Set(adView);
  
  return adView;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void AdView_Set(AdlantisView *adView) {
  //NSLog(@"AdView_Set");
  [gAdView release];
  [gNotificationListener release]; gNotificationListener = nil;
  
  gAdView = [adView retain];
  if (gAdView) {
    gNotificationListener = [[AdLantisNotificationListener alloc] init];
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void _AdView_SetPublisherId(char * id) {
  //NSLog(@"_AdView_SetPublisherId");
  [AdlantisAdManager sharedManager].publisherID = [NSString stringWithCString:id encoding:NSUTF8StringEncoding];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void _AdView_SetGapPublisherId(char * id) {
  //NSLog(@"_AdView_SetGapPublisherId");
#ifdef GREE_DEPLOY_TARGET
  [AdlantisAdManager sharedManager].gapPublisherID = [NSString stringWithCString:id encoding:NSUTF8StringEncoding];
#endif
}

///////////////////////////////////////////////////////////////////////////////////////////////////
AdlantisView *AdView() {
  return gAdView;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void _AdView_ShowHide(bool show)
{
  [AdView() setHidden:!show];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void	_AdView_FadeIn() {
  [AdView() fadeIn];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void	_AdView_FadeOut() {
  [AdView() fadeOut];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
UIInterfaceOrientation AdView_CurrentOrientation() 
{
  return UIApplication.sharedApplication.statusBarOrientation;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
UIInterfaceOrientation AdView_OrientationForPosition(AdViewPosition position)
{
  UIInterfaceOrientation currentOrientation = AdView_CurrentOrientation();

  switch (position) {
    case AdViewTop:
    case AdViewBottom:
    default:
      return currentOrientation;
      break;
      
    case AdViewLeft:
    case AdViewRight:
      if (UIInterfaceOrientationIsPortrait(currentOrientation)) {
        return UIInterfaceOrientationLandscapeRight;
      }
      else {
        return UIInterfaceOrientationPortrait;
      }
      break;
  }
  
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#ifdef GREE_DEPLOY_TARGET

UIView* GetGreeLoginStatusView()
{
  return [[[[Gree sharedInstance] sdkNavigationController] viewController] loginStatusView];
}

#endif

///////////////////////////////////////////////////////////////////////////////////////////////////
// This function only works properly if the view is in a superview and has a window
void _AdView_SetPosition(AdViewPosition position)
{
  UIView *sharedContainer = AdView().superview;
  CGRect containerBounds = sharedContainer.bounds;
  
  if (![[UIApplication sharedApplication] isStatusBarHidden] && AdView().window) {
    CGRect statusBarViewRect = ADLConvertStatusBarFrameToViewRect(AdView().superview);
    containerBounds = ADLRectFromRectSubtractingRect(containerBounds, statusBarViewRect);
  }
  
  #ifdef GREE_DEPLOY_TARGET
    
  UIView* loginStatusView = GetGreeLoginStatusView();
  if (loginStatusView) {
    CGRect loginStatusViewFrame = [loginStatusView convertRect:loginStatusView.bounds toView:sharedContainer];
    containerBounds = ADLRectFromRectSubtractingRect(containerBounds, loginStatusViewFrame);
  }
  
  #endif
  
  CGSize suggestedViewSize = AdlantisViewSizeForOrientation(AdView_OrientationForPosition(position));
  AdView().transform = CGAffineTransformIdentity;
  AdView().frame = CGRectMake(0, 0, suggestedViewSize.width, suggestedViewSize.height);
  
  switch (position) {

    case AdViewTop:
      AdView().frame = CGRectMake(containerBounds.origin.x, containerBounds.origin.y, suggestedViewSize.width, suggestedViewSize.height);
      break;
    
    case AdViewBottom:
      AdView().frame = CGRectMake(containerBounds.origin.x, containerBounds.origin.y + containerBounds.size.height - suggestedViewSize.height, 
                                  suggestedViewSize.width, suggestedViewSize.height);
      break;
      
    case AdViewLeft:
      AdView().center = CGPointMake(containerBounds.origin.x + suggestedViewSize.height / 2.0, 
                                    containerBounds.origin.y + containerBounds.size.height / 2.0);
      AdView().transform = CGAffineTransformRotate(CGAffineTransformIdentity, -(M_PI / 2.0));
      break;
    
    case AdViewRight:
      AdView().center = CGPointMake(containerBounds.origin.x + containerBounds.size.width - suggestedViewSize.height / 2.0, 
                                    containerBounds.origin.y + containerBounds.size.height / 2.0);
      AdView().transform = CGAffineTransformRotate(CGAffineTransformIdentity, (M_PI / 2.0));
      break;
      
  }
  
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void	_AdView_Log(char* s) {
  NSLog(@"%@", [NSString stringWithCString:s encoding:NSUTF8StringEncoding]);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

@interface AdLantisNotificationListener()
-(void)previewWillBeShown:(NSNotification*)notification;
-(void)previewWillBeHidden:(NSNotification*)notification;
-(void)adsUpdatedNotification:(NSNotification*)notification;
@end

///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation AdLantisNotificationListener 

-(id)init
{
  if ((self = [super init])) {
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(previewWillBeShown:) 
                                                 name:AdlantisPreviewWillBeShownNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(previewWillBeHidden:) 
                                                 name:AdlantisPreviewWillBeHiddenNotification object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self 
//                                             selector:@selector(adsUpdatedNotification:)
//                                                 name:AdlantisAdsUpdatedNotification object:nil];
  }
 
  return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)previewWillBeShown:(NSNotification*)notification
{
  //NSLog(@"AdLantisNotificationListener previewWillBeShown:");
  
  UnityPause( true );
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)previewWillBeHidden:(NSNotification*)notification
{
  //NSLog(@"AdLantisNotificationListener previewWillBeHidden:");
  
  UnityPause( false );
}

-(void)adsUpdatedNotification:(NSNotification*)notification
{
  NSLog(@"AdLantisNotificationListener adsUpdatedNotification: %@", notification);
  
  NSLog(@"has portrait ads = %d", [[AdlantisAdManager sharedManager] hasAdsForOrientation:UIInterfaceOrientationPortrait]);
  NSLog(@"has landscape ads = %d", [[AdlantisAdManager sharedManager] hasAdsForOrientation:UIInterfaceOrientationLandscapeLeft]);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc 
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  
  [super dealloc];
}  

@end


