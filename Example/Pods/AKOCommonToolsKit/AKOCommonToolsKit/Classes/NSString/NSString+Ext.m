//
//  NSString+Ext.m
//  AKOCommonToolsKit
//
//  Created by Leon on 17/3/12.
//  Copyright © 2017年 Leon0206. All rights reserved.
//

#import "NSString+Ext.h"
#import <CommonCrypto/CommonDigest.h> // Need to import for CC_MD5 access


int __char2hex(unsigned char c) {
    switch (c) {
        case '0' ... '9':
			return c - '0';
        case 'a' ... 'f':
			return c - 'a' + 10;
        case 'A' ... 'F':
			return c - 'A' + 10;
        default:
			return 0x00;
    }
}

@implementation NSString (Ext)

+ (instancetype)generateUUID {
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *uuid = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return uuid;
}

- (NSData *)decodeHexString {
    NSInteger len = [self length];
    unichar buf[len];
    [self getCharacters:buf range:NSMakeRange(0, len)];
    
    unsigned char resultBytes[len / 2];
	
    for(NSUInteger i = 0, n = len / 2; i < n; i++) {
        resultBytes[i] = (__char2hex(buf[i*2]) << 4) | __char2hex(buf[i*2 + 1]);
    }
	
    return [NSData dataWithBytes:resultBytes length:len / 2];
}

- (NSString *)md5 {
	const char *cStr = [self UTF8String];
	unsigned char result[16];
	CC_MD5( cStr, (CC_LONG)strlen(cStr), result ); // This is the md5 call
	return [NSString stringWithFormat:
			@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			result[0], result[1], result[2], result[3],
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];
}


- (NSString *)stringByAddingPercentEscapesUsingEncodingExt:(NSStringEncoding)enc
{
    
    NSString * newString = (__bridge_transfer NSString *)
        CFURLCreateStringByAddingPercentEscapes(NULL,
                                                (__bridge CFStringRef)self,
                                                NULL,
                                                (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                CFStringConvertNSStringEncodingToEncoding(enc));
    
    return newString;
    
}

- (NSString *)stringByReplacingPercentEscapesUsingEncodingExt:(NSStringEncoding)enc
{
    
    NSString * newString = (__bridge_transfer NSString *)
        CFURLCreateStringByReplacingPercentEscapes(NULL, (__bridge CFStringRef)self, CFSTR(""));
    
    return newString;
    
}


- (NSString *)stringByAddingPercentEscapes {
    return [self stringByAddingPercentEscapesUsingEncodingExt:NSUTF8StringEncoding];
}
- (NSString *)stringByReplacingPercentEscapes {
    return [self stringByReplacingPercentEscapesUsingEncodingExt:NSUTF8StringEncoding];
}


- (BOOL)isValidEmail {
    NSString *emailRegEx =
	@"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
	@"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
	@"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
	@"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
	@"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
	@"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
	@"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
	
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:self];
}


- (NSString *)trimColon {
	if([self hasSuffix:@":"] || [self hasSuffix:@"："]) {
		return [self substringToIndex:[self length] - 1];
	} else {
		return self;
	}
}

- (NSData *)decodeBase64String {
    static const short _base64DecodingTable[256] = {
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2, -1, -1, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
        52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
        -2,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
        15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
        -2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
        41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2
    };
    
    const char *objPointer = [self cStringUsingEncoding:NSASCIIStringEncoding];
    size_t intLength = strlen(objPointer);
    int intCurrent;
    int i = 0, j = 0, k;
    
    unsigned char *objResult = calloc(intLength, sizeof(unsigned char));
    
    // Run through the whole string, converting as we go
    while ( ((intCurrent = *objPointer++) != '\0') && (intLength-- > 0) ) {
        if (intCurrent == '=') {
            if (*objPointer != '=' && ((i % 4) == 1)) {// || (intLength > 0)) {
                // the padding character is invalid at this point -- so this entire string is invalid
                free(objResult);
                return nil;
            }
            continue;
        }
        
        intCurrent = _base64DecodingTable[intCurrent];
        if (intCurrent == -1) {
            // we're at a whitespace -- simply skip over
            continue;
        } else if (intCurrent == -2) {
            // we're at an invalid character
            free(objResult);
            return nil;
        }
        
        switch (i % 4) {
            case 0:
                objResult[j] = intCurrent << 2;
                break;
                
            case 1:
                objResult[j++] |= intCurrent >> 4;
                objResult[j] = (intCurrent & 0x0f) << 4;
                break;
                
            case 2:
                objResult[j++] |= intCurrent >>2;
                objResult[j] = (intCurrent & 0x03) << 6;
                break;
                
            case 3:
                objResult[j++] |= intCurrent;
                break;
        }
        i++;
    }
    
    // mop things up if we ended on a boundary
    k = j;
    if (intCurrent == '=') {
        switch (i % 4) {
            case 1:
                // Invalid state
                free(objResult);
                return nil;
                
            case 2:
                k++;
                // flow through
            case 3:
                objResult[k] = 0;
        }
    }
    
    // Cleanup and setup the return NSData
    NSData * objData = [NSData dataWithBytes:objResult length:j];
    free(objResult);
    return objData;
}

- (NSData *)decodeUrlBase64String {
    static const short _urlBase64DecodingTable[256] = {
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 62, 00, 00,
        52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 00, 00, 00, 00, 00, 00,
        00,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
        15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 00, 00, 00, 00, 63,
        00, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
        41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 00, 00, 00, 00, 00,
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
    };
    
    NSUInteger length = [self length];
    NSUInteger _length4 = (length + 3) / 4 * 4, delta = _length4 - length;
    NSUInteger dlength = _length4 * 3 / 4 - delta;
    
    unichar buffer[length];
    [self getCharacters:buffer range:NSMakeRange(0, length)];
    NSMutableData *data = [NSMutableData dataWithLength:dlength];
    
    uint8_t* bytes = [data mutableBytes];
    
    int index = 0;
    for (int i = 0; i < length; i += 4) {
        short c0 = _urlBase64DecodingTable[buffer[i] & 0xFF];
        short c1 = _urlBase64DecodingTable[buffer[i + 1] & 0xFF];
        bytes[index++] = (uint8_t) (((c0 << 2) | (c1 >> 4)) & 0xFF);
        if (index >= dlength) {
            return data;
        }
        short c2 = _urlBase64DecodingTable[buffer[i + 2] & 0xFF];
        bytes[index++] = (uint8_t) (((c1 << 4) | (c2 >> 2)) & 0xFF);
        if (index >= dlength) {
            return data;
        }
        int c3 = _urlBase64DecodingTable[buffer[i + 3] & 0xFF];
        bytes[index++] = (uint8_t) (((c2 << 6) | c3) & 0xFF);
    }
    
    return data;
}

- (NSString *)urlDecode {
    if (![self length]) return @"";
    CFStringRef unescapedString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef)self,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    return (__bridge_transfer NSString *)unescapedString;
}

- (NSString *)urlEncode {
    if (![self length]) return @"";
    CFStringRef static const charsToEscape = CFSTR("!*'();:@&=+$,/?%#[]");
    CFStringRef escapedString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (__bridge CFStringRef)self,
                                                                        NULL,
                                                                        charsToEscape,
                                                                        kCFStringEncodingUTF8);
    return (__bridge_transfer NSString *)escapedString;
}

@end
