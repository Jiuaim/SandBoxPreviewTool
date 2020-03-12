//
//  SZSandBoxTableViewCell.m
//  沙盒查看工具
//
//  Created by hsz on 2020/3/12.
//  Copyright © 2020 魏家园潇. All rights reserved.
//

#import "SZSandBoxTableViewCell.h"
#import "SZSandBoxResourceHelper.h"

@implementation SZSandBoxTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.textLabel.textColor = [UIColor colorWithRed:0.19 green:0.19 blue:0.19 alpha:1];
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setModel:(SZSandBoxFileInfoModel *)model {
    if (_model != model) {
        _model = model;
        
        self.textLabel.text = _model.title;
        self.detailTextLabel.text = _model.fileModificationDate;
        
        // 是否文件夹类型
        if (![_model.NSFileType isEqualToString:NSFileTypeDirectory]) {
            if ([_model.NSFileType hasPrefix:@"image"]) {
                // 图片类型
                self.imageView.image = [SZSandBoxResourceHelper imageWithName:@"lj_Pictures"];
            } else {
                // 未知文件类型
                self.imageView.image = [SZSandBoxResourceHelper imageWithName:@"lj_unknow_icon"];
            }
        } else {
            self.imageView.image = [SZSandBoxResourceHelper imageWithName:@"GenericFolderIcon"];
        }
    }
}

@end
