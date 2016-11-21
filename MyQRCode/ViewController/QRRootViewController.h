//
//  QRRootViewController.h
//  MyQRCode
//
//  Created by xyz on 16/9/13.
//  Copyright © 2016年 xinyzhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRRootViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *generatorButton;
@property (weak, nonatomic) IBOutlet UIButton *scannerButton;
@property (weak, nonatomic) IBOutlet UIButton *readerButton;

@end
