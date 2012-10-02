//
//  UserDefault.m
//  The1minShow4
//
//  Created by  on 12/05/31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserDefault.h"
#import "CorrectAreaPlist.h"


//キー名
#define kStageId                    @"stageId"
#define kClearStageCount            @"clearStageCount"
#define kIsCheckClearCollection     @"isCheckClearCollection"


@interface UserDefault ()
//{
//}

+ (int)  getStandarUserDefaults:(NSString *)key;
+ (void) setStandardUserDefaults:(NSString *)key value:(int)value;

@end


@implementation UserDefault

#pragma mark - Private Method

+ (int) getStandarUserDefaults:(NSString *)key
{
    int result;

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    result = [userDefaults integerForKey:key];

    return result;
}

+ (void) setStandardUserDefaults:(NSString *)key value:(int)value
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    [userDefaults setInteger:value
                      forKey:key];

    [userDefaults synchronize];
}


#pragma mark - ゲームコンティニュー用
+ (int) getStageId
{
    int result = [self getStandarUserDefaults:kStageId];

    return (result < 1)?(1):(result);
}

+ (void) setStageId:(int)stageId
{
    if (stageId > 0)
    {
        [self setStandardUserDefaults:kStageId
                                value:stageId];
    }
}


#pragma mark - コレクション用 ステージカウント
+ (int) getClearStageCount
{
    int result = [self getStandarUserDefaults:kClearStageCount];

    return (result < 1)?(0):(result);
}

+ (void) setClearStageCount:(int)stageId
{
    if (stageId > [self getClearStageCount])
    {
        //一面ずつ順クリしていくので クリアステージ数 = ステージID とする
        [self setStandardUserDefaults:kClearStageCount
                                value:stageId];
    }
}

+ (void) resetClearStageCount
{
    [self setStandardUserDefaults:kClearStageCount
                            value:0];
}


#pragma mark - コレクションクリア確認
+ (BOOL) getIsCheckClearCollection
{
    int result = [self getStandarUserDefaults:kIsCheckClearCollection];

    return (result == 1)?(YES):(NO);
}

+ (void) setIsCheckClearCollection:(BOOL)isCheck
{
    [self setStandardUserDefaults:kIsCheckClearCollection
                            value:((isCheck == YES)?(1):(0))];
}

@end
