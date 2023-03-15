//
//  ReactiveBasePageView.m
//  ReactivePageKit
//
//  Created by zitao0206 on 2018/2/2.
//

#import "ReactiveBasePageView.h"
#import <AKOCommonToolsKit/AKOCommonToolsKit.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "ReactiveBaseModuleView.h"
#import "ReactiveBaseModuleViewDelegate.h"

@interface ReactiveBasePageView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@end

@implementation ReactiveBasePageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubviews];
    }
    return self;
}

- (void)setModel:(id)model
{
    _model = model;
    if (_model != nil) {
        [self refreshAllModuleViews];
    }
}

/***Must subclass override***/
- (NSArray *)moduleViews
{
    return @[];
}

- (ReactiveBlackBoard *)blackBoard
{
    if(nil == _blackBoard){
        _blackBoard = [[ReactiveBlackBoard alloc] init];
    }
    return _blackBoard;
}

- (void)loadSubviews
{
    self.scrollView = [UIScrollView new];
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.scrollView];
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.contentView = [UIView new];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.contentView];
    [self loadContentModuleViews];
}

//Load all ModuleViews
- (void)loadContentModuleViews
{
    for (NSString *obj in [self moduleViews]) {
        [self.contentView addSubview:[[NSClassFromString(obj) alloc] initWithBoard:self.blackBoard]];
    }
    [self loadContentModuleSubViews];
}

//Load child views of all ModuleViews
- (void)loadContentModuleSubViews
{
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof ReactiveBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(ReactiveBaseModuleViewDelegate)]) {
            [obj loadModuleSubViews];
        }
    }];
}


//Refresh all modules
- (void)refreshAllModuleViews
{
    [self loadContentModulesData];
    [self layoutModuleViews];
}

//Distribute data and bind height change monitoring
- (void)loadContentModulesData
{
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof ReactiveBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.moduleIndex = idx;
        if ([obj conformsToProtocol:@protocol(ReactiveBaseModuleViewDelegate)]) {
            [obj loadModuleData:self.model];
        }
    }];
    [self bindModuleViewsHeight];
}

- (void)bindModuleViewsHeight
{
    __block RACSignal *signal = [RACSubject subject];
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof ReactiveBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        RACSubject *s = obj.heightSignal;
        if (idx == 0) {
            signal = s;
        } else {
            signal = [signal merge:s];
        }
    }];
    @weakify(self);
    [[[signal distinctUntilChanged] skip:0] subscribeNext:^(id x) {
        @strongify(self);
        [self relayoutModuleViewsWithIndex:[x integerValue]];
    }];
}

//Layout of all modules
- (void)layoutModuleViews
{
    __block CGFloat layoutOffestY = 0.0;
    @weakify(self);
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        if ([obj conformsToProtocol:@protocol(ReactiveBaseModuleViewDelegate)]) {
            [obj layoutModuleWidth:[self contentWidth]];
            obj.top = layoutOffestY;
            obj.left = 0;
            layoutOffestY = obj.bottom + [self spaceBetweenModuleViews];
        }
    }];
    self.contentView.frame = CGRectMake(0, 0, self.width, layoutOffestY);
    self.scrollView.contentSize = CGSizeMake(self.width, layoutOffestY);
}

//Specify the layout refresh of the module
- (void)relayoutModuleViewsWithIndex:(NSUInteger)index
{
    __block CGFloat layoutOffestY = [self.contentView.subviews objectAtIndex:index].bottom;
    NSUInteger location = index + 1;
    NSRange range = NSMakeRange(location, self.contentView.subviews.count - location);
    [[self.contentView.subviews subarrayWithRange:range] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.top = layoutOffestY + [self spaceBetweenModuleViews];
        layoutOffestY = obj.bottom;
    }];
    self.contentView.frame = CGRectMake(0, 0, self.width, layoutOffestY);
    self.scrollView.contentSize = CGSizeMake(self.width, layoutOffestY);
}

/***Subclass rewritable***/
- (CGFloat)spaceBetweenModuleViews
{
    return 0.0;
}

- (CGFloat)contentWidth
{
    return self.frame.size.width;
}

- (CGFloat)contentHeight
{
    return self.frame.size.height;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = CGRectMake(0, 0, [self contentWidth], [self contentHeight]);
    self.contentView.top = 0;
    self.contentView.left = 0;
    self.contentView.width = self.scrollView.width;
}

@end
