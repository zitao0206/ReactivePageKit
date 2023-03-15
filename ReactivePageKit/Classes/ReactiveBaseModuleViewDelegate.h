//
//  ReactiveBaseModuleViewDelegate.h
//  Pods
//
//  Created by zitao0206 on 2018/2/1.
//

#ifndef ReactiveBaseModuleViewDelegate_h
#define ReactiveBaseModuleViewDelegate_h

@class RACSubject;
@class ReactiveBlackBoard;
@protocol ReactiveBaseModuleViewDelegate <NSObject>
@required

/**
 * Subclass override, load the sub-view of the module
 */
- (void)loadModuleSubViews;

/**
 * Subclass override, model of distribution module
 */
- (void)loadModuleData:(id)model;

/**
 * Subclass override, layout module
 */
- (void)layoutModuleWidth:(CGFloat)width;

/**
 * Subclass rewriting, whether to fix it, no by default, if yes, add it to self.view
 */
- (BOOL)isModuleNeedFixed;

/**
 * Subclass rewriting, whether to fix to the bottom, no by default, if yes, add to the bottom of self.view
 */
- (BOOL)isModuleNeedFixedToBottom;

/**
 * Subclass override, whether to fix it to the top, no by default, if yes, add it to the top of self.view
 */
- (BOOL)isModuleNeedFixedToTop;

@optional

/**
 * Subclass override, module's WillAppear
 */
- (void)moduleWillAppear;

/**
 * Subclass override, module's moduleDidAppear
 */
- (void)moduleDidAppear;

/**
 * Subclass override, module's moduleWillDisappear
 */
- (void)moduleWillDisappear;
@end

#endif /* ReactiveBaseModuleViewDelegate_h */
