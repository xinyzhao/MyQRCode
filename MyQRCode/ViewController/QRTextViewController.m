//
//  QRTextViewController.m
//  MyQRCode
//
//  Created by xyz on 16/9/13.
//  Copyright © 2016年 xinyzhao. All rights reserved.
//

#import "QRTextViewController.h"
#import "QRListViewController.h"

@interface QRTextViewController ()
@property (nonatomic, weak) IBOutlet UIBarButtonItem *rightBarButtonItem;

@end

@implementation QRTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.layoutManager.allowsNonContiguousLayout = NO;
    self.textView.text = self.text;
    // Save
    NSMutableArray *dataArray = [NSMutableArray arrayWithContentsOfFile:MyQRCodeHistoryFile];
    if (self.text) {
        if (dataArray == nil) {
            dataArray = [[NSMutableArray alloc] init];
        }
        if ([dataArray containsObject:self.text]) {
            [dataArray removeObject:self.text];
        }
        [dataArray insertObject:self.text atIndex:0];
        [dataArray writeToFile:MyQRCodeHistoryFile atomically:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //
    [self setBackItemImage:[UIImage imageNamed:@"back_arrow.png"]];
    [self setBackItemTintColor:[UIColor blackColor]];
    //
    NSMutableArray *dataArray = [NSMutableArray arrayWithContentsOfFile:MyQRCodeHistoryFile];
    self.rightBarButtonItem.enabled = dataArray.count > 0;
}

#pragma mark Actions

- (IBAction)onCopy:(id)sender {
    [UIPasteboard generalPasteboard].string = self.textView.text;
    [SVProgressHUD showSuccessWithStatus:@"已复制到剪贴板"];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[QRListViewController class]]) {
        __weak typeof(self) weakSelf = self;
        QRListViewController *vc = (QRListViewController *)segue.destinationViewController;
        vc.didSelectBlock = ^(NSString *text) {
            weakSelf.textView.text = text;
        };
    }
}

@end
