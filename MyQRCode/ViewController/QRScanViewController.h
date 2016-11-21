//
//  QRScanViewController.h
//  MyQRCode
//
//  Created by xyz on 16/9/13.
//  Copyright © 2016年 xinyzhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRScanViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>
@property (weak, nonatomic) IBOutlet UIView *scanView;
@property (weak, nonatomic) IBOutlet UIImageView *scanLine;
@property (nonatomic, strong) QRCodeScanner *scanner;

@end
