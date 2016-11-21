//
//  QRCopyrightView.m
//  MyQRCode
//
//  Created by xyz on 16/9/13.
//  Copyright © 2016年 xinyzhao. All rights reserved.
//

#import "QRCopyrightView.h"

@implementation QRCopyrightView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)onCopyright:(id)sender {
    NSURL *url = [NSURL URLWithString:MyQRCodeURL];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
