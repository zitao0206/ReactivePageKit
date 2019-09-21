//
//  XYReactBasePageViewController.h
//  XYReactPageKit
//
//  Created by lizitao on 2018/2/1.
//

#import "XYPageMasterViewController.h"
#import "XYBaseModuleModel.h"
#import "XYReactBlackBoard.h"
#import "XYReactPageDefinition.h"
@interface XYReactBasePageViewController : XYPageMasterViewController
@property (nonatomic, strong) XYReactBlackBoard *blackBoard;
@property (nonatomic, strong) id model;

@end
