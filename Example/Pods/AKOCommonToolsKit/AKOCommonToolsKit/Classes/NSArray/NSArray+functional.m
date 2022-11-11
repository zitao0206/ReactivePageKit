//
//  NSArray+functional.m
//  MDProject
//
//  Created by Leon on 17/3/12.
//  Copyright © 2017年 Leon0206. All rights reserved.
//

#import "NSArray+functional.h"

@implementation NSArray (functional1)

- (void)MD_eachWithIndex:(MDEnumerateBlock)block {
    NSInteger index = 0;
    for (id obj in self) {
        block(index, obj);
        index++;
    }
}

- (NSArray *)MD_map:(MDTransformBlock)block{
    NSParameterAssert(block != nil);
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:self.count];
    for (id obj in self) {
        [ret addObject:block(obj)];
    }
    return ret;
}

- (NSArray *)MD_select:(MDValidationBlock)block{
    NSParameterAssert(block != nil);
	return [self objectsAtIndexes:[self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
		return block(obj);
	}]];
}

- (NSArray *)MD_reject:(MDValidationBlock)block{
    NSParameterAssert(block != nil);
	
	return [self objectsAtIndexes:[self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
		return !block(obj);
	}]];
}

- (id)MD_reduce:(id)initial withBlock:(MDAccumulationBlock)block {
	NSParameterAssert(block != nil);
	id result = initial;
    
    for (id obj in self) {
        result = block(result, obj);
    }
	return result;
}

- (instancetype)MD_take:(NSUInteger)n {
    if ([self count] <= n) return self;
    return [self subarrayWithRange:NSMakeRange(0, n)];
}

- (id)MD_find:(MDValidationBlock)block {
    for (id obj in self) {
        if (block(obj)) {
            return obj;
        }
    }
    return nil;
}

- (id)MD_match:(MDValidationBlock)block {
    for (id object in self) {
        if (block(object)) {
            return object;
        }
    }
    return nil;
}

- (BOOL)MD_allObjectsMatched:(MDValidationBlock)block {
    for (id obj in self) {
        if (!block(obj)) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)MD_anyObjectMatched:(MDValidationBlock)block {
    for (id obj in self) {
        if (block(obj)) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)MD_join:(NSString *)seperator {
    NSMutableString *string = [NSMutableString string];
    [self MD_eachWithIndex:^(NSInteger index, id obj) {
        if (index != 0) {
            [string appendString:seperator];
        }
        [string appendString:obj];
    }];
    return string;
    
}

- (BOOL)MD_existObjectMatch:(MDValidationBlock)block {
    return [self MD_match:block] != nil;
}

- (BOOL)MD_allObjectMatch:(MDValidationBlock)block {
    return [self MD_match:^BOOL(id obj) {
        return !block(obj);
    }] == nil;
}

- (NSArray *)MD_groupBy:(MDTransformBlock)block {
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

- (NSArray *)MD_zip:(NSArray *)array {
    NSMutableArray *result = [NSMutableArray array];
    [self MD_eachWithIndex:^(NSInteger index, id obj) {
        [result addObject:obj];
        if (index >= array.count) return;
        [result addObject:array[index]];
    }];
    return result;
}

- (NSString *)MD_insertIntoPlaceHolderString:(NSString *)placeHolder {
    NSArray *components = [placeHolder componentsSeparatedByString:@"%%"];
    if ([components count] < 2) return placeHolder;
    return [[components MD_zip:self] MD_join:@""];
}

@end
