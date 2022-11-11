//
//  ReactiveBasePageView.h
//  ReactivePageKit
//
//  Created by leon0206 on 2018/2/2.
//

#import <UIKit/UIKit.h>
@class ReactiveBlackBoard;
@interface ReactiveBasePageView : UIView
@property (nonatomic, strong) ReactiveBlackBoard *blackBoard;
@property (nonatomic, strong) id model;
@end
