//
//  MDDemoNavigatorModuleView.m
//  MDReactPageKit_Example
//
//  Created by lizitao on 2018/10/8.
//  Copyright © 2018年 leon0206. All rights reserved.
//

#import "MDDemoNavigatorModuleView.h"
@interface MDDemoNavigatorModuleView ()
@property (nonatomic, strong) UILabel *indexLabel;
@end

@implementation MDDemoNavigatorModuleView

- (BOOL)isModuleNeedFixedToTop
{
    return YES;
}

- (void)loadModuleSubViews
{
    self.backgroundColor = [UIColor lightGrayColor];
    self.indexLabel = [UILabel new];
    self.indexLabel.font = [UIFont systemFontOfSize:14.f];
    self.indexLabel.textColor = [UIColor blackColor];
    self.indexLabel.numberOfLines = 1;
    self.indexLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.indexLabel];
}

- (void)loadModuleData:(id)model
{
    self.indexLabel.text = @"导航";
}

- (void)layoutModuleWidth:(CGFloat)viewWidth
{
    self.frame = CGRectMake(0, 0, viewWidth, 44.0);
    [self.indexLabel sizeToFit];
    self.indexLabel.centerX = self.frame.size.width / 2;
    self.indexLabel.centerY = self.frame.size.height / 2;
}

@end
