//
//  CacheManager.m
//  SDWebImageDemo
//
//  Created by John on 15/11/30.
//  Copyright © 2015年 Mr Tang. All rights reserved.
//

#import "CacheManager.h"

@implementation CacheManager
static NSCache *s_imageCache = nil;
+ (NSCache *)cache {
    if (s_imageCache == nil) {
        s_imageCache = [[NSCache alloc] init];
        s_imageCache.name = @"imageCache";
    }
    return s_imageCache;
}

+ (NSString *)cachePath {
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    return document;
}

+ (unsigned long long)cacheBytesCount {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:[self cachePath]] objectEnumerator];
    NSString *fileName;
    unsigned long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [[self cachePath] stringByAppendingPathComponent:fileName];
        folderSize += [[manager attributesOfItemAtPath:fileAbsolutePath error:nil] fileSize];
    }
    return folderSize;
}

+ (void)clearCache {
    [[NSFileManager defaultManager] removeItemAtPath:[self cachePath] error:nil];
    [[NSFileManager defaultManager] createDirectoryAtPath:[self cachePath] withIntermediateDirectories:YES attributes:nil error:nil];
    [[self cache] removeAllObjects];
}
















@end
