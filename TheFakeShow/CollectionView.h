//
//  CollectionView.h
//  TheFakeShow
//
//  Created by Masato Fukano on 11/08/16.
//  Copyright 2011年 Goodia Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "UIImageViewEx.h"


@class CollectionView;

@protocol CollectionViewDelegate
- (void)backFromCollection;
@end

@interface CollectionView : UIViewController <UIImageViewExDelegate /*, UIScrollViewDelegate */>
{
    @private
    id<CollectionViewDelegate> _delegate;

    @private
    UIView * _pageView;
    UIScrollView * _scrollView;
    UIImageView * _photoBack;
    UIButton * _buttonBack;

    @private
    UIImageViewEx * photoDetail;
    UIImageView   * photoTitle;

    //サウンド
    @private
    AVAudioPlayer * audioTouch;
}


@property (nonatomic, assign) id <CollectionViewDelegate> delegate;


@property (nonatomic, retain) IBOutlet UIView * pageView;
@property (nonatomic, retain) IBOutlet UIScrollView * scrollView;

@property (nonatomic, retain) IBOutlet UIView * photoBack;

@property (nonatomic, retain) IBOutlet UIButton * buttonBack;

- (IBAction)back:(id)sender;

@end
