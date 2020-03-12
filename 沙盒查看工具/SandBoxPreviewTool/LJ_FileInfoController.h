//
//  LJ_FileInfoController.h
//  LJHotUpdate
//
//  Created by nuomi on 2017/2/9.
//  Copyright © 2017年 xgyg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZSandBoxFileInfoModel.h"

@interface LJ_FileInfoController : UIViewController

@property (nonatomic,copy)NSString *filePath;
@property (nonatomic,strong)SZSandBoxFileInfoModel *fileInfo;

//根据文件类型和路径创建
+ (instancetype)createWithFilePath:(NSString *)filePath andFileInfo:(SZSandBoxFileInfoModel *)fileInfo;

@end
