//
//  QRCodeViewController.m
//  MyQRCode
//
//  Created by xyz on 16/9/13.
//  Copyright © 2016年 xinyzhao. All rights reserved.
//

#import "QRCodeViewController.h"
#import "ZXColorPickerController.h"

@interface QRCodeViewController ()
@property (nonatomic, strong) NSString *originalText;
@property (nonatomic, strong) UIImage *originalImage;
@property (nonatomic, copy) UIColor *tintColor;
@property (nonatomic, copy) UIColor *backColor;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.originalText = self.text.length > 0 ? self.text : MyQRCodeURL;
    self.originalImage = [QRCodeGenerator imageWithText:self.originalText];
    self.backColor = [UIColor whiteColor];
    self.tintColor = [UIColor blackColor];
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

#pragma mark Properties

- (void)setBackColor:(UIColor *)backColor {
    _backColor = [backColor copy];
    _codeImageView.image = [QRCodeGenerator imageWithText:_originalText
                                                     size:_codeImageView.frame.size
                                                    color:_tintColor
                                          backgroundColor:_backColor];
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = [tintColor copy];
    _codeImageView.image = [QRCodeGenerator imageWithText:_originalText
                                                     size:_codeImageView.frame.size
                                                    color:_tintColor
                                          backgroundColor:_backColor];
}

#pragma mark Actions

- (IBAction)onSaveImage:(id)sender {
    __weak typeof(self) weakSelf = self;
    //
    __block ZXAlertView *alertView = nil;
    ZXAlertAction *cancelAction = [ZXAlertAction actionWithTitle:@"取消" handler:nil];
    ZXAlertAction *saveAction = [ZXAlertAction actionWithTitle:@"保存" handler:^(ZXAlertAction *action) {
        CGFloat width = [alertView.textFields[0].text floatValue];
        if (width < 1.f) {
            [SVProgressHUD showErrorWithStatus:@"输入的尺寸无效，请重试！"];
        } else if (width < weakSelf.originalImage.size.width) {
            ZXAlertView *alertView = [[ZXAlertView alloc] initWithTitle:@"警告" message:@"输入的尺寸小于二维码原始尺寸，这将造成信息丢失，确认保存？" cancelAction:[ZXAlertAction actionWithTitle:@"取消" handler:nil] otherActions:[ZXAlertAction actionWithTitle:@"保存" handler:^(ZXAlertAction *action) {
                [weakSelf saveImageWithSize:CGSizeMake(width, width)];
            }], nil];
            [alertView showInViewController:weakSelf];
        } else {
            [weakSelf saveImageWithSize:CGSizeMake(width, width)];
        }
    }];
    //
    alertView = [[ZXAlertView alloc] initWithTitle:@"保存到相册" message:@"请输入要保存二维码图像的尺寸" cancelAction:cancelAction otherActions:saveAction, nil];
    [alertView addTextField:^(UITextField *textField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.text = [NSString stringWithFormat:@"%.f", weakSelf.originalImage.size.width];
    }];
    [alertView showInViewController:self];
}

- (IBAction)onBackColor:(id)sender {
    ZXColorPickerController *vc = [[ZXColorPickerController alloc] init];
    vc.currentColor = self.backColor;
    [self.navigationController pushViewController:vc animated:YES];
    //
    __weak typeof(self) weakSelf = self;
    vc.completionBlock = ^(UIColor *color) {
        weakSelf.backColor = color;
    };
}

- (IBAction)onFillColor:(id)sender {
    ZXColorPickerController *vc = [[ZXColorPickerController alloc] init];
    vc.currentColor = self.tintColor;
    [self.navigationController pushViewController:vc animated:YES];
    //
    __weak typeof(self) weakSelf = self;
    vc.completionBlock = ^(UIColor *color) {
        weakSelf.tintColor = color;
    };
}

#pragma mark Save Image

- (void)saveImageWithSize:(CGSize)size {
    [SVProgressHUD showWithStatus:@"保存二维码..."];
    UIImage *image = [QRCodeGenerator imageWithText:self.originalText size:size color:self.tintColor backgroundColor:self.backColor];
    if (image) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

@end
