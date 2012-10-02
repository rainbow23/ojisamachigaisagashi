//
//  UIImageViewEx.h
//
//  Created by  on 12/05/29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
// *** 注意事項 ***
// タップ操作を取得するには userInteractionEnabled プロパティを有効にすること
// (Interface Builderでも設定可)


#import <UIKit/UIKit.h>


@protocol UIImageViewExDelegate;


@interface UIImageViewEx : UIImageView
{
    @private
    id<UIImageViewExDelegate> imageViewDelete_;
}

@property (nonatomic, assign) id<UIImageViewExDelegate> imageViewDelete;

@end


@protocol UIImageViewExDelegate <NSObject>

@optional
- (void) image:(UIImageView *)image touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end
