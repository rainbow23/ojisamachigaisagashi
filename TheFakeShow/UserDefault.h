//
//  UserDefault.h
//  The1minShow4
//
//  Created by  on 12/05/31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserDefault : NSObject

//@property (nonatomic, assign) int stageId;
//@property (nonatomic, assign) int clearStageCount;

//ゲームコンティニュー用
+ (int) getStageId;
+ (void) setStageId:(int)stageId;

//コレクション用 ステージカウント
+ (int) getClearStageCount;
+ (void) setClearStageCount:(int)stageId;
+ (void) resetClearStageCount;

//コレクションクリア確認
+ (BOOL) getIsCheckClearCollection;
+ (void) setIsCheckClearCollection:(BOOL)isCheck;

@end
