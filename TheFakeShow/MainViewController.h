//
//  MainViewController.h
//  TheFakeShow
//
//  Created by Masato Fukano on 11/08/09.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "AMoAdView.h"

#import "FlipsideViewController.h"
#import "CollectionView.h"
#import "HelpView.h"


//画面状態別フラグ
typedef enum {
    typeMainMenu,   //メインメニュー画面
    typeNextStage,  //ゲームクリア時の画面
    typeGameOver,   //ゲームオーバー時の画面
    typeEnding      //エンデイング画面
} MainShowType;


@interface MainViewController : UIViewController <UIAlertViewDelegate, AMoAdViewDelegate, FlipsideViewControllerDelegate, CollectionViewDelegate, HelpViewDelegate>
{
    @private

    //サウンド
    AVAudioPlayer * audioMainMenu;
    AVAudioPlayer * audioGame;

    MainShowType showType_;
    int stageCount_;
    int stageId_;
}


@property (nonatomic, retain) AMoAdView * adCloudView;

@property (nonatomic, retain) IBOutlet UIImageView * imageViewMainMenu;
@property (nonatomic, retain) IBOutlet UIImageView * imageViewNextStage;
@property (nonatomic, retain) IBOutlet UIImageView * imageViewGameOver;
@property (nonatomic, retain) IBOutlet UIImageView * imageViewEnding;
@property (nonatomic, retain) IBOutlet UIImageView * imageViewEnding2;
@property (nonatomic, retain) IBOutlet UIImageView * imageViewEnding3;

@property (nonatomic, retain) IBOutlet UIButton * buttonStart;
@property (nonatomic, retain) IBOutlet UIButton * buttonContinue;
@property (nonatomic, retain) IBOutlet UIButton * buttonCollection;
@property (nonatomic, retain) IBOutlet UIButton * buttonHelp;

@property (retain, nonatomic) IBOutlet UIImageView * imgButtonHelp2;
@property (retain, nonatomic) IBOutlet UIButton * buttonHelp2;

@property (retain, nonatomic) IBOutlet UIImageView * imgButtonHome;
@property (retain, nonatomic) IBOutlet UIButton * buttonHome;

@property (retain, nonatomic) IBOutlet UIImageView *imgButtonFacebook;
@property (retain, nonatomic) IBOutlet UIButton * buttonFacebook;

@property (nonatomic, retain) IBOutlet UIButton * buttonNextStage;
@property (nonatomic, retain) IBOutlet UIButton * buttonRetry;


//メインメニューでの操作
- (IBAction) showInfo:(id)sender;
- (IBAction) showContinue:(id)sender;
- (IBAction) showCollection:(id)sender;

//ゲームオーバーでの操作
- (IBAction) showHelp:(id)sender;

//エンディングでの操作
- (IBAction) showHome:(id)sender;
- (IBAction) showFacebookPage:(id)sender;

//ステージクリア ゲームオーバー時の操作
- (IBAction) showStage:(id)sender;

@end
