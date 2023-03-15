//
//  ReactiveBasePageViewController.m
//  ReactivePageKit
//
//  Created by zitao0206 on 2018/2/1.
//

#import "ReactiveBasePageViewController.h"
#import <AKOCommonToolsKit/AKOCommonToolsKit.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "ReactiveBaseModuleView.h"
#import "ReactiveBaseModuleViewDelegate.h"

@interface ReactiveBasePageViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSMutableArray <ReactiveBaseModuleView *> *fixedViews;
@end

@implementation ReactiveBasePageViewController

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
    
    [[self.blackBoard valueForKey:Reactive_ReadjustContentOffset] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        CGFloat offset = [x floatValue];
        self.scrollView.contentOffset = CGPointMake(0, offset);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof ReactiveBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(ReactiveBaseModuleViewDelegate)]) {
            if ([obj respondsToSelector:@selector(moduleWillAppear)]) {
                  [obj moduleWillAppear];
            }
        }
    }];
    //fixedViews: fixed module processing
    [self.fixedViews enumerateObjectsUsingBlock:^(__kindof ReactiveBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(ReactiveBaseModuleViewDelegate)]) {
            if ([obj respondsToSelector:@selector(moduleWillAppear)]) {
                [obj moduleWillAppear];
            }
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof ReactiveBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(ReactiveBaseModuleViewDelegate)]) {
            if ([obj respondsToSelector:@selector(moduleDidAppear)]) {
                [obj moduleDidAppear];
            }
        }
    }];
    //fixedViews: fixed module processing
    [self.fixedViews enumerateObjectsUsingBlock:^(__kindof ReactiveBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(ReactiveBaseModuleViewDelegate)]) {
            if ([obj respondsToSelector:@selector(moduleDidAppear)]) {
                [obj moduleDidAppear];
            }
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof ReactiveBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(ReactiveBaseModuleViewDelegate)]) {
            if ([obj respondsToSelector:@selector(moduleWillDisappear)]) {
                [obj moduleWillDisappear];
            }
        }
    }];
    //fixedViews: fixed module processing
    [self.fixedViews enumerateObjectsUsingBlock:^(__kindof ReactiveBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(ReactiveBaseModuleViewDelegate)]) {
            if ([obj respondsToSelector:@selector(moduleWillDisappear)]) {
                [obj moduleWillDisappear];
            }
        }
    }];
}

- (ReactiveBlackBoard *)blackBoard
{
    if(nil == _blackBoard){
        _blackBoard = [[ReactiveBlackBoard alloc] init];
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

//Load all ModuleViews
- (void)loadContentModuleViews
{
    NSMutableArray *_fixedViews = [[NSMutableArray alloc] init];
    for (NSString *obj in [self moduleViews]) {
        __kindof ReactiveBaseModuleView *objView = [[NSClassFromString(obj) alloc]initWithBoard:self.blackBoard];
        if ([objView conformsToProtocol:@protocol(ReactiveBaseModuleViewDelegate)]) {
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
    //Reverse the order
    if ([_fixedViews count] > 0) {
        [self.fixedViews addObjectsFromArray:[[_fixedViews reverseObjectEnumerator] allObjects]];
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
    //fixedViews: fixed module processing
    [self.fixedViews enumerateObjectsUsingBlock:^(__kindof ReactiveBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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

//Refresh a module
- (void)refreshModuleViewsWithIndex:(NSUInteger)index
{
     if (index >= self.contentView.subviews.count) return;
     __kindof ReactiveBaseModuleView * obj = [self.contentView.subviews objectAtIndex:index];
     if ([obj conformsToProtocol:@protocol(ReactiveBaseModuleViewDelegate)]) {
        [obj loadModuleData:self.model];
        [obj layoutModuleWidth:[self screenWidth]];
        [self relayoutModuleViewsWithIndex:index];
    }
}

//Distribute data and bind height change monitoring
- (void)loadContentModulesData
{
    @weakify(self);
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof ReactiveBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        obj.moduleIndex = idx;
        if ([obj conformsToProtocol:@protocol(ReactiveBaseModuleViewDelegate)]) {
            [obj loadModuleData:self.model];
        }
    }];
    [self bindAllSubViewsHeight];
    //FixedViews: fixed module processing
    [self.fixedViews enumerateObjectsUsingBlock:^(__kindof ReactiveBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        obj.moduleIndex = idx;
        if ([obj conformsToProtocol:@protocol(ReactiveBaseModuleViewDelegate)]) {
            [obj loadModuleData:self.model];
        }
    }];
}

/***Must subclass override***/
- (NSArray *)moduleViews
{
    return @[];
}

- (void)bindAllSubViewsHeight
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
    [signal subscribeNext:^(id x) {
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
            [obj layoutModuleWidth:[self contentViewWidth]];
            obj.top = layoutOffestY;
            obj.left = ([self screenWidth] - [self contentViewWidth])/2;
            layoutOffestY = obj.bottom + [self spaceBetweenModuleViews];
        }
    }];
    self.contentView.frame = CGRectMake(0, 0, self.view.width, layoutOffestY);
    self.scrollView.contentSize = CGSizeMake(self.view.width, layoutOffestY);
    
    //fixedViews: fixed module processing
    __block CGFloat fixedBottomOffestY = 0.0;
    __block CGFloat fixedTopOffestY = 0.0;
    [self.fixedViews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        if ([obj conformsToProtocol:@protocol(ReactiveBaseModuleViewDelegate)]) {
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
    //The content is displayed in the module area of the bottom suction
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
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof ReactiveBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(ReactiveBaseModuleViewDelegate)]) {
            RACSubject *s = obj.heightSignal;
            [s sendCompleted];
        }
    }];
}

/***Subclass rewritable***/
- (BOOL)scrollEnabled
{
    return YES;
}

/***Subclass rewritable***/
- (BOOL)bouncesEnabled
{
    return NO;
}

/***Subclass rewritable***/
- (BOOL)alwaysBounceVertical
{
    return NO;
}

/***Subclass rewritable***/
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
