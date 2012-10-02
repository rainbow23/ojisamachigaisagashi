//
//  HelpView.h
//  TheFakeShow
//
//  Created by Masato Fukano on 11/08/16.
//  Copyright 2011年 Goodia Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@protocol HelpViewDelegate
- (void)backFromHelp;
@end


@interface HelpView : UIViewController
{
    @private
    id<HelpViewDelegate> _delegate;

    //サウンド
    @private
    AVAudioPlayer * audioTouch;
}

@property (nonatomic, assign) id <HelpViewDelegate> delegate;

- (IBAction)back:(id)sender;

@end
