//
//  ViewController.m
//  pickerViewDemo
//
//  Created by rjxy on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#define singerPickerView 0
#define singPickerView 1



@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
//    指定Delegate
    pickerView.delegate=self;
    pickerView.dataSource=self;
//    显示选中框
    pickerView.showsSelectionIndicator=YES;
    [self.view addSubview:pickerView]; 
//    获取mainBundle
    NSBundle *bundle = [NSBundle mainBundle];
//    获取songInfo.plist文件路径
    NSURL *songInfo = [bundle URLForResource:@"songInfo" withExtension:@"plist"];
//    把plist文件里内容存入数组
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:songInfo];
    pickerDictionary=dic;
//    将字典里面的内容取出放到数组中
    NSArray *components = [pickerDictionary allKeys];

//选取出第一个滚轮中的值    
    NSArray *sorted = [components sortedArrayUsingSelector:@selector(compare:)];
    
    singerData = sorted;
    
//    根据第一个滚轮中的值，选取第二个滚轮中的值
    NSString *selectedState = [singerData objectAtIndex:0];
    NSArray *array = [pickerDictionary objectForKey:selectedState];
    singData=array;
        
    
//     添加按钮   
    CGRect frame = CGRectMake(120, 250, 80, 40);
    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    selectButton.frame=frame;
    [selectButton setTitle:@"SELECT" forState:UIControlStateNormal];
    
    [selectButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:selectButton];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
//  关闭时清空数据  
    pickerDictionary=nil;
    singData=nil;
    singerData=nil;
    pickerDictionary=nil;
   
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void) buttonPressed:(id)sender
{
    //    获取选取器某一行索引值
    NSInteger singerrow =[pickerView selectedRowInComponent:singerPickerView];
    NSInteger singrow = [pickerView selectedRowInComponent:singPickerView];
    //   将singerData数组中值取出 
    NSString *selectedsinger = [singerData objectAtIndex:singerrow];
    NSString *selectedsing = [singData objectAtIndex:singrow];
    NSString *message = [[NSString alloc] initWithFormat:@"你选择了%@的%@",selectedsinger,selectedsing];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" 
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
    
}


#pragma mark -
#pragma mark Picker Date Source Methods

//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
//    返回几就有几个选取器
    return 2;
}
//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
 
    if (component==singerPickerView) {
        return [singerData count];
    }
    
        return [singData count];
    
}

#pragma mark Picker Delegate Methods

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==singerPickerView) {
        return [singerData objectAtIndex:row];
    }
    
        return [singData objectAtIndex:row];
    
    
}

-(void)pickerView:(UIPickerView *)pickerViewt didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    如果选取的是第一个选取器
    if (component == singerPickerView) {
//        得到第一个选取器的当前行
        NSString *selectedState =[singerData objectAtIndex:row];
        
//        根据从pickerDictionary字典中取出的值，选择对应第二个中的值
        NSArray *array = [pickerDictionary objectForKey:selectedState];
        singData=array;
        [pickerView selectRow:0 inComponent:singPickerView animated:YES];
        
        
//        重新装载第二个滚轮中的值
        [pickerView reloadComponent:singPickerView];
    }
}
//设置滚轮的宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == singerPickerView) {
        return 120;
    }
    return 200;
}
@end
