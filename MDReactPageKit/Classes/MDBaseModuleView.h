//
//  MDBaseModuleView.h
//  MDReactPageKit
//
//  Created by lizitao on 2018/2/1.
//

#import <UIKit/UIKit.h>
#import <MDCommonKit/MDCommonKit.h>
#import <MDReactDataBoard/MDReactBlackBoard.h>
@class RACSubject;
@interface MDBaseModuleView : UIView
@property (nonatomic, strong) RACSubject *heightSignal;
@property (nonatomic, assign) NSUInteger moduleIndex;
@property (nonatomic, strong) MDReactBlackBoard *blackBoard;
- (instancetype)initWithBoard:(MDReactBlackBoard *)blackBoard;
@end
