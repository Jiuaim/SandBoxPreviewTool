//
//  SZSandBoxTableViewCell.h
//  沙盒查看工具
//
//  Created by hsz on 2020/3/12.
//  Copyright © 2020 魏家园潇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZSandBoxFileInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SZSandBoxTableViewCell : UITableViewCell

@property (nonatomic, strong) SZSandBoxFileInfoModel *model;

@end

NS_ASSUME_NONNULL_END
