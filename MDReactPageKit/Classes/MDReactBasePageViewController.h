//
//  MDReactBasePageViewController.h
//  MDReactPageKit
//
//  Created by lizitao on 2018/2/1.
//

#import "MDBaseModuleModel.h"
#import <ReactiveDataBoard/ReactiveBlackBoard.h>
#import "MDReactPageDefinition.h"
@interface MDReactBasePageViewController : UIViewController
@property (nonatomic, strong) ReactiveBlackBoard *blackBoard;
@property (nonatomic, strong) id model;

@end
