//
//  SZSandBoxToolHomeViewController.m
//  沙盒查看工具
//
//  Created by hsz on 2020/3/12.
//  Copyright © 2020 魏家园潇. All rights reserved.
//

#import "SZSandBoxToolHomeViewController.h"
#import "LJ_FileInfo.h"
#import "SZSandBoxFileInfoModel.h"
#import "SZSandBoxTableViewCell.h"
#import "LJ_FileInfoController.h"

@interface SZSandBoxToolHomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<SZSandBoxFileInfoModel *> *dataSource;

@end

@implementation SZSandBoxToolHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isHomeDir) {
        self.filePath = NSHomeDirectory();
        self.fileName = @"应用沙盒文件目录";
    }
    [self setupUI];
    [self findAllFileInfo];
}

- (void)setupUI {
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0.945 green:0.945 blue:0.945 alpha:1];
    [self.view addSubview:self.tableView];
    [self setupRightItem];
}

- (void)setupRightItem {
    self.title = self.fileName;
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:(self.isHomeDir ? @"关闭":@"刷新") style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)rightItemAction {
    self.isHomeDir ? [self close] : [self findAllFileInfo];
}

- (void)close {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)findAllFileInfo {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *dataArr = [LJ_FileInfo searchAllFileFromRightDirPath:self.filePath];
        self.dataSource = [SZSandBoxFileInfoModel parseModelsWithDics:dataArr];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableView.hidden = self.dataSource.count < 1;
            [self.tableView reloadData];
        });
    });
}

- (void)deleteOneRowWithIndexPath:(NSIndexPath *)indexPath {
    
    //获取文件属性
    NSFileManager *filemager = [NSFileManager defaultManager];
    SZSandBoxFileInfoModel *info = self.dataSource[indexPath.row];
    NSString *path = [self.filePath stringByAppendingPathComponent:info.title];
    NSError *error = nil;
    [filemager removeItemAtPath:path error:&error];
    if (error) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"删除文件失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
        return ;
    }
    
    NSMutableArray * ds = [NSMutableArray arrayWithArray:self.dataSource];
    [ds removeObjectAtIndex:indexPath.row];
    self.dataSource = ds;
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

// MARK: Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SZSandBoxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SZSandBoxTableViewCell" forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SZSandBoxFileInfoModel *model = self.dataSource[indexPath.row];
    if ([model.NSFileType isEqualToString:NSFileTypeDirectory]) {
        SZSandBoxToolHomeViewController *vc = [SZSandBoxToolHomeViewController new];
        vc.fileName = model.title;
        vc.filePath = [self.filePath stringByAppendingPathComponent:model.title];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        LJ_FileInfoController * infovc =[LJ_FileInfoController createWithFilePath:[self.filePath stringByAppendingPathComponent:model.title] andFileInfo:model];
        [self.navigationController pushViewController:infovc animated:YES];
    }
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isHomeDir) return @[];
    
    SZSandBoxFileInfoModel *model = self.dataSource[indexPath.row];
    NSString *selectFilePath = [self.filePath stringByAppendingPathComponent:model.title];
    BOOL canDelete = [[NSFileManager defaultManager] isDeletableFileAtPath:selectFilePath];
    NSString *title = canDelete ? @"删除" : @"不可删除";
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:title handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if ([action.title isEqualToString:@"删除"]) {
            [self deleteOneRowWithIndexPath:indexPath];
        } else {
            [self.tableView beginUpdates];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }
    }];
    
    return @[delete];
}

// MARK: Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
        _tableView.separatorColor = [UIColor colorWithRed:0.898 green:0.898 blue:0.898 alpha:1];
        _tableView.tableFooterView = [UIView new];
        [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [_tableView registerClass:[SZSandBoxTableViewCell class] forCellReuseIdentifier:@"SZSandBoxTableViewCell"];
    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

@end
