//
//  QRCopyrightView.m
//  MyQRCode
//
//  Created by xyz on 16/9/13.
//  Copyright © 2016年 xinyzhao. All rights reserved.
//

#import "QRCopyrightView.h"

@implementation QRCopyrightView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.copyrightLabel.text = @"Copyright (c) 2016-2017 by XYZ.";
    self.homepageLabel.text = @"https://www.github.com/xinyzhao";
}

- (IBAction)onCopyright:(id)sender {
    NSURL *url = [NSURL URLWithString:MyQRCodeURL];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
