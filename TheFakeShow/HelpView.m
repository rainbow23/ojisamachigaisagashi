//
//  HelpView.m
//  TheFakeShow
//
//  Created by Masato Fukano on 11/08/16.
//  Copyright 2011年 Goodia Inc. All rights reserved.
//

#import "HelpView.h"

@interface HelpView ()

//サウンド
- (void)soundPlay:(NSString *)fileName type:(NSString *)typeName volume:(float)volume;

@end


@implementation HelpView

@synthesize delegate = _delegate;


- (void)soundPlay:(NSString *)fileName type:(NSString *)typeName volume:(float)volume
{
    if (audioTouch)
    {
        [audioTouch stop];
        [audioTouch release], audioTouch = nil;
    }

    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:typeName];
    NSURL *url = [NSURL fileURLWithPath:path];

    audioTouch = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    audioTouch.volume = volume;
    audioTouch.currentTime = 0;
    [audioTouch play];
}


#pragma mark - Actions

- (IBAction)back:(id)sender
{
    //サウンド
    [self soundPlay:@"tap" type:@"mp3" volume:1.0f];

    if ([(id)self.delegate respondsToSelector:@selector(backFromHelp)])
    {
        [self.delegate backFromHelp];
    }

    //画面を閉じる
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    if (audioTouch)
    {
        [audioTouch stop];
    }
    [audioTouch release], audioTouch = nil;

    [super viewDidUnload];
}

- (void)dealloc
{
    if (audioTouch)
    {
        [audioTouch stop];
    }
    [audioTouch release], audioTouch = nil;

    [super dealloc];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return ((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||
            (interfaceOrientation == UIInterfaceOrientationLandscapeRight));
}

@end
