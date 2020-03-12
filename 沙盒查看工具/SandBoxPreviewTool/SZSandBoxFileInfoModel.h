//
//  SZSandBoxFileInfoModel.h
//  沙盒查看工具
//
//  Created by hsz on 2020/3/12.
//  Copyright © 2020 魏家园潇. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SZSandBoxFileInfoModel : NSObject

@property (nonatomic, strong) NSString *FileType;
@property (nonatomic, strong) NSDate *NSFileCreationDate;
@property (nonatomic, strong) NSString *fileCreationDate;
@property (nonatomic, assign) BOOL NSFileExtensionHidden;
@property (nonatomic, assign) long NSFileGroupOwnerAccountID;
@property (nonatomic, strong) NSString *NSFileGroupOwnerAccountName;
@property (nonatomic, strong) NSDate *NSFileModificationDate;
@property (nonatomic, strong) NSString *fileModificationDate;
@property (nonatomic, assign) long NSFileOwnerAccountID;
@property (nonatomic, assign) long NSFilePosixPermissions;
@property (nonatomic, assign) long NSFileReferenceCount;
@property (nonatomic, assign) long NSFileSize;
@property (nonatomic, assign) long NSFileSystemFileNumber;
@property (nonatomic, assign) long NSFileSystemNumber;
@property (nonatomic, strong) NSString *NSFileType;
@property (nonatomic, assign) BOOL canDel;
@property (nonatomic, strong) NSString *title;

+ (instancetype)parseModelWithDic:(NSDictionary *)infoDic;
+ (NSMutableArray<SZSandBoxFileInfoModel *> *)parseModelsWithDics:(NSArray<NSDictionary *> *)infoDics;

@end

NS_ASSUME_NONNULL_END
