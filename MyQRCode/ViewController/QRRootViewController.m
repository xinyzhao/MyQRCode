//
//  QRRootViewController.m
//  MyQRCode
//
//  Created by xyz on 16/9/13.
//  Copyright © 2016年 xinyzhao. All rights reserved.
//

#import "QRRootViewController.h"
#import "QRCodeViewController.h"
#import "QRTextViewController.h"

@interface QRRootViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation QRRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.generatorButton.layer.cornerRadius = self.generatorButton.frame.size.height / 10;
    self.generatorButton.layer.masksToBounds = YES;
    self.scannerButton.layer.cornerRadius = self.scannerButton.frame.size.height / 10;
    self.scannerButton.layer.masksToBounds = YES;
    self.readerButton.layer.cornerRadius = self.readerButton.frame.size.height / 10;
    self.readerButton.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[QRCodeViewController class]]) {
        QRCodeViewController *vc = (QRCodeViewController *)segue.destinationViewController;
        vc.text = self.textView.text;
    }
}

#pragma mark <UIImagePickerControllerDelegate>

- (IBAction)onPhotoLibrary:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        [SVProgressHUD showInfoWithStatus:@"请在“设置-隐私-照片”中开启访问权限！"];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSArray *array = [QRCodeReader decodeQRCodeImage:image];
    QRTextViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"QRTextViewController"];
    vc.text = [array componentsJoinedByString:@"\n\n"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
