//
//  UIColor+Ext.h
//  Pods
//
//  Created by Leon on 3/22/16.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (Ext)

+ (UIColor *)nvColorWithHexString:(NSString *)hexString;

+ (UIColor *)nvColorWithIntRed:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b;
+ (UIColor *)nvColorWithIntRed:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b alpha:(NSInteger)a;

@end

