//
//  MainViewController.m
//  TheFakeShow
//
//  Created by Masato Fukano on 11/08/09.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "MainViewController.h"

#import "CorrectAreaPlist.h"
#import "UserDefault.h"


//プライベートメソッド
@interface MainViewController ()
//{
//}

//サウンド
- (void) soundPlayOpening;
- (void) soundPlay:(NSString *)fileName type:(NSString *)typeName volume:(float)volume;

- (void) endingAnimation;

- (void) clearAllStage;

- (void) setShowType:(MainShowType)showType;
- (void) showGameStage:(BOOL)isShowHowTo;

@end


@implementation MainViewController


@synthesize adCloudView = _adCloudView;

@synthesize imageViewMainMenu   = _imageViewMainMenu;
@synthesize imageViewNextStage  = _imageViewNextStage;
@synthesize imageViewGameOver   = _imageViewGameOver;
@synthesize imageViewEnding     = _imageViewEnding;
@synthesize imageViewEnding2    = _imageViewEnding2;
@synthesize imageViewEnding3    = _imageViewEnding3;

@synthesize buttonStart         = _buttonStart;
@synthesize buttonContinue      = _buttonContinue;
@synthesize buttonCollection    = _buttonCollection;
@synthesize buttonHelp          = _buttonHelp;

@synthesize imgButtonHelp2      = _imgButtonHelp2;
@synthesize buttonHelp2         = _buttonHelp2;

@synthesize imgButtonHome       = _imgButtonHome;
@synthesize buttonHome          = _buttonHome;

@synthesize imgButtonFacebook   = _imgButtonFacebook;
@synthesize buttonFacebook      = _buttonFacebook;

@synthesize buttonNextStage     = _buttonNextStage;
@synthesize buttonRetry         = _buttonRetry;


#pragma mark - Private Method

- (void)soundPlayOpening
{
    if (audioMainMenu)
    {
        [audioMainMenu setCurrentTime:0];
        [audioMainMenu play];
    }
}

- (void)soundPlay:(NSString *)fileName type:(NSString *)typeName volume:(float)volume
{
    if (audioGame)
    {
        [audioGame stop];
        [audioGame release], audioGame = nil;
    }

    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:typeName];
    NSURL *url = [NSURL fileURLWithPath:path];

    audioGame = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    audioGame.volume = volume;
    audioGame.currentTime = 0;
    [audioGame play];
}


- (void)clearAllStage
{
    [self setShowType:typeEnding];


    //エンディング時のステージ数を登録
    [UserDefault setClearStageCount:[CorrectAreaPlist countStage]];

    //ゲームコンティニューは１面から
    [UserDefault setStageId:1];
}


- (void)setShowType:(MainShowType)showType
{
    //フラグ更新
    showType_ = showType;

    switch (showType)
    {
        //メインメニュー画面
        case (typeMainMenu):
        {
            self.adCloudView.alpha          = 0.0f;

            self.imageViewMainMenu.alpha    = 1.0f;
            self.imageViewNextStage.alpha   = 0.0f;
            self.imageViewGameOver.alpha    = 0.0f;
            self.imageViewEnding.alpha      = 0.0f;
            self.imageViewEnding2.alpha     = 0.0f;
            self.imageViewEnding3.alpha     = 0.0f;

            self.buttonStart.alpha          = 1.0f;
            self.buttonContinue.alpha       = 1.0f;
            self.buttonCollection.alpha     = 1.0f;
            self.buttonHelp.alpha           = 1.0f;

            self.buttonNextStage.alpha      = 0.0f;
            self.buttonRetry.alpha          = 0.0f;

            self.buttonHelp2.alpha          = 0.0f;
            self.imgButtonHelp2.alpha       = 0.0f;

            self.buttonHome.alpha           = 0.0f;
            self.imgButtonHome.alpha        = 0.0f;

            self.imgButtonFacebook.alpha    = 0.0f;
            self.buttonFacebook.alpha       = 0.0f;

            self.weblinkButton.alpha        = 1.0f;

            break;
        }

        //ゲームクリア
        case (typeNextStage):
        {
            self.adCloudView.alpha          = 1.0f;

            self.imageViewMainMenu.alpha    = 0.0f;
            self.imageViewNextStage.alpha   = 1.0f;
            self.imageViewGameOver.alpha    = 0.0f;
            self.imageViewEnding.alpha      = 0.0f;
            self.imageViewEnding2.alpha     = 0.0f;
            self.imageViewEnding3.alpha     = 0.0f;

            self.buttonStart.alpha          = 0.0f;
            self.buttonContinue.alpha       = 0.0f;
            self.buttonCollection.alpha     = 0.0f;
            self.buttonHelp.alpha           = 0.0f;

            self.buttonNextStage.alpha      = 1.0f;
            self.buttonRetry.alpha          = 0.0f;

            self.buttonHelp2.alpha          = 0.0f;
            self.imgButtonHelp2.alpha       = 0.0f;

            self.buttonHome.alpha           = 0.0f;
            self.imgButtonHome.alpha        = 0.0f;

            self.imgButtonFacebook.alpha    = 0.0f;
            self.buttonFacebook.alpha       = 0.0f;

            self.weblinkButton.alpha        = 0.0f;

            break;
        }

        //ゲームオーバー
        case (typeGameOver):
        {
            self.adCloudView.alpha          = 1.0f;

            self.imageViewMainMenu.alpha    = 0.0f;
            self.imageViewNextStage.alpha   = 0.0f;
            self.imageViewGameOver.alpha    = 1.0f;
            self.imageViewEnding.alpha      = 0.0f;
            self.imageViewEnding2.alpha     = 0.0f;
            self.imageViewEnding3.alpha     = 0.0f;

            self.buttonStart.alpha          = 0.0f;
            self.buttonContinue.alpha       = 0.0f;
            self.buttonCollection.alpha     = 0.0f;
            self.buttonHelp.alpha           = 0.0f;

            self.buttonNextStage.alpha      = 0.0f;
            self.buttonRetry.alpha          = 1.0f;

            self.buttonHelp2.alpha          = 1.0f;
            self.imgButtonHelp2.alpha       = 1.0f;

            self.buttonHome.alpha           = 0.0f;
            self.imgButtonHome.alpha        = 0.0f;

            self.imgButtonFacebook.alpha    = 0.0f;
            self.buttonFacebook.alpha       = 0.0f;

            self.weblinkButton.alpha        = 0.0f;

            break;
        }

        //エンディング
        case (typeEnding):
        {
            self.adCloudView.alpha          = 1.0f;

            self.imageViewMainMenu.alpha    = 0.0f;
            self.imageViewNextStage.alpha   = 0.0f;
            self.imageViewGameOver.alpha    = 0.0f;
            self.imageViewEnding.alpha      = 1.0f;
            self.imageViewEnding2.alpha     = 0.0f;
            self.imageViewEnding3.alpha     = 0.0f;

            self.buttonStart.alpha          = 0.0f;
            self.buttonContinue.alpha       = 0.0f;
            self.buttonCollection.alpha     = 0.0f;
            self.buttonHelp.alpha           = 0.0f;

            self.buttonNextStage.alpha      = 0.0f;
            self.buttonRetry.alpha          = 0.0f;

            self.imgButtonHelp2.alpha       = 0.0f;
            self.buttonHelp2.alpha          = 0.0f;

            self.imgButtonHome.alpha        = 0.0f;
            self.buttonHome.alpha           = 0.0f;

            self.imgButtonFacebook.alpha    = 0.0f;
            self.buttonFacebook.alpha       = 0.0f;

            self.weblinkButton.alpha        = 0.0f;

            break;
        }

        default:
        {
            break;
        }
    }

    //ボタンの使用可否
    {
        UIButton * buttons [] = {
            self.buttonStart,
            self.buttonContinue,
            self.buttonCollection,
            self.buttonHelp,
            self.buttonNextStage,
            self.buttonRetry,
            self.buttonHelp2,
            self.buttonHome,
            self.buttonFacebook,
        };

        for (int i = 0; i < sizeof(buttons)/sizeof(*buttons); i++)
        {
            UIButton * button = buttons[i];
            button.enabled = (button.alpha == 1.0f)?(YES):(NO);
        }
    }
}

- (void) showGameStage:(BOOL)isShowHowTo
{
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithStageId:stageId_];

    controller.delegate = self;
    controller.isShowHowTo = isShowHowTo;

    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];

    [controller release];
}


#pragma mark - AmoAd delegate

- (void)bannerView:(UIWebView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Error at App");
    /*
    if (!self.adCloudView.hidden)
    {
        self.adCloudView.frame = CGRectOffset(self.adCloudView.frame, 0, -self.adCloudView.frame.size.height);
        self.adCloudView.hidden = YES;
    }
     */
}


#pragma mark - View lifecycle

//InterfaceBuilder経由で呼ばれる
- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        audioMainMenu = nil;
        audioGame = nil;

        //BGM
        {
            NSString * pathOpening;
            NSURL * urlOpening;

            //self.adCloudView.hidden = YES;
//            pathOpening = [[NSBundle mainBundle] pathForResource:@"top" ofType:@"mp3"];
            pathOpening = [[NSBundle mainBundle] pathForResource:@"opening" ofType:@"caf"];
            urlOpening = [NSURL fileURLWithPath:pathOpening];

            audioMainMenu = [[AVAudioPlayer alloc] initWithContentsOfURL:urlOpening error:nil];

            //audioMainMenu.volume = 0.1f;
            //audioMainMenu.delegate = self;
            // 無限ループ
            audioMainMenu.numberOfLoops = -1;
        }
    }

    return self;
}

//- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self)
//    {
//    }
//
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    self.imageViewMainMenu.frame    = CGRectMake(0, 0, 480, 320);
//    self.imageViewNextStage.frame   = CGRectMake(0, 0, 480, 320 - ADVIEW_BANNER_SIZE_HEIGHT);
//    self.imageViewGameOver.frame    = CGRectMake(0, 0, 480, 320 - ADVIEW_BANNER_SIZE_HEIGHT);
//    self.imageViewEnding.frame      = CGRectMake(0, 0, 480, 320 - ADVIEW_BANNER_SIZE_HEIGHT);

    [self setShowType:typeMainMenu];
    stageCount_ = [CorrectAreaPlist countStage];
    stageId_ = 1;

    //広告
    {
        //広告サイズ
        CGRect rc = CGRectMake(0, 320 - ADVIEW_BANNER_SIZE_HEIGHT, ADVIEW_BANNER_SIZE_WIDTH, ADVIEW_BANNER_SIZE_HEIGHT);
        self.adCloudView = [[AMoAdView alloc] initWithFrame:rc];
//        _adCloudView = [[AMoAdView alloc] initWithFrame:CGRectZero];

        self.adCloudView.currentContentSizeIdentifier = AMoAdContentSizeIdentifierLandscape;
        self.adCloudView.sid = @"62056d310111552c5dd3d5b6ff7f880d4539dc98a6c89cc50040998fabb3983e";
        self.adCloudView.delegate = self;

        [self.adCloudView displayAd];

        [self.view addSubview:self.adCloudView];
        [self.view sendSubviewToBack:self.adCloudView];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//2011-12-05 Del -->
//    [self.adCloudView displayAd];
//2011-12-05 Del <--
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];


    switch (showType_)
    {
        //メインメニュー画面
        case typeMainMenu:
        {
            //[self performSelector:@selector(soundPlayOpening) withObject:nil afterDelay:0.3];
            [self performSelector:@selector(soundPlayOpening) withObject:nil afterDelay:0.1];

            //広告をz軸後ろに移動
            [self.view sendSubviewToBack:self.adCloudView];

            break;
        }


        //ゲームクリア
        case typeNextStage:
        {
//            //サウンド
//            [self soundPlay:@"clear" type:@"mp3" volume:1.0f];
//            [self soundPlay:@"crap" type:@"caf" volume:1.0f];

//            //画像
//            {
//                NSString * file = [NSString stringWithFormat:@"clear-gamen%d.png",
//                                   (int)(stageId_/5)+1];
//
//                self.imageViewNextStage.image = [UIImage imageNamed:file];
//            }


            //広告を手前に移動
            [self.view bringSubviewToFront:self.adCloudView];

            break;
        }


        //ゲームオーバー
        case typeGameOver:
        {
            //サウンド
//            [self soundPlay:@"shippai" type:@"mp3" volume:1.0f];
//            [self soundPlay:@"ahaaa" type:@"caf" volume:1.0f];

//            //画像
//            {
//                NSString * file = [NSString stringWithFormat:@"retry-gamen%d.png",
//                                   (int)(stageId_/5)+1];
//
//                self.imageViewGameOver.image = [UIImage imageNamed:file];
//            }


            //広告を手前に移動
            [self.view bringSubviewToFront:self.adCloudView];

            break;
        }


        //エンディング
        case typeEnding:
        {
            [UserDefault setIsCheckClearCollection:YES];

            //サウンド
            [self soundPlay:@"end" type:@"mp3" volume:1.0f];
//            [self soundPlay:@"ending" type:@"caf" volume:1.0f];

            //サウンド 無限ループ
            audioGame.numberOfLoops = -1;


            //広告を手前に移動
            [self.view bringSubviewToFront:self.adCloudView];


            //エンディング画面(６秒ファンファーレを鳴らしてからfacebookへ)
            [self performSelector:@selector(endingAnimation)
                       withObject:nil
                       afterDelay:6.0f];

            break;
        }

        default:
            break;
    }
}

- (void) endingAnimation
{
    //仕様 ファンファーレを止める
    [audioGame stop];

    self.imageViewEnding2.alpha = 0.0f;
    self.imageViewEnding3.alpha = 0.0f;


    //*** エンディング画面 ***
    //*** また会いましょう ... 非表示 -> 表示
    [UIView animateWithDuration:3.0f
                     animations:^{

                         self.imageViewEnding2.alpha = 1.0f;

                     } completion:^(BOOL finished) {

                         //３秒待機
                         [NSThread sleepForTimeInterval:3.0f];

                         //*** また会いましょう ... 表示 -> 半透明
                         [UIView animateWithDuration:1.0f
                                          animations:^{

                                              self.imageViewEnding2.alpha = 0.5f;
                                          } completion:^(BOOL finished) {

                                              //*** また会いましょう ... 半透明 -> 非表示
                                              //*** Facebook URL ... 非表示 -> 半透明
                                              [UIView animateWithDuration:1.0f
                                                               animations:^{

                                                                   self.imageViewEnding2.alpha = 0.0f;
                                                                   self.imageViewEnding3.alpha = 0.5f;
                                                               } completion:^(BOOL finished) {

                                                                   //*** Facebook URL ... 半透明 -> 表示
                                                                   [UIView animateWithDuration:1.0f
                                                                                    animations:^{

                                                                                        self.imageViewEnding3.alpha = 1.0f;
                                                                                        self.imgButtonFacebook.alpha = 1.0f;
                                                                                        self.buttonFacebook.alpha = 1.0f;

                                                                                    } completion:^(BOOL finished) {

                                                                                        //Facebookボタン 使用可能
                                                                                        self.buttonFacebook.enabled = YES;


                                                                                        //*** ホームボタン ... 非表示 -> 表示
                                                                                        [UIView animateWithDuration:1.0f
                                                                                                         animations:^{

                                                                                                             self.imgButtonHome.alpha = 1.0f;
                                                                                                             self.buttonHome.alpha = 1.0f;
                                                                                                         } completion:^(BOOL finished) {

                                                                                                             //ホームボタン 使用可能
                                                                                                             self.buttonHome.enabled = YES;
                                                                                                         }];
                                                                                    }];
                                                               }];
                                          }];
                     }];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations.
    return ((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||
            (interfaceOrientation == UIInterfaceOrientationLandscapeRight));
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    self.adCloudView = nil;

    self.imageViewMainMenu = nil;
    self.imageViewNextStage = nil;
    self.imageViewGameOver = nil;
    self.imageViewEnding = nil;
    self.imageViewEnding2 = nil;
    self.imageViewEnding3 = nil;

    self.buttonStart = nil;
    self.buttonContinue = nil;
    self.buttonCollection = nil;
    self.buttonHelp = nil;

    self.imgButtonHelp2 = nil;
    self.buttonHelp2 = nil;

    self.imgButtonHome = nil;
    self.buttonHome = nil;

    self.imgButtonFacebook = nil;
    self.buttonFacebook = nil;

    self.buttonNextStage = nil;
    self.buttonRetry = nil;


    [audioMainMenu stop];
    [audioMainMenu release], audioMainMenu = nil;

    if (audioGame)
    {
        [audioGame stop];
    }
    [audioGame release], audioGame = nil;
    ////////////////////////////////////////////////////////////////////////////
    self.weblinkButton = nil;

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [_adCloudView release], _adCloudView = nil;

    [_imageViewMainMenu release],   _imageViewMainMenu = nil;
    [_imageViewNextStage release],  _imageViewNextStage = nil;
    [_imageViewGameOver release],   _imageViewGameOver = nil;
    [_imageViewEnding release],     _imageViewEnding = nil;
    [_imageViewEnding2 release],    _imageViewEnding2 = nil;
    [_imageViewEnding3 release],    _imageViewEnding3 = nil;

    [_buttonStart release],         _buttonStart = nil;
    [_buttonContinue release],      _buttonContinue = nil;
    [_buttonCollection release],    _buttonCollection = nil;
    [_buttonHelp release],          _buttonHelp = nil;

    [_imgButtonHelp2 release],      _imgButtonHelp2 = nil;
    [_buttonHelp2 release],         _buttonHelp2 = nil;

    [_imgButtonHome release],       _imgButtonHome = nil;
    [_buttonHome release],          _buttonHome = nil;

    [_imgButtonFacebook release],   _imgButtonFacebook = nil;
    [_buttonFacebook release],      _buttonFacebook = nil;

    [_buttonNextStage release],     _buttonNextStage = nil;
    [_buttonRetry release],         _buttonRetry = nil;


    if (audioMainMenu)
    {
        [audioMainMenu stop];
    }
    [audioMainMenu release], audioMainMenu = nil;

    if (audioGame)
    {
        [audioGame stop];
    }
    [audioGame release], audioGame = nil;

    ////////////////////////////////////////////////////////////////////////////
    [_weblinkButton release];
    [super dealloc];
}



#pragma mark - FlipsideViewControllerDelegate

- (void)gameOverWithStage:(int)stageId
{
//    [self dismissModalViewControllerAnimated:YES];
    //サウンド
    [self soundPlay:@"shippai" type:@"mp3" volume:1.0f];

    //画像
    {
        int index = (int)(stageId_/5)+1;
        if (index >4)
        {
            index = 4;
        }

        NSString * file = [NSString stringWithFormat:@"retry-gamen%d.png", index];

        self.imageViewGameOver.image = [UIImage imageNamed:file];
    }

    [self setShowType:typeGameOver];
}

- (void)nextStageWithStage:(int)stageId
{
//    [self dismissModalViewControllerAnimated:YES];
    //サウンド
//    [self soundPlay:@"clear" type:@"mp3" volume:1.0f];
    [self soundPlay:@"crap" type:@"caf" volume:1.0f];

    //画像
    {
        int index = (int)(stageId_/5)+1;
        if (index >4)
        {
            index = 4;
        }

        NSString * file = [NSString stringWithFormat:@"clear-gamen%d.png", index];

        self.imageViewNextStage.image = [UIImage imageNamed:file];
    }

    //ステージ番号更新 (+1)
    stageId_ = stageId + 1;

    if (stageId_ > stageCount_)
    {
        stageId_ = 1;
        [self clearAllStage];

        return;
    }


    [self setShowType:typeNextStage];


    //次回アプリ起動時にこのステージから続けられるように記録
    [UserDefault setStageId:stageId_];
    //クリアしたステージまで更新
    [UserDefault setClearStageCount:stageId];
}


#pragma mark - CollectionViewDelegate

- (void)backFromCollection
{
//    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark - HelpViewDelegate

- (void)backFromHelp
{
//    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark - Action Method

//はじめからスタート
- (IBAction)showInfo:(id)sender
{
    //サウンド
    [self soundPlay:@"tap" type:@"mp3" volume:1.0f];

    [audioMainMenu stop];
    stageId_ = 1;

    //コレクションをクリアするかどうか
    if ([UserDefault getIsCheckClearCollection])
    {
        //
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"CM BAR"
                                                         message:@"コレクションをクリアしますか？"
                                                        delegate:self
                                               cancelButtonTitle:nil
                                               otherButtonTitles:@"YES", @"NO", nil];

        [alert show];

        [alert release];
    }
    else
    {
        [self showGameStage:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case (0):
        {
            //コレクションのクリアステージ数をリセット
            [UserDefault resetClearStageCount];
            break;
        }
        case (1):
        {
            break;
        }
        default:
            break;
    }

    [UserDefault setIsCheckClearCollection:NO];

    [self showGameStage:YES];
}




//つづきからスタート
- (IBAction)showContinue:(id)sender
{
    //サウンド
    [self soundPlay:@"tap" type:@"mp3" volume:1.0f];

    [audioMainMenu stop];

    stageId_ = [UserDefault getStageId];

    [self showGameStage:NO];
}

- (IBAction)showCollection:(id)sender
{
    //サウンド
    [self soundPlay:@"tap" type:@"mp3" volume:1.0f];

    [audioMainMenu stop];

    //コレクション画面
    {
        CollectionView *controller = [[CollectionView alloc] initWithNibName:@"CollectionView" bundle:nil];
        controller.delegate = self;

        controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentModalViewController:controller animated:YES];

        [controller release];
    }
}

- (IBAction)showHelp:(id)sender
{
    //サウンド
    [self soundPlay:@"tap" type:@"mp3" volume:1.0f];

    [audioMainMenu stop];

    //ヘルプ画面
    {
        HelpView *controller = [[HelpView alloc] initWithNibName:@"HelpView" bundle:nil];
        controller.delegate = self;

        controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentModalViewController:controller animated:YES];

        [controller release];
    }
}


- (IBAction)showHome:(id)sender
{
    self.imageViewEnding.userInteractionEnabled = NO;

    [audioGame stop];
    [audioGame release], audioGame = nil;

    self.buttonFacebook.enabled = NO;
    self.buttonHome.enabled = NO;

    //メイン画面に画面切り替え
    [UIView transitionWithView:self.imageViewEnding
                      duration:1.0f
                       options:UIViewAnimationOptionShowHideTransitionViews
//                       options:UIViewAnimationOptionTransitionFlipFromBottom    //下 -> 上
//                       options:UIViewAnimationOptionTransitionFlipFromLeft      //左 -> 右
                    animations:^{

                        //Facebook画面非表示
                        self.imageViewEnding.alpha = 0.0f;
                        self.imgButtonFacebook.alpha = 0.0f;
                        self.buttonFacebook.alpha = 0.0f;
                        self.imgButtonHome.alpha = 0.0f;
                        self.buttonHome.alpha = 0.0f;

                        //メイン画面表示
                        self.imageViewMainMenu.alpha = 1.0f;

                    } completion:^(BOOL finished) {

                        //メインメニュー画面に戻る
                        [self setShowType:typeMainMenu];

                        //BGM
                        [self soundPlayOpening];
                    }];
}

- (IBAction)showFacebookPage:(id)sender
{
    self.imageViewEnding.userInteractionEnabled = NO;

    [audioGame stop];
    [audioGame release], audioGame = nil;


    //safariで facebookを表示
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.facebook.com/mr.figure.life"]];
}


//ステージクリア、ゲームオーバー時の操作
- (IBAction)showStage:(id)sender
{
    //サウンド
    [self soundPlay:@"tap" type:@"mp3" volume:1.0f];

    [self showGameStage:NO];
}


- (IBAction)weblink
{
    NSLog(@"%s", __func__);
}


//- (IBAction)showMoreApps:(id)sender
//{
//    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/search?term=Goodia"]];
//    //    NSString *searchString = @"Goodia Inc.";
//    //    NSString *encode = (NSString*)CFURLCreateStringByAddingPercentEscapes(  
//    //																		  kCFAllocatorDefault,  
//    //																		  (CFStringRef)searchString,  
//    //																		  NULL,  
//    //																		  NULL,  
//    //																		  kCFStringEncodingUTF8  
//    //																		  );
//    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.com/apps/%@", encode]]];
//    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.com/apps/GoodiaInc"]];
//}

//- (IBAction)showAppOne:(id)sender
//{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=465601655&mt=8"]];
//}
//
//- (IBAction)showAppTwo:(id)sender
//{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=506553189&mt=8"]];
//}

@end
