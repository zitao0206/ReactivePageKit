//
//  MDDemoMiddleModuleView.m
//  MDReactPageKit_Example
//
//  Created by lizitao on 2018/9/28.
//  Copyright © 2018年 leon0206. All rights reserved.
//

#import "MDDemoMiddleModuleView.h"
@interface MDDemoMiddleModuleView ()
@property (nonatomic, strong) UILabel *indexLabel;
@end

@implementation MDDemoMiddleModuleView

- (void)loadModuleSubViews
{
//    [self performSelector:@selector(test) withObject:self afterDelay:3.f];
    self.backgroundColor = [UIColor redColor];
    self.indexLabel = [UILabel new];
    self.indexLabel.font = [UIFont systemFontOfSize:14.f];
    self.indexLabel.textColor = [UIColor blueColor];
    self.indexLabel.numberOfLines = 1;
    self.indexLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.indexLabel];
}

- (void)loadModuleData:(id)model
{
    self.indexLabel.text = [[NSString alloc]initWithFormat:@"middle module %ld",self.moduleIndex];
    
}

- (void)layoutModuleWidth:(CGFloat)viewWidth
{
    self.frame = CGRectMake(0, 0, viewWidth, 100.0);
    [self.indexLabel sizeToFit];
    self.indexLabel.centerX = self.frame.size.width / 2;
    self.indexLabel.centerY = self.frame.size.height / 2;
}

- (void)test
{
    self.height = self.height + 30;
}

@end
