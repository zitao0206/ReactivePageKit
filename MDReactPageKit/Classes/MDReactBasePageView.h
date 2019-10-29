//
//  MDReactBasePageView.h
//  MDReactPageKit
//
//  Created by lizitao on 2018/2/2.
//

#import <UIKit/UIKit.h>
@class ReactiveBlackBoard;
@interface MDReactBasePageView : UIView
@property (nonatomic, strong) ReactiveBlackBoard *blackBoard;
@property (nonatomic, strong) id model;
@end
