//
//  MDDemoSubViewViewController.m
//  MDReactPageKit_Example
//
//  Created by lizitao on 2018/9/28.
//  Copyright © 2018年 leon0206. All rights reserved.
//

#import "MDDemoSubViewViewController.h"
#import "MDDemoPageView.h"
#import "MDDemoBaseModel.h"

@interface MDDemoSubViewViewController ()

@end

@implementation MDDemoSubViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    MDDemoPageView *pageView = [[MDDemoPageView alloc]initWithFrame:CGRectMake(15, 100, 300, 500)];
    pageView.backgroundColor = [UIColor lightGrayColor];
    
    MDDemoBaseModel *model = [MDDemoBaseModel new];
    model.title = @"hello world";
    pageView.model = model;
    
    [self.view addSubview:pageView];
}


@end
