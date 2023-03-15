//
//  ReactiveBaseModuleView.h
//  ReactivePageKit
//
//  Created by zitao0206 on 2018/2/1.
//

#import <UIKit/UIKit.h>
#import <EasyLayout/UIView+EasyLayout.h>
#import <ReactiveDataBoard/ReactiveBlackBoard.h>

@class RACSubject;

@interface ReactiveBaseModuleView : UIView
@property (nonatomic, strong) RACSubject *heightSignal;
@property (nonatomic, assign) NSUInteger moduleIndex;
@property (nonatomic, strong) ReactiveBlackBoard *blackBoard;
- (instancetype)initWithBoard:(ReactiveBlackBoard *)blackBoard;

@end
