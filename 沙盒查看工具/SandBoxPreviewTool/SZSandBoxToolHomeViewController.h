//
//  SZSandBoxToolHomeViewController.h
//  沙盒查看工具
//
//  Created by hsz on 2020/3/12.
//  Copyright © 2020 魏家园潇. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SZSandBoxToolHomeViewController : UIViewController

@property (nonatomic, assign) BOOL isHomeDir;
@property (nonatomic, copy) NSString * filePath;
@property (nonatomic, copy) NSString * fileName;

@end

NS_ASSUME_NONNULL_END
