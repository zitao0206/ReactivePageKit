//
//  NSString+Ext.h
//  MDProject
//
//  Created by Leon on 17/3/12.
//  Copyright © 2017年 Leon0206. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Ext)

+ (instancetype)generateUUID;

- (NSData *)decodeHexString;

- (NSString *)md5;

- (NSString *)stringByAddingPercentEscapesUsingEncodingExt:(NSStringEncoding)enc;
- (NSString *)stringByReplacingPercentEscapesUsingEncodingExt:(NSStringEncoding)enc;

/**
 url escape
 */
- (NSString *)stringByAddingPercentEscapes;
/**
 url unescape
 */
- (NSString *)stringByReplacingPercentEscapes;

- (BOOL)isValidEmail;

/**
 去掉头尾的冒号，包括中文和英文
 [@"价格：" trimColon] = @"价格"
 */
- (NSString *)trimColon;

// Standard Base64 decoder
- (NSData *)decodeBase64String;

// URL Base64 decoder (avoid url escape)
- (NSData *)decodeUrlBase64String;


- (NSString *)urlEncode;

- (NSString *)urlDecode;

@end
