//
//  FlipsideViewController.h
//  TheFakeShow
//
//  Created by Masato Fukano on 11/08/09.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "AdMakerView.h"
#import "AMoAdView.h"

#import "UIImageViewEx.h"


@class FlipsideViewController;


@protocol FlipsideViewControllerDelegate

- (void)nextStageWithStage:(int)stageId;
- (void)gameOverWithStage:(int)stageId;
@end


@interface FlipsideViewController : UIViewController<AdMakerDelegate, AMoAdViewDelegate, UIImageViewExDelegate>
{
    //=== 内部変数 ===
    @private

    id <FlipsideViewControllerDelegate> _delegate;

    int _stageId;
    NSDictionary * _stageData;


    //広告///////////////
    AdMakerView * _adMaker;
    AMoAdView * _adCloudView;

    //タイトル画像
    UIImageView * imageViewStageTitle;

    //サウンド
    AVAudioPlayer * audioBGM;
    AVAudioPlayer * audioTouch;

//    //画像切り替え用カウント
//    int nImageChangeInterbalCount;

    //制限時間
    NSTimer * _limitTimer;
    int       _limit;


    //=== UIKit ===
    @private
    UIImageViewEx * _imageViewStage;    //ゲーム画面
    UIImageView *   _imgTouchPoint;     //タッチした位置の正解/不正解 表示
    UIButton *      _buttonReplay;
}


@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;

@property (nonatomic, readonly) int stageId;
@property (nonatomic, readonly) NSDictionary * stageData;

@property (nonatomic, retain) AdMakerView * adMaker;
@property (nonatomic, retain) AMoAdView * adCloudView;

@property (nonatomic, retain) IBOutlet UIImageViewEx * imageViewStage;
@property (retain, nonatomic) IBOutlet UIButton * buttonReplay;
@property (retain, nonatomic) IBOutlet UIImageView * imgTouchPoint;
@property (retain, nonatomic) IBOutlet UIImageView * countDownImage;

@property (assign, nonatomic) BOOL isShowHowTo;
@property (retain, nonatomic) IBOutlet UIImageView *imgHowTo;
@property (retain, nonatomic) IBOutlet UIImageView *imgBackHowTo;
@property (retain, nonatomic) IBOutlet UIButton *buttonBackHowTo;

- (IBAction)tapReplay:(id)sender;
- (IBAction)tapButtonBackHowTo:(id)sender;


- (id) initWithStageId:(int)stageId;

@end
