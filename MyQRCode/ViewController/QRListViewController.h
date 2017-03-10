//
//  QRListViewController.h
//  MyQRCode
//
//  Created by xyz on 2017/3/10.
//  Copyright © 2017年 xinyzhao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^QRListViewDidSelectBlock)(NSString *text);

@interface QRListViewController : UITableViewController
@property (nonatomic, copy) QRListViewDidSelectBlock didSelectBlock;

@end
