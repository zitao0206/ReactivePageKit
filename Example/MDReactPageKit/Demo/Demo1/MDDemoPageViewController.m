//
//  MDDemoPageViewController.m
//  MDReactPageKit_Example
//
//  Created by lizitao on 2018/9/28.
//  Copyright © 2018年 leon0206. All rights reserved.
//

#import "MDDemoPageViewController.h"
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([@"10.0" compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([@"10.0" compare:v options:NSNumericSearch] == NSOrderedAscending)


@interface MDDemoPageViewController ()
@property (nonatomic, strong) UILabel *indexLabel;
@end

@implementation MDDemoPageViewController

- (void)dealloc
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    MDDemoBaseModel *model = [MDDemoBaseModel new];
    model.title = @"名称";
    self.model = model;
    @weakify(self);
    [[self.blackBoard addObserver:self forKey:@"MD_title_key"] subscribeNext:^(NSString *x) {
        @strongify(self);
        if (x.length > 0) {
            self.title = x;
        }
    }];
//    self.navigationController.navigationBar.hidden = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self refreshModuleViewsWithIndex:2];
    });
}

- (NSArray *)moduleViews
{
    return @[
//             @"MDDemoNavigatorModuleView",
             @"MDDemoHeadModuleView",
             @"MDDemoMiddleModuleView",
             @"MDDemoMiddleModuleView",
             @"MDDemoMiddleModuleView",
             @"MDDemoMiddleModuleView",
             @"MDDemoMiddleModuleView",
             @"MDDemoMiddleModuleView",
             @"MDDemoBottomModuleView",
            ];
}

- (CGFloat)contentViewWidth
{
    return [self screenWidth] - 30;
}


- (CGFloat)spaceBetweenModuleViews
{
    return 15.0;
}

- (BOOL)bouncesEnabled
{
    return YES;
}

- (BOOL)alwaysBounceVertical
{
    return YES;
}

- (CGFloat)screenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

@end
