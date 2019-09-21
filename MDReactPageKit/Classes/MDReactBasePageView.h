//
//  MDReactBasePageView.h
//  MDReactPageKit
//
//  Created by lizitao on 2018/2/2.
//

#import <UIKit/UIKit.h>
@class MDReactBlackBoard;
@interface MDReactBasePageView : UIView
@property (nonatomic, strong) MDReactBlackBoard *blackBoard;
@property (nonatomic, strong) id model;
@end
