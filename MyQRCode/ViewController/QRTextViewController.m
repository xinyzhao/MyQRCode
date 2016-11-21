//
//  QRTextViewController.m
//  MyQRCode
//
//  Created by xyz on 16/9/13.
//  Copyright © 2016年 xinyzhao. All rights reserved.
//

#import "QRTextViewController.h"

@interface QRTextViewController ()

@end

@implementation QRTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.layoutManager.allowsNonContiguousLayout = NO;
    self.textView.text = self.text;
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
}

- (IBAction)onCopy:(id)sender {
    [UIPasteboard generalPasteboard].string = self.textView.text;
    [SVProgressHUD showSuccessWithStatus:@"已复制到剪贴板"];
}

@end
