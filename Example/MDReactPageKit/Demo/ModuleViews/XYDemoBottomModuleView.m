//
//  MDDemoBottomModuleView.m
//  MDReactPageKit_Example
//
//  Created by lizitao on 2018/9/28.
//  Copyright © 2018年 leon0206. All rights reserved.
//

#import "MDDemoBottomModuleView.h"
@interface MDDemoBottomModuleView ()
@property (nonatomic, strong) UILabel *indexLabel;
@end


@implementation MDDemoBottomModuleView

- (BOOL)isModuleNeedFixed
{
    return YES;
}

- (void)loadModuleSubViews
{
    self.backgroundColor = [UIColor yellowColor];
    self.indexLabel = [UILabel new];
    self.indexLabel.font = [UIFont systemFontOfSize:14.f];
    self.indexLabel.textColor = [UIColor blackColor];
    self.indexLabel.numberOfLines = 1;
    self.indexLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.indexLabel];
    @weakify(self);
    [[self.blackBoard signalForKey:@"md_module_0_key"] subscribeNext:^(NSString *x) {
        @strongify(self);
        self.indexLabel.text = x;
       [self.indexLabel sizeToFit];
    }];
}

- (void)loadModuleData:(id)model
{
    self.indexLabel.text = [[NSString alloc]initWithFormat:@"bottom module  %ld",self.moduleIndex];
    
}

- (void)layoutModuleWidth:(CGFloat)viewWidth
{
    CGFloat y = [UIScreen mainScreen].bounds.size.height - 100;
    self.frame = CGRectMake(0, y, viewWidth, 100.0);
    [self.indexLabel sizeToFit];
    self.indexLabel.centerX = self.frame.size.width / 2;
    self.indexLabel.centerY = self.frame.size.height / 2;
}

- (void)moduleWillAppear
{
    
}

- (void)moduleDidAppear
{
    
}


- (void)moduleWillDisappear
{
    
}


@end
