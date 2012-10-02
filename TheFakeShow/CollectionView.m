//
//  CollectionView.m
//  TheFakeShow
//
//  Created by Masato Fukano on 11/08/16.
//  Copyright 2011年 Goodia Inc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "CollectionView.h"

#import "UserDefault.h"
#import "CorrectAreaPlist.h"


//指定済み 画像サイズ (等倍)
#define IMG_WIDTH           480
#define IMG_HEIGHT          288


#define FRAME_COLS_COUNT    3
#define FRAME_SIZE_WIDTH    140
#define FRAME_SIZE_HEIGHT   ( (((float)IMG_HEIGHT)/IMG_WIDTH) * (FRAME_SIZE_WIDTH) )
#define FRAME_SPAN          ( (480.0f - (float)(FRAME_SIZE_WIDTH * FRAME_COLS_COUNT))/(FRAME_COLS_COUNT + 1) )


@interface CollectionView ()
//{
//}

//サウンド
- (void)soundPlay:(NSString *)fileName type:(NSString *)typeName volume:(float)volume;

- (void) setContents;
- (void) setUIImageView:(UIImageViewEx *)imageView Index:(int)index delegate:(id<UIImageViewExDelegate>)delegate;

@end


@implementation CollectionView

@synthesize delegate = _delegate;

@synthesize pageView    = _pageView;
@synthesize scrollView  = _scrollView;
@synthesize photoBack   = _photoBack;
@synthesize buttonBack  = _buttonBack;


#pragma mark - Private Method

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

- (void) setContents
{
    int count   = [CorrectAreaPlist countStage];
    int clearId = [UserDefault getClearStageCount];


    NSString * strFile;

    //問題用画像
    for (int i = 0; i < ((count/FRAME_COLS_COUNT)+1); i++)
    {
        for (int j = 0; j < FRAME_COLS_COUNT; j++)
        {
            int stageId = ((i * FRAME_COLS_COUNT) + j) + 1;

            if (stageId > count)
            {
                break;
            }

            //ファイル名
            {
                strFile = nil;

                //クリア済みのステージならば
                if (stageId <= clearId)
                {
                    //ステージの画像
                    NSDictionary * dic = [CorrectAreaPlist readPlist:stageId];
                    if (dic)
                    {
                        strFile = [dic objectForKey:CORRECTAREA_KEY__IMG_BEFORE];
                    }
                }

                if (!strFile)
                {
                    strFile = @"collection_empty1.png";
                }
            }

            //リソースの画像を参照
            UIImage * image = [UIImage imageNamed:strFile];

            if (image)
            {
                UIImageViewEx * imageView = [[[UIImageViewEx alloc] initWithImage:image] autorelease];

                //UIImageViewの表示設定
                [self setUIImageView:imageView Index:stageId delegate:((stageId<=clearId)?(self):(nil))];

                //UIImageViewをViewの上に配置
                [self.pageView addSubview:imageView];
            }
        }
    }

    //エンディング画像
    {
        NSString * strFile;

        strFile = @"collection_empty2.png";
        if (count == clearId)
        {
            strFile = @"end-gamen.png";
        }

        //リソースの画像を参照
        UIImage * image = [UIImage imageNamed:strFile];

        if (image)
        {
            UIImageViewEx * imageView = [[[UIImageViewEx alloc] initWithImage:image] autorelease];

            //UIImageViewの表示設定
            [self setUIImageView:imageView Index:(count+1) delegate:((count == clearId)?(self):(nil))];

            //UIImageViewをViewの上に配置
            [self.pageView addSubview:imageView];
        }
    }

    //土台となるビューのサイズを調整
    {
        CGRect frame = self.pageView.frame;
        frame.size.height = (((count / FRAME_COLS_COUNT) + 1) * (FRAME_SPAN + FRAME_SIZE_HEIGHT)) + FRAME_SPAN;
        self.pageView.frame = frame;
    }
}


- (void) setUIImageView:(UIImageViewEx *)imageView Index:(int)index delegate:(id<UIImageViewExDelegate>)delegate
{
    //前提条件
    if(!imageView)
    {
        return;
    }

    imageView.contentMode            = UIViewContentModeScaleAspectFill;
    imageView.tag                    = index;
    imageView.imageViewDelete        = delegate;
    imageView.userInteractionEnabled = YES;
    imageView.autoresizingMask       = UIViewAutoresizingNone;

    //サイズ
    {
        CGRect frame    = imageView.frame;
        frame.size      = CGSizeMake(FRAME_SIZE_WIDTH, FRAME_SIZE_HEIGHT);
        imageView.frame = frame;
    }

    //表示位置
    {
        int x = (FRAME_SPAN * (((index-1) % FRAME_COLS_COUNT) + 1)) + (FRAME_SIZE_WIDTH  * ((index-1) % FRAME_COLS_COUNT)) + (FRAME_SIZE_WIDTH  * 0.5f);
        int y = (FRAME_SPAN * (((index-1) / FRAME_COLS_COUNT) + 1)) + (FRAME_SIZE_HEIGHT * ((index-1) / FRAME_COLS_COUNT)) + (FRAME_SIZE_HEIGHT * 0.5f);

        imageView.center = CGPointMake(x, y);
    }

//    //画像の枠
//    {
//        CALayer * layer = imageView.layer;
//
//        layer.borderWidth   = 2.0f;
//        layer.borderColor   = [UIColor lightGrayColor].CGColor;
////        layer.cornerRadius  = 8.0f;
//        layer.masksToBounds = YES;
//    }
}


#pragma mark - Actions

- (IBAction)back:(id)sender
{
    //サウンド
    [self soundPlay:@"tap" type:@"mp3" volume:1.0f];

    if ([(id)self.delegate respondsToSelector:@selector(backFromCollection)])
    {
        [self.delegate backFromCollection];
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
        photoDetail = nil;
        photoTitle  = nil;
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
    // Do any additional setup after loading the view from its nib.

    self.photoBack.alpha = 0.0f;

    //スクロールする対象のビューの設定
    [self setContents];


    //スクロールビューの設定
    {
//        self.scrollView.delegate = self;

        //スクロールさせたいビューの設定
        [self.scrollView addSubview:self.pageView];

        self.scrollView.contentSize = [self.pageView sizeThatFits:CGSizeZero];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.pagingEnabled = NO;
    }
}

- (void)viewDidUnload
{
    self.pageView = nil;
    self.scrollView = nil;

    self.photoBack = nil;

    if (photoDetail)
    {
        [photoDetail release], photoDetail = nil;
    }

    if (photoTitle)
    {
        [photoTitle release], photoTitle = nil;
    }

    if (audioTouch)
    {
        [audioTouch stop];
    }
    [audioTouch release], audioTouch = nil;

    [self setButtonBack:nil];
    [super viewDidUnload];
}

- (void)dealloc
{
    [_pageView release], _pageView = nil;
    [_scrollView release], _scrollView = nil;
    [_photoBack release], _photoBack = nil;
    [_buttonBack release], _buttonBack = nil;

    if (photoDetail)
    {
        [photoDetail release], photoDetail = nil;
    }

    if (photoTitle)
    {
        [photoTitle release], photoTitle = nil;
    }

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


#pragma mark - UIImageViewExDelegate

- (void)image:(UIImageView *)image touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s tag=%d", __func__, image.tag);

    int stageId = image.tag;


    if (stageId > 0)
    {
        //詳細表示時は何もしない
        if (self.photoBack.alpha != 0.0f)
        {
            //何もしない
            return;
        }
    }


    //サウンド
    [self soundPlay:@"tap" type:@"mp3" volume:1.0f];

    if (stageId > 0)
    {
        if (photoTitle)
        {
            [photoTitle release], photoTitle = nil;
        }

        //タイトル
        if (stageId <= 20)
        {
            NSString * strFileName = [NSString stringWithFormat:@"l%02d.png", stageId];

            photoTitle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:strFileName]];

            //フレームの設定
            {
                CGRect frame = photoTitle.frame;

                //画面下
                frame.origin.x = (480 - frame.size.width) * 0.5f;
                frame.origin.y = 320 - frame.size.height;

                photoTitle.frame = frame;
            }
        }

        //おたから画像
        {
            if (photoDetail)
            {
                [photoDetail release], photoDetail = nil;
            }

            photoDetail = [[UIImageViewEx alloc] initWithImage:image.image];

            photoDetail.userInteractionEnabled = YES;
            photoDetail.imageViewDelete = self;

            photoDetail.tag = -1;

            //フレームの設定
            {
                CGRect frame = photoDetail.frame;

                //サイズをちょっと小さくする
                const float frame_rate = (photoTitle)?(0.8f):(0.9f);
                frame.size.width  *= frame_rate;
                frame.size.height *= frame_rate;

                //画面中央
                frame.origin.x = (480 - frame.size.width) * 0.5f;
//                frame.origin.y = (320 - frame.size.height) * 0.5f;
                if (photoTitle)
                {
                    frame.origin.y = ((320 - photoTitle.frame.size.height) - frame.size.height) * 0.5f + 10.0f;
                }
                else
                {
                    frame.origin.y = (320 - frame.size.height) * 0.5f;
                }

                photoDetail.frame = frame;
            }

//            //画像の枠
//            {
//                CALayer * layer = photoDetail.layer;
//
//                layer.borderWidth   = 2.0f;
//                layer.borderColor   = [UIColor lightGrayColor].CGColor;
//                layer.cornerRadius  = 4.0f;
//                layer.masksToBounds = YES;
//            }
        }


        //戻るボタンを使用不可に
        self.buttonBack.enabled = NO;

        //リストのタッチ操作を一時的に受け付けないようにする
        self.scrollView.userInteractionEnabled = NO;

        //半透明の背景を前面に移動
        self.photoBack.alpha = 1.0f;
        [self.view bringSubviewToFront:self.photoBack];

        //詳細画面を表示
        [self.view addSubview:photoTitle];
        [self.view addSubview:photoDetail];
    }
    else
    {
        if (photoTitle)
        {
            //タイトルを取り除く
            [photoTitle removeFromSuperview];
        }
        if (photoDetail)
        {
            //詳細画面を取り除く
            [photoDetail removeFromSuperview];
        }

        //半透明の背景をz軸後ろに移動
        self.photoBack.alpha = 0.0f;
        [self.view sendSubviewToBack:self.photoBack];

        //リストのタッチ操作を受け付けるように戻す
        self.scrollView.userInteractionEnabled = YES;

        //戻るボタンを使用可能に戻す
        self.buttonBack.enabled = YES;
    }
}


//#pragma mark - UIScrollViewDelegate
//
////ステータスバーをタップした時にスクロール位置をTOPに戻すかどうか
//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
//{
//    return YES;
//}
//
////拡大縮小の対象となるViewを指定
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//    return self.pageView;
//}

@end
