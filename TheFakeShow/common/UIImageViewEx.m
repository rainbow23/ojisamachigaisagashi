//
//  UIImageViewEx.m
//
//  Created by  on 12/05/29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIImageViewEx.h"


@implementation UIImageViewEx

@synthesize imageViewDelete = imageViewDelete_;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.imageViewDelete respondsToSelector:@selector(image:touchesBegan:withEvent:)])
    {
        [self.imageViewDelete image:self touchesBegan:touches withEvent:event];
    }
}

@end
