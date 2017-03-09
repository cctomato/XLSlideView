//
//  XLSlideLRUCache.h
//  caifu
//
//  Created by cai cai on 2017/3/7.
//  Copyright © 2017年 cai cai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLSlideCacheProtocol.h"

@interface XLSlideLRUCache : NSObject<XLSlideCacheProtocol>

- (instancetype)initWithCount:(NSInteger)count;

- (void)xl_setObject:(id)object forKey:(NSString *)key;

- (id)xl_objectForKey:(NSString *)key;

@end
