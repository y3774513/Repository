//
//  ViewController.h
//  pickerViewDemo
//
//  Created by rjxy on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
//定义滑轮组建
    UIPickerView *pickerView;
//    储存第一个选取器的的数据
    NSArray *singerData;
//    储存第二个选取器
    NSArray *singData;
//    读取plist文件数据
    NSDictionary *pickerDictionary;

}

-(void) buttonPressed:(id)sender;

@end
