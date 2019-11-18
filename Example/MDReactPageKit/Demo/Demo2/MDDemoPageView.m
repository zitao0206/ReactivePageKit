//
//  MDDemoPageView.m
//  MDReactPageKit_Example
//
//  Created by lizitao on 2018/9/28.
//  Copyright © 2018年 leon0206. All rights reserved.
//

#import "MDDemoPageView.h"

@implementation MDDemoPageView

- (NSArray *)moduleViews
{
    return @[
             @"MDDemoHeadModuleView",
             @"MDDemoMiddleModuleView",
             @"MDDemoMiddleModuleView",
             @"MDDemoMiddleModuleView",
             @"MDDemoMiddleModuleView",
             @"MDDemoBottomModuleView",
             ];
}

- (CGFloat)spaceBetweenModuleViews
{
    return 15.0;
}

@end
