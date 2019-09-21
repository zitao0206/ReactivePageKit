//
//  XYBaseModuleViewDelegate.h
//  Pods
//
//  Created by lizitao on 2018/2/1.
//

#ifndef XYBaseModuleViewDelegate_h
#define XYBaseModuleViewDelegate_h

@class RACSubject;
@class XYReactBlackBoard;
@protocol XYBaseModuleViewDelegate <NSObject>
@required
//子类重写：加载模块的子View
- (void)loadModuleSubViews;
//子类重写：分发模块的model
- (void)loadModuleData:(id)model;
//子类重写：布局模块
- (void)layoutModuleWidth:(CGFloat)width;
//子类重写：是否需要固定，默认否，是的话添加到self.view上
- (BOOL)isModuleNeedFixed;
//子类重写：是否需要固定到底部，默认否，是的话添加到self.view底部
- (BOOL)isModuleNeedFixedToBottom;
//子类重写：是否需要固定到顶部，默认否，是的话添加到self.view顶部
- (BOOL)isModuleNeedFixedToTop;

@optional
//子类重写：模块WillAppear
- (void)moduleWillAppear;
//子类重写：模块DidAppear
- (void)moduleDidAppear;
//子类重写：模块WillDisappear
- (void)moduleWillDisappear;
@end

#endif /* XYBaseModuleViewDelegate_h */
