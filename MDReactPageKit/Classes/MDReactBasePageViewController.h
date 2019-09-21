//
//  MDReactBasePageViewController.h
//  MDReactPageKit
//
//  Created by lizitao on 2018/2/1.
//

#import "MDBaseModuleModel.h"
#import "MDReactBlackBoard.h"
#import "MDReactPageDefinition.h"
@interface MDReactBasePageViewController : UIViewController
@property (nonatomic, strong) MDReactBlackBoard *blackBoard;
@property (nonatomic, strong) id model;

@end
