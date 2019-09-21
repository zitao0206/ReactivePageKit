//
//  XYReactBasePageViewController.m
//  XYReactPageKit
//
//  Created by lizitao on 2018/2/1.
//

#import "XYReactBasePageViewController.h"
#import "UIView+XYEasyLayout.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "XYBaseModuleView.h"
#import "XYBaseModuleViewDelegate.h"

@interface XYReactBasePageViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSMutableArray <XYBaseModuleView *> *fixedViews;
@end

@implementation XYReactBasePageViewController

- (void)dealloc
{
    [self disposeAllModuleViewsSignal];
}

- (void)setModel:(id)model
{
    _model = model;
    if (_model != nil) {
        [self refreshAllModuleViews];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadContentSubviews];
    @weakify(self);
    [[self.blackBoard signalForKey:XY_ReadjustContentOffset] subscribeNext:^(id x) {
        @strongify(self);
        CGFloat offset = [x floatValue];
        self.scrollView.contentOffset = CGPointMake(0, offset);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof XYBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(XYBaseModuleViewDelegate)]) {
            if ([obj respondsToSelector:@selector(moduleWillAppear)]) {
                  [obj moduleWillAppear];
            }
        }
    }];
    //fixedViews：固定的模块处理
    [self.fixedViews enumerateObjectsUsingBlock:^(__kindof XYBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(XYBaseModuleViewDelegate)]) {
            if ([obj respondsToSelector:@selector(moduleWillAppear)]) {
                [obj moduleWillAppear];
            }
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof XYBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(XYBaseModuleViewDelegate)]) {
            if ([obj respondsToSelector:@selector(moduleDidAppear)]) {
                [obj moduleDidAppear];
            }
        }
    }];
    //fixedViews：固定的模块处理
    [self.fixedViews enumerateObjectsUsingBlock:^(__kindof XYBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(XYBaseModuleViewDelegate)]) {
            if ([obj respondsToSelector:@selector(moduleDidAppear)]) {
                [obj moduleDidAppear];
            }
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof XYBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(XYBaseModuleViewDelegate)]) {
            if ([obj respondsToSelector:@selector(moduleWillDisappear)]) {
                [obj moduleWillDisappear];
            }
        }
    }];
    //fixedViews：固定的模块处理
    [self.fixedViews enumerateObjectsUsingBlock:^(__kindof XYBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(XYBaseModuleViewDelegate)]) {
            if ([obj respondsToSelector:@selector(moduleWillDisappear)]) {
                [obj moduleWillDisappear];
            }
        }
    }];
}

- (XYReactBlackBoard *)blackBoard
{
    if(nil == _blackBoard){
        _blackBoard = [[XYReactBlackBoard alloc] init];
    }
    return _blackBoard;
}

- (NSMutableArray *)fixedViews
{
    if(nil == _fixedViews){
        _fixedViews = [[NSMutableArray alloc] init];
    }
    return _fixedViews;
}

- (void)loadContentSubviews
{
    self.scrollView = [UIScrollView new];
    self.scrollView.frame = CGRectMake(0, 0, self.view.width, [self screenHeight]);
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scrollView];
    self.scrollView.bounces = [self bouncesEnabled];
    self.scrollView.alwaysBounceVertical = [self alwaysBounceVertical];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = [self scrollEnabled];
    self.contentView = [UIView new];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.contentView];
    [self loadContentModuleViews];
}

//加载所有ModuleView
- (void)loadContentModuleViews
{
    NSMutableArray *_fixedViews = [[NSMutableArray alloc] init];
    for (NSString *obj in [self moduleViews]) {
        __kindof XYBaseModuleView *objView = [[NSClassFromString(obj) alloc]initWithBoard:self.blackBoard];
        if ([objView conformsToProtocol:@protocol(XYBaseModuleViewDelegate)]) {
            if ([objView isModuleNeedFixed] ||
                [objView isModuleNeedFixedToBottom] ||
                [objView isModuleNeedFixedToTop]) {
                [_fixedViews addObject:objView];
                [self.view addSubview:objView];
                [self.view bringSubviewToFront:objView];
            } else {
                [self.contentView addSubview:objView];
            }
        }
    }
    //顺序倒过来
    if ([_fixedViews count] > 0) {
        [self.fixedViews addObjectsFromArray:[[_fixedViews reverseObjectEnumerator] allObjects]];
    }
    [self loadContentModuleSubViews];
}

//加载所有ModuleView的子View
- (void)loadContentModuleSubViews
{
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof XYBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(XYBaseModuleViewDelegate)]) {
            [obj loadModuleSubViews];
        }
    }];
    //fixedViews：固定的模块处理
    [self.fixedViews enumerateObjectsUsingBlock:^(__kindof XYBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(XYBaseModuleViewDelegate)]) {
            [obj loadModuleSubViews];
        }
    }];
}

//刷新所有模块
- (void)refreshAllModuleViews
{
    [self loadContentModulesData];
    [self layoutModuleViews];
}

//刷新某一模块
- (void)refreshModuleViewsWithIndex:(NSUInteger)index
{
     if (index >= self.contentView.subviews.count) return;
     __kindof XYBaseModuleView * obj = [self.contentView.subviews objectAtIndex:index];
     if ([obj conformsToProtocol:@protocol(XYBaseModuleViewDelegate)]) {
        [obj loadModuleData:self.model];
        [obj layoutModuleWidth:[self screenWidth]];
        [self relayoutModuleViewsWithIndex:index];
    }
}

//分发数据并绑定height变化监测
- (void)loadContentModulesData
{
    @weakify(self);
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof XYBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        obj.moduleIndex = idx;
        if ([obj conformsToProtocol:@protocol(XYBaseModuleViewDelegate)]) {
            [obj loadModuleData:self.model];
        }
    }];
    [self bindAllSubViewsHeight];
    //fixedViews：固定的模块处理
    [self.fixedViews enumerateObjectsUsingBlock:^(__kindof XYBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        obj.moduleIndex = idx;
        if ([obj conformsToProtocol:@protocol(XYBaseModuleViewDelegate)]) {
            [obj loadModuleData:self.model];
        }
    }];
}

/***须子类重写***/
- (NSArray *)moduleViews
{
    return @[];
}

- (void)bindAllSubViewsHeight
{
    __block RACSignal *signal = [RACSubject subject];
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof XYBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        RACSubject *s = obj.heightSignal;
        if (idx == 0) {
            signal = s;
        } else {
            signal = [signal merge:s];
        }
    }];
    @weakify(self);
    [signal subscribeNext:^(id x) {
        @strongify(self);
        [self relayoutModuleViewsWithIndex:[x integerValue]];
    }];
}

//所有模块布局
- (void)layoutModuleViews
{
    __block CGFloat layoutOffestY = 0.0;
    @weakify(self);
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        if ([obj conformsToProtocol:@protocol(XYBaseModuleViewDelegate)]) {
            [obj layoutModuleWidth:[self contentViewWidth]];
            obj.top = layoutOffestY;
            obj.left = ([self screenWidth] - [self contentViewWidth])/2;
            layoutOffestY = obj.bottom + [self spaceBetweenModuleViews];
        }
    }];
    self.contentView.frame = CGRectMake(0, 0, self.view.width, layoutOffestY);
    self.scrollView.contentSize = CGSizeMake(self.view.width, layoutOffestY);
    
    //fixedViews：固定的模块处理
    __block CGFloat fixedBottomOffestY = 0.0;
    __block CGFloat fixedTopOffestY = 0.0;
    [self.fixedViews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        if ([obj conformsToProtocol:@protocol(XYBaseModuleViewDelegate)]) {
            [obj layoutModuleWidth:[self contentViewWidth]];
            obj.left = ([self screenWidth] - [self contentViewWidth])/2;
            if ([obj isModuleNeedFixedToTop]) {
                obj.top = fixedTopOffestY;
                fixedTopOffestY += obj.height;
            }
            if ([obj isModuleNeedFixedToBottom]) {
                obj.bottom = [self screenHeight] - fixedBottomOffestY;
                fixedBottomOffestY += obj.height;
            }
        }
    }];
    //内容展示到吸底的模块区域
    self.scrollView.height = [self screenHeight] - fixedBottomOffestY - fixedTopOffestY;
    self.scrollView.top = fixedTopOffestY;
}

//指定模块的布局刷新
- (void)relayoutModuleViewsWithIndex:(NSUInteger)index
{
    __block CGFloat layoutOffestY = [self.contentView.subviews objectAtIndex:index].bottom;
    NSUInteger location = index + 1;
    NSRange range = NSMakeRange(location, self.contentView.subviews.count - location);
    @weakify(self);
    [[self.contentView.subviews subarrayWithRange:range] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        obj.top = layoutOffestY + [self spaceBetweenModuleViews];
        layoutOffestY = obj.bottom;
    }];
    self.contentView.frame = CGRectMake(0, 0, self.view.width, layoutOffestY);
    self.scrollView.contentSize = CGSizeMake(self.view.width, layoutOffestY);
}

- (void)disposeAllModuleViewsSignal
{
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof XYBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(XYBaseModuleViewDelegate)]) {
            RACSubject *s = obj.heightSignal;
            [s sendCompleted];
        }
    }];
}

/***子类可重写***/
- (BOOL)scrollEnabled
{
    return YES;
}

/***子类可重写***/
- (BOOL)bouncesEnabled
{
    return NO;
}

/***子类可重写***/
- (BOOL)alwaysBounceVertical
{
    return NO;
}

/***子类可重写***/
- (CGFloat)spaceBetweenModuleViews
{
    return 0.0;
}

- (CGFloat)contentViewWidth
{
    return [self screenWidth];
}

- (CGFloat)screenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

- (CGFloat)screenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.contentView.top = 0;
    self.contentView.left = 0;
    self.contentView.width = self.scrollView.width;
}

@end
