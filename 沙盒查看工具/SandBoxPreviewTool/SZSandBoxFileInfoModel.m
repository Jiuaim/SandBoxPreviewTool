//
//  SZSandBoxFileInfoModel.m
//  沙盒查看工具
//
//  Created by hsz on 2020/3/12.
//  Copyright © 2020 魏家园潇. All rights reserved.
//

#import "SZSandBoxFileInfoModel.h"

@implementation SZSandBoxFileInfoModel

+ (instancetype)parseModelWithDic:(NSDictionary *)infoDic {
    SZSandBoxFileInfoModel *model = [[SZSandBoxFileInfoModel alloc] init];
    
    model.FileType = infoDic[@"FileType"];
    model.NSFileCreationDate = infoDic[NSFileCreationDate];
    model.NSFileExtensionHidden = [infoDic[@"NSFileExtensionHidden"] boolValue];
    model.NSFileGroupOwnerAccountID = [infoDic[@"NSFileGroupOwnerAccountID"] longValue];
    model.NSFileGroupOwnerAccountName = infoDic[@"NSFileGroupOwnerAccountName"];
    model.NSFileModificationDate = infoDic[NSFileModificationDate];
    model.NSFileOwnerAccountID = [infoDic[@"NSFileOwnerAccountID"] longValue];
    model.NSFilePosixPermissions = [infoDic[@"NSFilePosixPermissions"] longValue];
    model.NSFileReferenceCount = [infoDic[@"NSFileReferenceCount"] longValue];
    model.NSFileSize = [infoDic[@"NSFileSize"] longValue];
    model.NSFileSystemFileNumber = [infoDic[@"NSFileSystemFileNumber"] longValue];
    model.NSFileSystemNumber = [infoDic[@"NSFileSystemNumber"] longValue];
    model.NSFileType = infoDic[@"NSFileType"];
    model.canDel = [infoDic[@"canDel"] boolValue];
    model.title = infoDic[@"title"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    model.fileModificationDate = [dateFormatter stringFromDate:model.NSFileModificationDate];
    model.fileCreationDate = [dateFormatter stringFromDate:model.NSFileCreationDate];
    
    return model;
}

+ (NSMutableArray<SZSandBoxFileInfoModel *> *)parseModelsWithDics:(NSArray<NSDictionary *> *)infoDics {
    NSMutableArray *tempArr = @[].mutableCopy;
    for (NSDictionary *obj in infoDics) {
        SZSandBoxFileInfoModel *model = [self parseModelWithDic:obj];
        if (model) [tempArr addObject:model];
    }
    return tempArr;
}

@end
