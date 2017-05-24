//
//  MDDemoModuleViewcomtroller.m
//  MDProject
//
//  Created by lizitao on 2017/5/13.
//  Copyright © 2017年 lizitao. All rights reserved.
//

#import "MDDemoModuleViewcomtroller.h"
#import "UIView+ResizeFrame.h"

@interface MDDemoModuleViewcomtroller ()

@end

@implementation MDDemoModuleViewcomtroller


- (void)viewDidLoad
{
    [super viewDidLoad];
    MDBaseModuleModel *model = [MDBaseModuleModel new];
    model.title = @"名称";
    self.model = model;
}

- (NSArray *)loadContentViews
{
    return @[@"MDDemoHeadModuleView",
             @"MDDemoBottomModuleView",
             @"MDDemoMiddleModuleView",
             @"MDDemoHeadModuleView",
             @"MDDemoMiddleModuleView",
             ];
}

- (CGFloat)contentViewWidth
{
    return [self screenWidth] - 30;
}

- (CGFloat)spacingBetweenSubviews
{
    return 15.0;
}

- (CGFloat)screenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}


@end
