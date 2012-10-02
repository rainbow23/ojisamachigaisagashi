//
//  FlipsideViewController.m
//  TheFakeShow
//
//  Created by Masato Fukano on 11/08/09.
//  Copyright 2011年 Goodia Inc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "FlipsideViewController.h"
#import "CorrectAreaPlist.h"

#define TIME_SHOW_TITLE   (1.2f)
#define TIME_HIDE_TITLE   (1.5f)
#define TIME_SHOW_IMAGE1  (1.5f)
#define TIME_SHOW_BLACK   (1.0f)


//プライベート
@interface FlipsideViewController()
//{
//    UIImageView * imageViewStageTitle;
//
//    AVAudioPlayer * audioBGM;
//    //AVAudioPlayer *audioAhaaa;
//}

- (void)hideTitle;
- (void)slideImage:(NSNumber *)flag;


//サウンド
- (void)soundPlayTimer;
- (void)soundPlay:(NSString *)fileName type:(NSString *)typeName volume:(float)volume;


//制限時間カウント
- (void) limitCount:(NSTimer *)timer;


- (void)next;
- (void)gameOver;

- (void) maru;
- (void) batsu;

- (void) startGame;
- (void) setStage;
- (void) setAdView;

//- (NSData *)getUrlData:(NSString *)url;
//- (UIImage *)getImage:(NSString *)url;

@end


@implementation FlipsideViewController

@synthesize delegate        = _delegate;

@synthesize stageId         = _stageId;
@synthesize stageData       = _stageData;

@synthesize adMaker         = _adMaker;
@synthesize adCloudView     = _adCloudView;

@synthesize imageViewStage  = _imageViewStage;
@synthesize buttonReplay    = _buttonReplay;
@synthesize imgTouchPoint   = _imgTouchPoint;
@synthesize countDownImage  = _countDownImage;

@synthesize isShowHowTo     = _isShowHowTo;
@synthesize imgHowTo        = _imgHowTo;
@synthesize imgBackHowTo    = _imgBackHowTo;
@synthesize buttonBackHowTo = _buttonBackHowTo;


#pragma mark AmoAd delegate

- (void) AMoAdViewDidReceiveEmptyAd:(AMoAdView *)adView {
    NSLog(@"Get Empty Ad");
}


#pragma mark - AdMaker Delegate

-(UIViewController*)currentViewControllerForAdMakerView:(AdMakerView*)view
{
    return self;
}

-(NSArray*)adKeyForAdMakerView:(AdMakerView*)view
{
    return [NSArray arrayWithObjects:@"http://images.ad-maker.info/apps/sph27m88983l.html",@"723",@"5609",nil];
}

- (void)didLoadAdMakerView:(AdMakerView*)view
{
    [self.view addSubview:self.adMaker.view];
}

- (void)didFailedLoadAdMakerView:(AdMakerView*)view
{
}


#pragma mark - Private method

- (void)hideTitle
{
    //タイトル -> 画像1(before) -> 暗幕 -> 画像2(after)

    //アニメーション1
    //タイトル画像を非表示にする
    [UIView animateWithDuration:TIME_HIDE_TITLE
                     animations:^ {

                         //最終的に透明にする
                         imageViewStageTitle.alpha = 0.0f;

                     } completion:^(BOOL finished) {

                         //アニメーション終了後にコントロールを削除
                         [imageViewStageTitle removeFromSuperview];
                         [imageViewStageTitle release], imageViewStageTitle = nil;

                         //画像1 -> 暗幕 -> 画像2 の切り替え...
                         [self performSelector:@selector(slideImage:)
                                    withObject:[NSNumber numberWithInt:0]
                                    afterDelay:0.0f];
                     }];
}

/**
 * スライド処理 (画像切り替え)
 */
- (void)slideImage:(NSNumber *)flag
{
    NSString * imageName = nil;

    switch ([flag intValue])
    {
        case 0:
        {
            //切り替え前
//            NSLog(@"%s 画像1 Before", __func__);
//            imageName = [NSString stringWithFormat:@"%d-1.jpg", self.stageId];
            imageName = [self.stageData objectForKey:CORRECTAREA_KEY__IMG_BEFORE];
            self.imageViewStage.image = [UIImage imageNamed:imageName];

            //1.5秒後に 暗幕 に切り替え
            [self performSelector:@selector(slideImage:)
             withObject:[NSNumber numberWithInt:1]
                       afterDelay:TIME_SHOW_IMAGE1];

            break;
        }

        case 1:
        {
//            NSLog(@"%s 暗幕", __func__);
            imageName = @"black_screen.png";
            self.imageViewStage.image = [UIImage imageNamed:imageName];

            //1.0秒後に 画像2 に切り替え
            [self performSelector:@selector(slideImage:)
                       withObject:[NSNumber numberWithInt:2]
                       afterDelay:TIME_SHOW_BLACK];

            break;
        }

        case 2:
        {
            //切り替え後
//            NSLog(@"%s 画像2 After", __func__);
//            imageName = [NSString stringWithFormat:@"%d-2.jpg", self.stageId];
            imageName = [self.stageData objectForKey:CORRECTAREA_KEY__IMG_AFTER];
            self.imageViewStage.image = [UIImage imageNamed:imageName];

            //チャンスボタン使用可能であれば表示
            self.buttonReplay.alpha = (self.buttonReplay.enabled)?(1.0f):(0.0f);

            //この時点で回答操作可能とする
            self.imageViewStage.userInteractionEnabled = YES;

            //BGM開始
            [self soundPlayTimer];

            //タイマー開始
            _limit = 10;
            _limitTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                           target:self
                                                         selector:@selector(limitCount:)
                                                         userInfo:nil
                                                          repeats:YES
                           ];

            break;
        }

        //想定外
        default:
        {
            return;
        }
    }
}


- (void)soundPlayTimer
{
    if (audioBGM)
    {
        [audioBGM play];
    }
}

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


//制限時間カウント
- (void) limitCount:(NSTimer *)timer
{
    _limit--;

    if (_limit <= 0)
    {
        _limit = 0;
    }

    if (_limit <= 5)
    {
        NSString * fileName = [NSString stringWithFormat:@"countdown_%d.png", _limit];
        self.countDownImage.image = [UIImage imageNamed:fileName];
        if (self.countDownImage.alpha != 1.0f)
        {
            self.countDownImage.alpha = 1.0f;
        }
    }

    if (_limit <= 0)
    {
        [_limitTimer invalidate];
        _limitTimer = nil;

        //ゲーム終了
        [self gameOver];
    }
}


- (void)next
{
    //制限時間カウントダウンタイマー
    if (_limitTimer)
    {
        [_limitTimer invalidate];
        _limitTimer = nil;
    }

    //デリゲート処理
    if ([(id)self.delegate respondsToSelector:@selector(nextStageWithStage:)])
    {
        [self.delegate nextStageWithStage:self.stageId];
    }

    //画面を閉じる
    [self dismissModalViewControllerAnimated:YES];
}

- (void)gameOver
{
    //制限時間カウントダウンタイマー
    if (_limitTimer)
    {
        [_limitTimer invalidate];
        _limitTimer = nil;
    }

    //デリゲート処理
    if ([(id)self.delegate respondsToSelector:@selector(gameOverWithStage:)])
    {
        [self.delegate gameOverWithStage:self.stageId];
    }

    //画面を閉じる
    [self dismissModalViewControllerAnimated:YES];
}


- (void)maru
{
    //サウンド
    [self soundPlay:@"pinpon" type:@"caf" volume:1.0f];

    [self performSelector:@selector(next) withObject:nil afterDelay:1.0f];
}

- (void)batsu
{
    //サウンド
    [self soundPlay:@"boo" type:@"caf" volume:1.0f];

    [self performSelector:@selector(gameOver) withObject:nil afterDelay:1.0f];
}


- (void)startGame
{
    [self setStage];
    [self setAdView];


    //BGM
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"timer" ofType:@"caf"];
        NSURL *url = [NSURL fileURLWithPath:path];

        audioBGM = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        audioBGM.volume = 0.3f;

//        [self soundPlayTimer];
    }

    audioTouch = nil;

    //開始
    [self performSelector:@selector(hideTitle) withObject:nil afterDelay:TIME_SHOW_TITLE];
}


- (void)setStage
{
    //チャンスボタン非表示
    self.buttonReplay.enabled = YES;
    self.buttonReplay.alpha = 0.0f;

    //この時点で回答操作不可能とする(画像2を表示した時点で操作可能とする)
    self.imageViewStage.userInteractionEnabled = NO;

    //タイトル画像
    {
        CGRect rect = self.imageViewStage.frame;
//        NSString * stageTitleName = [NSString stringWithFormat:@"t%02d.png", self.stageId];
        NSString * stageTitleName = [self.stageData objectForKey:@"titleImage"];

        imageViewStageTitle = [[UIImageView alloc] initWithFrame:rect];
        imageViewStageTitle.image = [UIImage imageNamed:stageTitleName];

        [self.view addSubview:imageViewStageTitle];
    }
}


//広告
- (void) setAdView
{
    //AdMaker
    /*
     {
     _adMaker = [[AdMakerView alloc]init];
     [self.adMaker setAdMakerDelegate:self];
     self.adMaker.view.backgroundColor = [UIColor clearColor];
     //[_adMaker setFrame:CGRectMake(0,430,320,50)];
     //[_adMaker start];
     }
     */

    //Adlantis Setting
    /*
     {
     AdlantisAdManager.sharedManager.publisherID = @"MTA3OTU%3D%0A";

     CGSize suggestedViewSize = AdlantisViewSizeForOrientation (UIInterfaceOrientationPortrait); 
     BOOL adAtTop = NO; 
     //CGRect adViewFrame = self.tableView.bounds;
     //adViewFrame.origin.y = 0;
     //adViewFrame.size.height = 50;
     CGRect adViewFrame = CGRectMake(0,430,320,50);
     AdlantisView *adView = [[[AdlantisView alloc] initWithFrame:adViewFrame] autorelease]; 
     //AdlantisView *adView = [[[AdlantisView alloc]init] autorelease];
     adView.backgroundColor = [UIColor clearColor];
     //[adView setFrame:adViewFrame];
     [self.view addSubview:adView];
     //[self.parentViewController.view addSubview:adView];
     }
     */

    //AmoAdo
    {
        CGRect rc = CGRectMake(0, 320 - ADVIEW_BANNER_SIZE_HEIGHT, ADVIEW_BANNER_SIZE_WIDTH, ADVIEW_BANNER_SIZE_HEIGHT);
        self.adCloudView = [[AMoAdView alloc] initWithFrame:rc];
//        _adCloudView = [[AMoAdView alloc] initWithFrame:CGRectZero];

        self.adCloudView.currentContentSizeIdentifier = AMoAdContentSizeIdentifierLandscape;
        self.adCloudView.sid = @"62056d310111552c5dd3d5b6ff7f880d4539dc98a6c89cc50040998fabb3983e";
        self.adCloudView.delegate = self;

        [self.adCloudView displayAd];

        [self.view addSubview:self.adCloudView];
        //[self.view sendSubviewToBack:self.adCloudView];
    }
}



//- (NSData *)getUrlData:(NSString *)url
//{
//    NSURLRequest *request = [NSURLRequest requestWithURL:
//                             [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
//                                             cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
//    NSURLResponse *response;
//    NSError       *error;
//    NSData *result = [NSURLConnection sendSynchronousRequest:request 
//                                           returningResponse:&response error:&error];
//
//    if (result == nil)
//    {
//        NSLog(@"NSURLConnection error %@", error);
//    }
//
//    return result;
//}
//
//- (UIImage *)getImage:(NSString *)url
//{
//    return [UIImage imageWithData:[self getUrlData:url]];
//}


#pragma mark - View lifecycle

- (id) initWithStageId:(int)stageId
{
    self = [super initWithNibName:@"FlipsideViewController" bundle:nil];
    if (self)
    {
        _stageId   = stageId;
        _stageData = [[CorrectAreaPlist readPlist:self.stageId] retain];

        _limitTimer = nil;
        _limit      = 10;
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];

    //制限時間(カウントダウン)
    self.countDownImage.alpha = 0.0f;


    //ゲーム画像
    self.imageViewStage.userInteractionEnabled = NO;
    self.imageViewStage.imageViewDelete = self;
    self.imageViewStage.frame = CGRectMake(0, 0, 480, 320 - ADVIEW_BANNER_SIZE_HEIGHT);

    self.imgTouchPoint.alpha = 0.0f;


    //チャンスボタン非表示
    self.buttonReplay.enabled = YES;
    self.buttonReplay.alpha = 0.0f;


    if (self.isShowHowTo)
    {
        self.imgHowTo.alpha         = 1.0f;
        self.imgBackHowTo.alpha     = 1.0f;
        self.buttonBackHowTo.alpha  = 1.0f;
    }
    else
    {
        self.imgHowTo.alpha         = 0.0f;
        self.imgBackHowTo.alpha     = 0.0f;
        self.buttonBackHowTo.alpha  = 0.0f;

        [self startGame];
    }


//デバッグ用
#ifdef DEBUG_GAME_DRAW_FRAME
    //画像の枠
    {
        CALayer * layer = self.imageViewStage.layer;
        CALayer * dbglayer = [CALayer layer];

        CGRect rc = [CorrectAreaPlist getFrame:self.stageData];
        dbglayer.frame = rc;

        dbglayer.borderWidth   = 2.0f;
        dbglayer.borderColor   = [UIColor redColor].CGColor;
        dbglayer.cornerRadius  = 4.0f;
        dbglayer.masksToBounds = YES;

        [layer addSublayer:dbglayer];
    }
#endif
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    [self performSelector:@selector(hideTitle) withObject:nil afterDelay:TIME_SHOW_TITLE];
//}

- (void)viewDidUnload
{
    self.adMaker = nil;
    self.adCloudView  = nil;

    self.imageViewStage = nil;
    self.imgTouchPoint = nil;
    self.buttonReplay = nil;

    if (imageViewStageTitle)
    {
        [imageViewStageTitle release], imageViewStageTitle = nil;
    }

    if (audioBGM)
    {
        [audioBGM stop];
    }
    [audioBGM release], audioBGM = nil;

    if (audioTouch)
    {
        [audioTouch stop];
    }
    [audioTouch release], audioTouch = nil;

    [self setImgTouchPoint:nil];
    [self setCountDownImage:nil];
    [self setImgHowTo:nil];
    [self setImgBackHowTo:nil];
    [self setButtonBackHowTo:nil];

    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc. that aren't in use.
}

- (void)dealloc
{
    [_adMaker release], _adMaker = nil;
    [_adCloudView release], _adCloudView = nil;

    if (imageViewStageTitle)
    {
        [imageViewStageTitle release], imageViewStageTitle = nil;
    }

    [_imageViewStage release], _imageViewStage = nil;
    [_imgTouchPoint release],  _imgTouchPoint = nil;
    [_buttonReplay release],   _buttonReplay = nil;
    [_countDownImage release], _countDownImage = nil;

    [_imgHowTo release],        _imgHowTo = nil;
    [_imgBackHowTo release],    _imgBackHowTo = nil;
    [_buttonBackHowTo release], _buttonBackHowTo = nil;


    [_stageData release], _stageData = nil;


    if (_limitTimer)
    {
        [_limitTimer invalidate];
        _limitTimer = nil;
    }

    if (audioBGM)
    {
        [audioBGM stop];
    }
    [audioBGM release], audioBGM = nil;

    if (audioTouch)
    {
        [audioTouch stop];
    }
    [audioTouch release], audioTouch = nil;


    [super dealloc];
}


-(void)viewWillAppear:(BOOL)animated
{
    //[AdMaker viewWillAppear];
//    [self.adCloudView displayAd];
}

-(void)viewWillDisappear:(BOOL)animated
{
    //[AdMaker viewWillDisappear];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return ((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||
            (interfaceOrientation == UIInterfaceOrientationLandscapeRight));
}


#pragma mark - Actions

//もう一度だけ画像切り替えアニメーション
- (IBAction)tapReplay:(id)sender
{
    //タイマーリセット (タイマー再開は slideImage メソッド内で処理)
    [_limitTimer invalidate];
    self.countDownImage.alpha = 0.0f;


    //サウンド
    [self soundPlay:@"tap" type:@"mp3" volume:1.0f];

    [audioBGM stop];

    //チャンスは一度だけ(ボタン非表示)
    self.buttonReplay.enabled = NO;
    self.buttonReplay.alpha = 0.0f;


    //この時点で回答操作不可能とする(画像2を表示した時点で操作可能とする)
    self.imageViewStage.userInteractionEnabled = NO;


    //暗幕
    self.imageViewStage.image = [UIImage imageNamed:@"black_screen.png"];


    //スライド処理開始
    //暗幕(1.0s) -> 画像1 -> 暗幕 -> 画像2 の切り替え...
    [self performSelector:@selector(slideImage:)
               withObject:[NSNumber numberWithInt:0]
               afterDelay:TIME_SHOW_BLACK];
}


//HowTo
- (IBAction)tapButtonBackHowTo:(id)sender
{
    [self soundPlay:@"tap" type:@"mp3" volume:1.0f];

    [UIView animateWithDuration:1.0f
                     animations:^{

                         self.imgHowTo.alpha        = 0.0f;
                         self.imgBackHowTo.alpha    = 0.0f;
                         self.buttonBackHowTo.alpha = 0.0f;

                     } completion:^(BOOL finished) {

                         [self startGame];
                     }];
}


#pragma mark - UIImageViewExDelegate

- (void)image:(UIImageView *)image touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    image.userInteractionEnabled = NO;

    [audioBGM stop];
    [audioBGM release], audioBGM = nil;


    UITouch * touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];

//    NSLog(@"%s touch=[%@], pt=(%.2lf, %.2lf)", __func__, touch, pt.x, pt.y);


    CGRect rc = [CorrectAreaPlist getFrame:self.stageData];

    NSString * imgFileName;

    //正解エリア内であれば
    if (CGRectContainsPoint(rc, pt))
    {
        //正解処理
        imgFileName = @"maru_red.png";
        [self maru];
//        [self performSelector:@selector(maru) withObject:nil afterDelay:0.2f];
    }
    else
    {
        //不正解処理
        imgFileName = @"batsu_red.png";
        [self batsu];
//        [self performSelector:@selector(batsu) withObject:nil afterDelay:0.2f];
    }

    //正解不正解表示
    {
        self.imgTouchPoint.alpha = 1.0f;
        self.imgTouchPoint.image = [UIImage imageNamed:imgFileName];

        //表示位置 = タッチした位置
        CGRect frame = self.imgTouchPoint.frame;
        frame.origin = CGPointMake(pt.x - (frame.size.width * 0.5f),
                                   pt.y - (frame.size.height * 0.5f));
        self.imgTouchPoint.frame = frame;

        [self.view bringSubviewToFront:self.imgTouchPoint];
    }
}

@end
