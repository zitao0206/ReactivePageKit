//
//  XYBaseModuleView.h
//  XYReactPageKit
//
//  Created by lizitao on 2018/2/1.
//

#import <UIKit/UIKit.h>
#import "UIView+XYEasyLayout.h"
#import "XYReactBlackBoard.h"
@class RACSubject;
@interface XYBaseModuleView : UIView
@property (nonatomic, strong) RACSubject *heightSignal;
@property (nonatomic, assign) NSUInteger moduleIndex;
@property (nonatomic, strong) XYReactBlackBoard *blackBoard;
- (instancetype)initWithBoard:(XYReactBlackBoard *)blackBoard;
@end
