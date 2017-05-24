//
//  MDBaseViewDelegate.h
//  MDProject
//
//  Created by lizitao on 2017/5/13.
//  Copyright © 2017年 lizitao. All rights reserved.
//

#ifndef MDBaseViewDelegate_h
#define MDBaseViewDelegate_h

@class RACSubject;
@protocol MDBaseViewDelegate <NSObject>

@required
- (void)configViewWithIndex:(NSUInteger)index;
- (void)loadViewWithData:(id)data;
- (void)layoutViewWithWidth:(CGFloat)viewWidth;

@end

#endif /* MDBaseViewDelegate_h */
