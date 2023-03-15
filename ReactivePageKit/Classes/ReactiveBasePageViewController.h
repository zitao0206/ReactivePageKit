//
//  ReactiveBasePageViewController.h
//  ReactivePageKit
//
//  Created by zitao0206 on 2018/2/1.
//

#import "ReactiveBaseModuleModel.h"
#import <ReactiveDataBoard/ReactiveBlackBoard.h>
#import "ReactivePageDefinition.h"

@interface ReactiveBasePageViewController : UIViewController
@property (nonatomic, strong) ReactiveBlackBoard *blackBoard;
@property (nonatomic, strong) id model;

@end
