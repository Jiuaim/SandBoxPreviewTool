//
//  SZSandBoxResourceHelper.h
//  沙盒查看工具
//
//  Created by hsz on 2020/3/12.
//  Copyright © 2020 魏家园潇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SZSandBoxResourceHelper : NSObject

+ (nullable NSBundle *)resourcesBundle;
+ (nullable UIImage *)imageWithName:(nullable NSString *)name;

+ (nullable NSBundle *)resourcesBundleWithName:(nullable NSString *)bundleName;
+ (nullable UIImage *)imageInBundle:(nullable NSBundle *)bundle withName:(nullable NSString *)name;

@end

NS_ASSUME_NONNULL_END
