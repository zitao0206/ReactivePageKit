//
//  NSArray+functional.h
//  MDProject
//
//  Created by Leon on 17/3/12.
//  Copyright © 2017年 Leon0206. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MDEnumerateBlock)(NSInteger index, id obj);
typedef id (^MDTransformBlock)(id obj);
typedef BOOL (^MDValidationBlock)(id obj);
typedef id (^MDAccumulationBlock)(id sum, id obj);

@interface NSArray (functional1)

/**
 *  enumerate each object in array with index
 *  @warning if index is not needed, prefer forin loop; consider map select reduce first
 *  @param block side effect logic
 */
- (void)MD_eachWithIndex:(MDEnumerateBlock)block;

/**
 *  functional map method
 *
 *  @param block specify mapping relation
 *
 *  @return mapped array
 */
- (NSArray *)MD_map:(MDTransformBlock)block;

/**
 *  function select method
 *
 *  @param block logic to specify which to select
 *
 *  @return new array with selectecd objects
 */
- (NSArray *)MD_select:(MDValidationBlock)block;

/**
 *  functional reject, similar with select
 *
 *  @param block specify which to reject
 *
 *  @return new array with filterd objects
 */
- (NSArray *)MD_reject:(MDValidationBlock)block;

/**
 *  functional reduce method
 *
 *  @param initial sum base
 *  @param block   add logic
 *
 *  @return sum
 */
- (id)MD_reduce:(id)initial withBlock:(MDAccumulationBlock)block;

/**
 *  take first n objects as array, if n > array length, return self
 *
 *  @param n number to take
 *
 *  @return array
 */
- (instancetype)MD_take:(NSUInteger)n;

/**
 *  find the object match condition in array
 *
 *  @param block condition
 *
 *  @return matched object or nil
 */
- (id)MD_find:(MDValidationBlock)block;

/**
 *  check whether all objects in array match condition
 *
 *  @param block condition logic
 *
 *  @return a
 */
- (BOOL)MD_allObjectsMatched:(MDValidationBlock)block;



/**
 *  check whether any object in array match condition
 *
 *  @param block condition logic
 *
 *  @return a
 */
- (BOOL)MD_anyObjectMatched:(MDValidationBlock)block;

/**
 *  join array of string to a string
 *
 *  @param seperator a
 *
 *  @return string
 */
- (NSString *)MD_join:(NSString *)seperator;

/**
 *  return the first matched object in array
 *
 *  @param block match logic
 *
 *  @return the first matched object, if not found, return nil
 */
- (id)MD_match:(MDValidationBlock)block;

/**
 *  check whether array contain matched object
 *
 *  @param block match logic
 *
 *  @return bool
 */
- (BOOL)MD_existObjectMatch:(MDValidationBlock)block;

/**
 *  check whether all objects in array match the validation
 *
 *  @param block validation
 *
 *  @return bool
 */
- (BOOL)MD_allObjectMatch:(MDValidationBlock)block;


- (NSArray *)MD_groupBy:(MDTransformBlock)block;

- (NSArray *)MD_zip:(NSArray *)array;

- (NSString *)MD_insertIntoPlaceHolderString:(NSString *)placeHolder;

@end
