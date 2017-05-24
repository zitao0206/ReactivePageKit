//
//  MDBaseModuleView.m
//  MDProject
//
//  Created by lizitao on 2017/5/13.
//  Copyright © 2017年 lizitao. All rights reserved.
//

#import "MDBaseModuleView.h"
#import "MDBaseModuleModel.h"
@class RACSubject;
@interface MDBaseModuleView() <MDBaseViewDelegate>

@end

@implementation MDBaseModuleView

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.indexLabel = [UILabel new];
        self.indexLabel.font = [UIFont systemFontOfSize:14.f];
        self.indexLabel.textColor = [UIColor blackColor];
        self.indexLabel.numberOfLines = 1;
        self.indexLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.indexLabel];
        _heightChangeSignal = [RACSubject subject];
    }
    return self;
}

- (void)configViewWithIndex:(NSUInteger)index
{
    self.index = index;
    [[[[RACObserve(self, height) distinctUntilChanged] skip:1] deliverOnMainThread] subscribeNext:^(id x) {
        [self.heightChangeSignal sendNext:[NSNumber numberWithInteger:index]];
    }];
}

- (void)loadViewWithData:(id)data
{
    
}

- (void)layoutViewWithWidth:(CGFloat)viewWidth
{
  
}


@end
