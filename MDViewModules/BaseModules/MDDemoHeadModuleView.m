//
//  MDDemoHeadModuleView.m
//  MDProject
//
//  Created by lizitao on 2017/5/13.
//  Copyright © 2017年 lizitao. All rights reserved.
//

#import "MDDemoHeadModuleView.h"

@interface MDDemoHeadModuleView ()

@end
@implementation MDDemoHeadModuleView

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor lightGrayColor];
   
    }
    return self;
}

- (void)loadViewWithData:(id)model
{
    self.indexLabel.text = [[NSString alloc]initWithFormat:@"Module %ld",self.index];
    
}

- (void)layoutViewWithWidth:(CGFloat)viewWidth
{
    self.frame = CGRectMake(0, 0, viewWidth, 100.0);
    [self.indexLabel sizeToFit];
    self.indexLabel.centerX = self.frame.size.width / 2;
    self.indexLabel.centerY = self.frame.size.height / 2;
    
}

@end
