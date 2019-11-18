//
//  MDDemoHeadModuleView.m
//  MDReactPageKit_Example
//
//  Created by lizitao on 2018/9/28.
//  Copyright © 2018年 leon0206. All rights reserved.
//

#import "MDDemoHeadModuleView.h"
#import <Masonry.h>
#import "MDReactPageDefinition.h"
@interface MDDemoHeadModuleView ()
@property (nonatomic, strong) UILabel *indexLabel;
@end

@implementation MDDemoHeadModuleView

- (BOOL)isModuleNeedFixedToTop
{
    return NO;
}

- (void)loadModuleSubViews
{
//    [self performSelector:@selector(test) withObject:self afterDelay:5.f];
    self.backgroundColor = [UIColor blackColor];
    self.indexLabel = [UILabel new];
    self.indexLabel.font = [UIFont systemFontOfSize:14.f];
    self.indexLabel.textColor = [UIColor blackColor];
    self.indexLabel.numberOfLines = 1;
    self.indexLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.indexLabel];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.blackBoard setValue:@(-100) forKey:MD_ReadjustContentOffset];
//    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.height += 50;
       
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.height += 50;
    });
}

- (void)loadModuleData:(id)model
{
//    self.indexLabel.text = [[NSString alloc]initWithFormat:@"head module %ld",self.moduleIndex];
    self.indexLabel.text = @"你好，小影";
}

- (void)layoutModuleWidth:(CGFloat)viewWidth
{
    self.frame = CGRectMake(0, 0, viewWidth, 100.0);
    [self.indexLabel sizeToFit];
   
    [self.indexLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(100);
        make.top.equalTo(self).offset(60);
        make.trailing.equalTo(self.mas_trailing);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.indexLabel.centerX = self.frame.size.width / 2;
        self.indexLabel.centerY = self.frame.size.height / 2;
    });
   
}

- (void)test
{
    [self.blackBoard setValue:@"****设置的数据****" forKey:@"md_title_key"];
    [self.blackBoard setValue:@"****设置的数据****" forKey:@"md_module_0_key"];
}


@end
