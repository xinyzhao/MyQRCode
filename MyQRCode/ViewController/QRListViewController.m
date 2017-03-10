//
//  QRListViewController.m
//  MyQRCode
//
//  Created by xyz on 2017/3/10.
//  Copyright © 2017年 xinyzhao. All rights reserved.
//

#import "QRListViewController.h"

@interface QRListViewController ()
@property (nonatomic, weak) IBOutlet UIBarButtonItem *rightItem;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation QRListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.dataArray = [NSMutableArray arrayWithContentsOfFile:MyQRCodeHistoryFile];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //
    [self setBackItemImage:[UIImage imageNamed:@"back_arrow.png"]];
    [self setBackItemTintColor:[UIColor blackColor]];
    //
    self.rightItem.enabled = self.dataArray.count > 0;
}

#pragma mark Actions

- (IBAction)onCleanup:(id)sender {
    __weak typeof(self) weakSelf = self;
    ZXAlertAction *cancelAction = [ZXAlertAction actionWithTitle:@"取消" handler:nil];
    ZXAlertAction *cleanupAction = [ZXAlertAction actionWithTitle:@"清除" handler:^(ZXAlertAction *action) {
        weakSelf.rightItem.enabled = NO;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray writeToFile:MyQRCodeHistoryFile atomically:YES];
        [weakSelf.tableView reloadData];
    }];
    ZXAlertView *alertView = [[ZXAlertView alloc] initWithTitle:@"清除全部记录" message:@"记录清除后将不可恢复，请选择" cancelAction:cancelAction otherActions:cleanupAction, nil];
    [alertView showInViewController:self];
}

#pragma mark <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.dataArray writeToFile:MyQRCodeHistoryFile atomically:YES];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_didSelectBlock) {
        _didSelectBlock(self.dataArray[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

@end
