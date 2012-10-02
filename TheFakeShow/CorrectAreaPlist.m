//
//  CorrectAreaPlist.m
//  The1minShow4
//
//  Created by  on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CorrectAreaPlist.h"


@implementation CorrectAreaPlist

//ステージ数
+ (int)countStage
{
    NSArray * array = [CorrectAreaPlist readPlist];

    return (array)?([array count]):(0);
}


//ステージデータ(配列)
+ (NSArray *)readPlist
{
    NSArray * array = nil;
    {
        NSString * path      = [[NSBundle mainBundle] pathForResource:@"CorrectArea" ofType:@"plist"];
        NSDictionary * plist = [NSDictionary dictionaryWithContentsOfFile:path];
        array                = [plist objectForKey:@"Root"];
    }

//    NSLog(@"%s %@", __func__, array);
    return array;
}


//ステージデータ(1ステージ分)
+ (NSDictionary *)readPlist:(int)stageId
{
    NSDictionary * dic = nil;

    NSArray * array = [CorrectAreaPlist readPlist];

    if (array)
    {
        int indexId = (stageId - 1);

        if ((0 <= indexId) && (indexId < [array count]))
        {
            dic = (NSDictionary *)[array objectAtIndex:indexId];
        }
    }

//    NSLog(@"%s %@", __func__, dic);
    return dic;
}


+ (CGRect)getFrame:(NSDictionary *)stageData
{
    CGRect rc = CGRectZero;

    if (stageData)
    {
        int left   = [[stageData objectForKey:CORRECTAREA_KEY__RECT_LEFT] intValue];
        int top    = [[stageData objectForKey:CORRECTAREA_KEY__RECT_TOP] intValue];
        int width  = [[stageData objectForKey:CORRECTAREA_KEY__RECT_WIDTH] intValue];
        int height = [[stageData objectForKey:CORRECTAREA_KEY__RECT_HEIGHT] intValue];

        rc = CGRectMake((CGFloat)left, (CGFloat)top, (CGFloat)width, (CGFloat)height);
    }

    return rc;
}

@end
