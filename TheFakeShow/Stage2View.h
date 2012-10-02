//
//  Stage2View.h
//  TheFakeShow
//
//  Created by Masato Fukano on 11/08/10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Stage2View;

@protocol Stage2ViewDelegate
- (void)nextStage2:(Stage2View *)controller;
@end

@interface Stage2View : UIViewController {
    UIImageView *imageViewStageTitle;
    
    IBOutlet UIImageView *imageViewMaru1;
    IBOutlet UIImageView *imageViewMaru2;
    IBOutlet UIImageView *imageViewMaru3;
    IBOutlet UIImageView *imageViewBatsu1;
    IBOutlet UIImageView *imageViewBatsu2;
    IBOutlet UIImageView *imageViewBatsu3;
    IBOutlet UIImageView *imageViewIndicator1;
    IBOutlet UIImageView *imageViewIndicator2;
    IBOutlet UIImageView *imageViewIndicator3;
    IBOutlet UIImageView *imageViewIndicator4;
    IBOutlet UIImageView *imageViewIndicator5;
    IBOutlet UIImageView *imageViewIndicator6;
    IBOutlet UIImageView *imageViewIndicator7;
    IBOutlet UIImageView *imageViewIndicator8;
    IBOutlet UIImageView *imageViewIndicator9;
    IBOutlet UIImageView *imageViewIndicator10;
    IBOutlet UIImageView *imageViewIndicator11;
    IBOutlet UIImageView *imageViewIndicator12;
    
}

@property (nonatomic, assign) id <Stage2ViewDelegate> delegate;

- (IBAction)next:(id)sender;

@end
