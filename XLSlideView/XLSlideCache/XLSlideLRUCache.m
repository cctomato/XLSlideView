//
//  XLSlideLRUCache.m
//  caifu
//
//  Created by cai cai on 2017/3/7.
//  Copyright © 2017年 cai cai. All rights reserved.
//

#import "XLSlideLRUCache.h"

@interface XLSlideLRUCache ()
@property (nonatomic, strong) NSMutableDictionary *dict;
@property (nonatomic, strong) NSMutableArray *lruKeyList;
@property (nonatomic, assign) NSInteger capacity;
@end

@implementation XLSlideLRUCache

- (instancetype)initWithCount:(NSInteger)count
{
    self = [super init];
    if (self) {
        _capacity = count;
        _dict = [NSMutableDictionary dictionaryWithCapacity:_capacity];
        _lruKeyList = [NSMutableArray arrayWithCapacity:_capacity];
    }
    return self;
}
/**
 *LRU
 *Least Recently Used 近期最少使用算法。
 **/
- (void)xl_setObject:(id)object forKey:(NSString *)key
{
    if (![self.lruKeyList containsObject:key]) {
        if (self.lruKeyList.count < self.capacity) {
            [self.dict setValue:object forKey:key];
            [self.lruKeyList addObject:key];
        } else {
            NSString *longTimeUnusedKey = [self.lruKeyList firstObject];
            [self.dict setValue:nil forKey:longTimeUnusedKey];
            [self.lruKeyList removeObjectAtIndex:0];
            
            [self.dict setValue:object forKey:key];
            [self.lruKeyList addObject:key];
        }
    } else {
        [self.dict setValue:object forKey:key];
        [self.lruKeyList removeObject:key];
        [self.lruKeyList addObject:key];
    }
}

- (id)xl_objectForKey:(NSString *)key
{
    if ([self.lruKeyList containsObject:key]) {
        [self.lruKeyList removeObject:key];
        [self.lruKeyList addObject:key];
        
        return [self.dict objectForKey:key];
    } else {
        return nil;
    }
}

@end
