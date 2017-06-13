//
//  MDBaseModuleViewController.m
//  MDProject
//
//  Created by lizitao on 2017/5/13.
//  Copyright © 2017年 lizitao. All rights reserved.
//

#import "MDBaseModuleViewController.h"
#import "MDBaseModuleView.h"
#import "UIView+ResizeFrame.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MDBaseModuleViewController ()<UIScrollViewDelegate>
//views
@property (nonatomic, strong) UIScrollView *scrollView;
//model
@property (nonatomic, strong) id model;

@end

@implementation MDBaseModuleViewController

- (instancetype)init
{
    if (self = [super init]) {
    
    }
    return self;
}

- (void)setModel:(id)model
{
    _model = model;
}

- (void)dealloc
{
    [self disposeAllSubviewsSignal];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadContentSubviews];
}

- (void)loadContentSubviews
{
    self.scrollView = [UIScrollView new];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
   
    self.contentView = [UIView new];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.contentView];
    [self loadAllSubviews];
    [self loadAllSubviewsData];
    [self layoutAllSubviews];
}

- (NSArray *)loadContentViews
{
    return @[];
}

- (void)refreshContentSubviews
{
    [self loadAllSubviewsData];
    [self layoutAllSubviews];
}

- (void)refreshContentSubviewWithIndex:(NSUInteger)index
{
    if (index >= self.contentView.subviews.count) return;
    __kindof MDBaseModuleView * obj = [self.contentView.subviews objectAtIndex:index];
    if ([obj conformsToProtocol:@protocol(MDBaseViewDelegate)]) {
        [obj loadViewWithData:self.model];
        [obj layoutViewWithWidth:[self contentViewWidth]];
        obj.left = ([self screenWidth] - [self contentViewWidth])/2;
        if (index > 0) {
            [self relayoutSubViewsWithIndex:index-1];
        }
    }
}

//支持模块后台动态可配
- (BOOL)isSupportDynamicConfigration
{
    return NO;
}

- (NSArray *)dynamicModules
{
    return @[];
}

- (NSDictionary *)allDynamicModules
{
    return @{};
}

- (NSString *)loadDynamicModuleWith:(NSString *)moduleIdentify
{
    static dispatch_once_t onceToken;
    static NSDictionary * dic = nil;
    dispatch_once(&onceToken, ^{
        dic = [self allDynamicModules];
    });
    return dic[moduleIdentify];
}

- (void)loadAllSubviews
{
    if ([self isSupportDynamicConfigration]) {
        for (NSString *obj in [self dynamicModules]) {
            Class cls = NSClassFromString([self loadDynamicModuleWith:obj]);
            if (cls != nil) {
                [self.contentView addSubview:[cls new]];
            }
        }
    } else {
        for (NSString *obj in [self loadContentViews]) {
            [self.contentView addSubview:[NSClassFromString(obj) new]];
        }
    }
}

- (void)loadAllSubviewsData
{
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof MDBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(MDBaseViewDelegate)]) {
            [obj configViewWithIndex:idx];
            [obj loadViewWithData:self.model];
        }
    }];
    [self bindAllSubViewsHeight];
}

- (void)bindAllSubViewsHeight
{
    __block RACSignal *signal = [RACSubject subject];
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof MDBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        RACSubject *s = obj.heightChangeSignal;
        if (idx == 0) {
            signal = s;
        } else {
            signal = [signal merge:s];
        }
    }];
    @weakify(self);
    [[[signal distinctUntilChanged] skip:0] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"---------->%@",x);
        [self relayoutSubViewsWithIndex:[x integerValue]];
    }];
}

- (void)disposeAllSubviewsSignal
{
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof MDBaseModuleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(MDBaseViewDelegate)]) {
            RACSubject *s = obj.heightChangeSignal;
            [s sendCompleted];
        }
    }];
}

- (void)layoutAllSubviews
{
    __block CGFloat layoutOffestY = 0.0;
    @weakify(self);
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        if ([obj conformsToProtocol:@protocol(MDBaseViewDelegate)]) {
            [obj layoutViewWithWidth:[self contentViewWidth]];
            obj.top = layoutOffestY;
            obj.left = ([self screenWidth] - [self contentViewWidth])/2;
            layoutOffestY = obj.bottom + [self spacingBetweenSubviews];
        }
    }];
    self.contentView.frame = CGRectMake(0, 0, self.view.width, layoutOffestY);
    self.scrollView.contentSize = CGSizeMake(self.view.width, layoutOffestY);
    
}

- (void)relayoutSubViewsWithIndex:(NSUInteger)index
{
    __block CGFloat layoutOffestY = [self.contentView.subviews objectAtIndex:index].bottom;
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > index) {
            obj.top = layoutOffestY + [self spacingBetweenSubviews];
            layoutOffestY = obj.bottom;
        }
    }];
    self.contentView.frame = CGRectMake(0, 0, self.view.width, layoutOffestY);
    self.scrollView.contentSize = CGSizeMake(self.view.width, layoutOffestY);
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.frame = CGRectMake(0, 0, self.view.width, [self showHeight]);
    self.contentView.top = 0;
    self.contentView.left = 0;
    self.contentView.width = self.scrollView.width;
}

- (CGFloat)spacingBetweenSubviews
{
    return 0.0;
}

- (CGFloat)screenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

- (CGFloat)contentViewWidth
{
    return [self screenWidth];
}

- (CGFloat)showHeight
{
    return [self screenHeight];
}

- (CGFloat)screenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
