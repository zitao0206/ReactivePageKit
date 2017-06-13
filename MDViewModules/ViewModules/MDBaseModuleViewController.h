//
//  MDBaseModuleViewController.h
//  MDProject
//
//  Created by lizitao on 2017/5/13.
//  Copyright © 2017年 lizitao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDBaseModuleViewController : UIViewController

@property (nonatomic, strong) UIView *contentView;

//刷次所有模块
- (void)refreshContentSubviews;
//刷次某一模块
- (void)refreshContentSubviewWithIndex:(NSUInteger)idx;

@end
