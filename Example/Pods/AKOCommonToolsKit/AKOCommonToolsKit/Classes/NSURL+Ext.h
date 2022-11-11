//
//  NSURL+Ext.h
//  MDProject
//
//  Created by Leon on 17/3/12.
//  Copyright © 2017年 Leon0206. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Ext)

/**
 将query解析为NSDictionary
 
 @return 返回参数字典对象，参数的值已经进行了decode.
 (stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding)
 */
- (NSDictionary *)parseQuery;

@end
