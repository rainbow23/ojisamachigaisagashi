//
//  CorrectAreaPlist.h
//  The1minShow4
//
//  Created by  on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#define CORRECTAREA_KEY__RECT_LEFT   @"left"
#define CORRECTAREA_KEY__RECT_TOP    @"top"
#define CORRECTAREA_KEY__RECT_WIDTH  @"width"
#define CORRECTAREA_KEY__RECT_HEIGHT @"height"

#define CORRECTAREA_KEY__IMG_BEFORE  @"beforeImage"
#define CORRECTAREA_KEY__IMG_AFTER   @"afterImage"


@interface CorrectAreaPlist : NSObject

+ (int)countStage;
+ (NSArray *)readPlist;
+ (NSDictionary *)readPlist:(int)stageId;

+ (CGRect)getFrame:(NSDictionary *)stageData;

@end
