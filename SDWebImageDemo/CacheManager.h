//
//  CacheManager.h
//  SDWebImageDemo
//
//  Created by John on 15/11/30.
//  Copyright © 2015年 Mr Tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheManager : NSObject

+ (NSCache *)cache;

+ (NSString *)cachePath;

+ (void)clearCache;

+ (unsigned long long)cacheBytesCount;

@end
