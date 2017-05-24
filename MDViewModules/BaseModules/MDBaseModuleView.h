//
//  MDBaseModuleView.h
//  MDProject
//
//  Created by lizitao on 2017/5/13.
//  Copyright © 2017年 lizitao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MDBaseViewDelegate.h"
#import "UIView+ResizeFrame.h"

@interface MDBaseModuleView : UIView
@property (nonatomic, strong) RACSubject *heightChangeSignal;
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, strong) UILabel *indexLabel;
@end
