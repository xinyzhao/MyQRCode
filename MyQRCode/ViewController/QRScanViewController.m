//
//  QRScanViewController.m
//  MyQRCode
//
//  Created by xyz on 16/9/13.
//  Copyright © 2016年 xinyzhao. All rights reserved.
//

#import "QRScanViewController.h"
#import "QRTextViewController.h"

@interface QRScanViewController ()

@end

@implementation QRScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scanner = [[QRCodeScanner alloc] initWithPreview:self.view captureRect:self.scanView.frame];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //
    [self setBackItemImage:[UIImage imageNamed:@"back_arrow.png"]];
    [self setBackItemTintColor:[UIColor blackColor]];
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startScanning) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopScanning) name:UIApplicationWillResignActiveNotification object:nil];
    // 开始捕获
    [self startScanning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //
    [self stopScanning];
}

#pragma mark - Status Bar

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 扫描动画

- (void)startScanning {
    if (!self.scanner.isScanning) {
        [self startAnimating];
        __weak typeof(self) weakSelf = self;
        [self.scanner startScanning:^(NSArray<NSString *> *results) {
            // 停止扫描
            [weakSelf stopScanning];
            // 输出扫描字符串
            NSString *str = [results componentsJoinedByString:@"\n\n"];
            [self performSegueWithIdentifier:@"QRTextViewController" sender:str];
        }];
    }
}

- (void)stopScanning {
    [self.scanner stopScanning];
    self.scanLine.hidden = YES;
}

- (void)startAnimating {
    static CGFloat x = 2;
    static CGFloat y = 2;
    //
    self.scanLine.frame = CGRectMake(x, y, self.scanView.frame.size.width - x * 2, self.scanLine.frame.size.height);
    self.scanLine.alpha = 0.f;
    self.scanLine.hidden = NO;
    //
    __weak typeof(self) wself = self;
    [UIView animateKeyframesWithDuration:3.0 delay:0 options:UIViewKeyframeAnimationOptionRepeat animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.1 animations:^{
            wself.scanLine.alpha = 1.f;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:^{
            wself.scanLine.frame = CGRectMake(x, wself.scanView.frame.size.height - wself.scanLine.frame.size.height - y,
                                              wself.scanView.frame.size.width - x * 2, wself.scanLine.frame.size.height);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.9 relativeDuration:0.1 animations:^{
            wself.scanLine.alpha = 0.f;
        }];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[QRTextViewController class]]) {
        QRTextViewController *vc = (QRTextViewController *)segue.destinationViewController;
        vc.text = sender;
    }
}

- (IBAction)onLight:(id)sender {
    if (self.scanner.torchMode != AVCaptureTorchModeOn) {
        self.scanner.torchMode = AVCaptureTorchModeOn;
        self.navigationItem.rightBarButtonItem.title = @"关灯";
    } else {
        self.scanner.torchMode = AVCaptureTorchModeOff;
        self.navigationItem.rightBarButtonItem.title = @"开灯";
    }
}

@end
