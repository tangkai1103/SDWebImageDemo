//
//  UIImageView+Cache.h
//  SDWebImageDemo
//
//  Created by John on 15/11/30.
//  Copyright © 2015年 Mr Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SetImageBlock) (BOOL flag);
@interface UIImageView (Cache)
- (void)setImageWithURL:(NSURL *)url completion:(SetImageBlock)block;
@end
