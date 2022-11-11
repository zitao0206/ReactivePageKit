//
//  UIColor+Ext.h
//  Pods
//
//  Created by Leon on 3/22/16.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (Ext)

+ (UIColor *)md_colorWithHexString:(NSString *)hexString;
+ (UIColor *)md_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
+ (UIColor *)md_colorWithIntRed:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b;
+ (UIColor *)md_colorWithIntRed:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b alpha:(CGFloat)a;

@end

