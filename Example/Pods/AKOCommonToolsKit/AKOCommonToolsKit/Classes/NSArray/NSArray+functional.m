//
//  NSArray+functional.m
//  AKOCommonToolsKit
//
//  Created by Leon on 17/3/12.
//  Copyright © 2017年 Leon0206. All rights reserved.
//

#import "NSArray+functional.h"

@implementation NSArray (functional1)

- (void)AKO_eachWithIndex:(AKOEnumerateBlock)block {
    NSInteger index = 0;
    for (id obj in self) {
        block(index, obj);
        index++;
    }
}

- (NSArray *)AKO_map:(AKOTransformBlock)block{
    NSParameterAssert(block != nil);
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:self.count];
    for (id obj in self) {
        [ret addObject:block(obj)];
    }
    return ret;
}

- (NSArray *)AKO_select:(AKOValidationBlock)block{
    NSParameterAssert(block != nil);
	return [self objectsAtIndexes:[self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
		return block(obj);
	}]];
}

- (NSArray *)AKO_reject:(AKOValidationBlock)block{
    NSParameterAssert(block != nil);
	
	return [self objectsAtIndexes:[self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
		return !block(obj);
	}]];
}

- (id)AKO_reduce:(id)initial withBlock:(AKOAccumulationBlock)block {
	NSParameterAssert(block != nil);
	id result = initial;
    
    for (id obj in self) {
        result = block(result, obj);
    }
	return result;
}

- (instancetype)AKO_take:(NSUInteger)n {
    if ([self count] <= n) return self;
    return [self subarrayWithRange:NSMakeRange(0, n)];
}

- (id)AKO_find:(AKOValidationBlock)block {
    for (id obj in self) {
        if (block(obj)) {
            return obj;
        }
    }
    return nil;
}

- (id)AKO_match:(AKOValidationBlock)block {
    for (id object in self) {
        if (block(object)) {
            return object;
        }
    }
    return nil;
}

- (BOOL)AKO_allObjectsMatched:(AKOValidationBlock)block {
    for (id obj in self) {
        if (!block(obj)) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)AKO_anyObjectMatched:(AKOValidationBlock)block {
    for (id obj in self) {
        if (block(obj)) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)AKO_join:(NSString *)seperator {
    NSMutableString *string = [NSMutableString string];
    [self AKO_eachWithIndex:^(NSInteger index, id obj) {
        if (index != 0) {
            [string appendString:seperator];
        }
        [string appendString:obj];
    }];
    return string;
    
}

- (BOOL)AKO_existObjectMatch:(AKOValidationBlock)block {
    return [self AKO_match:block] != nil;
}

- (BOOL)AKO_allObjectMatch:(AKOValidationBlock)block {
    return [self AKO_match:^BOOL(id obj) {
        return !block(obj);
    }] == nil;
}

- (NSArray *)AKO_groupBy:(AKOTransformBlock)block {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (id obj in self) {
        NSString *key = block(obj);
        if (dic[key] == nil) {
            dic[key] = [NSMutableArray array];
        }
        [dic[key] addObject:obj];
    }
    return [dic allValues];
}

- (NSArray *)AKO_zip:(NSArray *)array {
    NSMutableArray *result = [NSMutableArray array];
    [self AKO_eachWithIndex:^(NSInteger index, id obj) {
        [result addObject:obj];
        if (index >= array.count) return;
        [result addObject:array[index]];
    }];
    return result;
}

- (NSString *)AKO_insertIntoPlaceHolderString:(NSString *)placeHolder {
    NSArray *components = [placeHolder componentsSeparatedByString:@"%%"];
    if ([components count] < 2) return placeHolder;
    return [[components AKO_zip:self] AKO_join:@""];
}

@end
