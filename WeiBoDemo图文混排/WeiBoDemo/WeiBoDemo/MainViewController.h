//
//  MainViewController.h
//  WeiBoDemo
//
//  Created by 千牛互动  on 13-11-5.
//  Copyright (c) 2013年 余家峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCLabel.h"
@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,RCLabelDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArr;
}
@end
