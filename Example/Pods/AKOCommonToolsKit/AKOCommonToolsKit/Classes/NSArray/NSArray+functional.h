//
//  NSArray+functional.h
//  AKOCommonToolsKit
//
//  Created by Leon on 17/3/12.
//  Copyright © 2017年 zitao0206. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AKOEnumerateBlock)(NSInteger index, id obj);
typedef id (^AKOTransformBlock)(id obj);
typedef BOOL (^AKOValidationBlock)(id obj);
typedef id (^AKOAccumulationBlock)(id sum, id obj);

@interface NSArray (functional1)

/**
 *  enumerate each object in array with index
 *  @warning if index is not needed, prefer forin loop; consider map select reduce first
 *  @param block side effect logic
 */
- (void)AKO_eachWithIndex:(AKOEnumerateBlock)block;

/**
 *  functional map method
 *
 *  @param block specify mapping relation
 *
 *  @return mapped array
 */
- (NSArray *)AKO_map:(AKOTransformBlock)block;

/**
 *  function select method
 *
 *  @param block logic to specify which to select
 *
 *  @return new array with selectecd objects
 */
- (NSArray *)AKO_select:(AKOValidationBlock)block;

/**
 *  functional reject, similar with select
 *
 *  @param block specify which to reject
 *
 *  @return new array with filterd objects
 */
- (NSArray *)AKO_reject:(AKOValidationBlock)block;

/**
 *  functional reduce method
 *
 *  @param initial sum base
 *  @param block   add logic
 *
 *  @return sum
 */
- (id)AKO_reduce:(id)initial withBlock:(AKOAccumulationBlock)block;

/**
 *  take first n objects as array, if n > array length, return self
 *
 *  @param n number to take
 *
 *  @return array
 */
- (instancetype)AKO_take:(NSUInteger)n;

/**
 *  find the object match condition in array
 *
 *  @param block condition
 *
 *  @return matched object or nil
 */
- (id)AKO_find:(AKOValidationBlock)block;

/**
 *  check whether all objects in array match condition
 *
 *  @param block condition logic
 *
 *  @return a
 */
- (BOOL)AKO_allObjectsMatched:(AKOValidationBlock)block;



/**
 *  check whether any object in array match condition
 *
 *  @param block condition logic
 *
 *  @return a
 */
- (BOOL)AKO_anyObjectMatched:(AKOValidationBlock)block;

/**
 *  join array of string to a string
 *
 *  @param seperator a
 *
 *  @return string
 */
- (NSString *)AKO_join:(NSString *)seperator;

/**
 *  return the first matched object in array
 *
 *  @param block match logic
 *
 *  @return the first matched object, if not found, return nil
 */
- (id)AKO_match:(AKOValidationBlock)block;

/**
 *  check whether array contain matched object
 *
 *  @param block match logic
 *
 *  @return bool
 */
- (BOOL)AKO_existObjectMatch:(AKOValidationBlock)block;

/**
 *  check whether all objects in array match the validation
 *
 *  @param block validation
 *
 *  @return bool
 */
- (BOOL)AKO_allObjectMatch:(AKOValidationBlock)block;


- (NSArray *)AKO_groupBy:(AKOTransformBlock)block;

- (NSArray *)AKO_zip:(NSArray *)array;

- (NSString *)AKO_insertIntoPlaceHolderString:(NSString *)placeHolder;

@end
