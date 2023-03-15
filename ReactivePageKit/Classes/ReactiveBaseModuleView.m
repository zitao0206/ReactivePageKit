//
//  ReactiveBaseModuleView.m
//  ReactivePageKit
//
//  Created by zitao0206 on 2018/2/1.
//

#import "ReactiveBaseModuleView.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "ReactiveBaseModuleViewDelegate.h"

@interface ReactiveBaseModuleView ()<ReactiveBaseModuleViewDelegate>
@end

@implementation ReactiveBaseModuleView

- (instancetype)initWithBoard:(ReactiveBlackBoard *)blackBoard
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        _heightSignal = [RACSubject subject];
        _blackBoard = blackBoard;
    }
    return self;
}

- (BOOL)isModuleNeedFixed
{
    return NO;
}

- (BOOL)isModuleNeedFixedToTop
{
    return NO;
}

- (BOOL)isModuleNeedFixedToBottom
{
    return NO;
}

- (void)setModuleIndex:(NSUInteger)moduleIndex
{
    _moduleIndex = moduleIndex;
    @weakify(self);
    [[[[RACObserve(self, height) distinctUntilChanged] skip:1] deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.heightSignal sendNext:[NSNumber numberWithInteger:moduleIndex]];
        });
    }];
}

/***Must subclass override***/
- (void)loadModuleSubViews
{
}

/***Must subclass override***/
- (void)loadModuleData:(id)model
{
}

/***Must subclass override***/
- (void)layoutModuleWidth:(CGFloat)width
{ 
}

/***Subclass override***/
- (void)moduleWillAppear
{
}

/***Subclass override***/
- (void)moduleDidAppear
{
}

/***Subclass override***/
- (void)moduleWillDisappear
{
}

@end
