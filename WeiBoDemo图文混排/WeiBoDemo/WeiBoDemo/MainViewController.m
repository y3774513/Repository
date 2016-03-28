//
//  MainViewController.m
//  WeiBoDemo
//
//  Created by 千牛互动  on 13-11-5.
//  Copyright (c) 2013年 余家峰. All rights reserved.
//

#import "MainViewController.h"
#import "RCLabel.h"
#import "RCViewCell.h"
#import "HtmlString.h"
#import "AFJSONRequestOperation.h"
#import "UIImage+imageNamed_Hack.h"
#define TWITTER_LEFTWIDTH 62
#define ModelSize [[UIScreen mainScreen]bounds].size
#define CELL_INFO_IMG_BTN_TAG 10000
#define CELL_RES_IMG_BTN_TAG 2000000
#define TWITTER_FONTSIZE_NAME 15
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
    
    _dataArr=[[NSMutableArray alloc]init];
    [self requestdata];
}
-(void)requestdata
{
//   此处是使用AFJSONRequest获取网络数据，如果不会的可以查看相关网络资料
    NSURL *url=[NSURL URLWithString:@"http://api.1600.com/WeiBo/GetMessageAt/24/fb908906812ea2f99fd10bdf9da542203df1184b4a5a8eaa9655bcbedcdff806/0/0/20?token=bypass"];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
    request.timeoutInterval=20;
    AFJSONRequestOperation *operation=[AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                                       {
                                           if ([[[JSON objectForKey:@"Head"] objectForKey:@"ErrCode"] intValue]==1000) {
                                               
                                               [_dataArr addObjectsFromArray:[[JSON objectForKey:@"Body"] objectForKey:@"weiboInfos"]];
                                               [_tableView reloadData];
                                               
                                               
                                               
                                               
                                           }else
                                           {
                                              
                                           }
                                       }
                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
                                       {
                                       }];
    [operation start];
    [request release];

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CGFloat height_total = 35;
    if (_dataArr.count) {
        if (![@""isEqualToString:[[_dataArr objectAtIndex:indexPath.row] objectForKey:@"content"]]) {
            NSString *transformStr = [HtmlString transformString:[[_dataArr objectAtIndex:indexPath.row]  objectForKey:@"content"]];
            RCLabelComponentsStructure *componentsDS = [RCLabel extractTextStyle:transformStr];
            RCLabel *tempLabel = [[RCLabel alloc] initWithFrame:CGRectMake(TWITTER_LEFTWIDTH, height_total, ModelSize.width-TWITTER_LEFTWIDTH-10,100)];
            tempLabel.componentsAndPlainText = componentsDS;
            CGSize optimalSize = [tempLabel optimumSize:YES];
            [tempLabel release];
            height_total += optimalSize.height + 15;
        }
        
        if (![[[_dataArr objectAtIndex:indexPath.row]  objectForKey:@"imgs"]isEqual:[NSNull null]]&&[[[_dataArr objectAtIndex:indexPath.row]  objectForKey:@"imgs"]count]>0) {
            height_total += 70;
        }
        if ([[[_dataArr objectAtIndex:indexPath.row]  objectForKey:@"forecastId"] intValue]>0) {
            height_total += 70;
        }
        if (![[[_dataArr objectAtIndex:indexPath.row]  objectForKey:@"oriWeiBo"]isEqual:[NSNull null]])
        {
            height_total+=5;
            NSDictionary *tempdic = [[_dataArr objectAtIndex:indexPath.row]  objectForKey:@"oriWeiBo"];
            if ([[tempdic objectForKey:@"isDelete"] intValue]==1) {
                NSString *contStr=@"";
                NSString *transformStr = [HtmlString transformString:contStr];
                
                RCLabelComponentsStructure *componentsDS = [RCLabel extractTextStyle:transformStr];
                RCLabel *tempLabel = [[RCLabel alloc] initWithFrame:CGRectMake(TWITTER_LEFTWIDTH+5, height_total, ModelSize.width-TWITTER_LEFTWIDTH-23,100)];
                tempLabel.componentsAndPlainText = componentsDS;
                CGSize optimalSize = [tempLabel optimumSize:YES];
                [tempLabel release];
                
                height_total += optimalSize.height +5;
            }else
            {
                if (![@""isEqualToString:[tempdic objectForKey:@"content"]]) {
                    NSString *contStr=[NSString stringWithFormat:@"%@%@ :%@",@"@",[tempdic objectForKey:@"nick"],[tempdic objectForKey:@"content"]];
                    NSString *transformStr = [HtmlString transformString:contStr];
                    
                    RCLabelComponentsStructure *componentsDS = [RCLabel extractTextStyle:transformStr];
                    RCLabel *tempLabel = [[RCLabel alloc] initWithFrame:CGRectMake(TWITTER_LEFTWIDTH+5, height_total, ModelSize.width-TWITTER_LEFTWIDTH-23,100)];
                    tempLabel.componentsAndPlainText = componentsDS;
                    CGSize optimalSize = [tempLabel optimumSize:YES];
                    [tempLabel release];
                    
                    height_total += optimalSize.height +5;
                }
                if (![[tempdic objectForKey:@"imgs"]isEqual:[NSNull null]]&&[[tempdic objectForKey:@"imgs"]count]>0) {
                    height_total += 70;
                }
                if ([[tempdic objectForKey:@"forecastId"] intValue]>0) {
                    height_total += 70;
                }
            }
            height_total+=5;
        }
        height_total += 10+18;
    }
    height_total +=10;
    return height_total;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *CellIdentifier = @"RCViewCell";
        RCViewCell *cell = (RCViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[[RCViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (_dataArr.count>0) {
            NSMutableDictionary *infoDic=[_dataArr objectAtIndex:indexPath.row];
            CGFloat height_total = 0;
            cell.personName.text=[infoDic objectForKey:@"nick"];
            CGFloat width = MIN([cell.personName.text sizeWithFont:[UIFont systemFontOfSize:TWITTER_FONTSIZE_NAME] constrainedToSize:CGSizeMake(1000, 21) lineBreakMode:NSLineBreakByCharWrapping].width,200);
            cell.personName.frame = CGRectMake(TWITTER_LEFTWIDTH, 5, width, 25);
 
            if (![[infoDic objectForKey:@"faceImg"] isEqual:[NSNull null]])
            {
                
               [cell.personImg setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"faceImg"]]refreshCache:YES placeholderImage:[UIImage selfimageNamed:@"default_avatar@2x.png"]];
                CALayer * layer = [cell.personImg layer];
                [layer setMasksToBounds:YES];
                [layer setCornerRadius:4.0];
                cell.personImgBtn.tag=indexPath.row;
               // [cell.personImgBtn addTarget:self action:@selector(txButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            }
            height_total +=35;
            
            if (![@""isEqualToString:[infoDic objectForKey:@"content"]]) {
                NSString *transformStr = [HtmlString transformString:[infoDic objectForKey:@"content"]];
                RCLabelComponentsStructure *componentsDS = [RCLabel extractTextStyle:transformStr];
                cell.RCLabel.delegate=self;
                cell.RCLabel.componentsAndPlainText = componentsDS;
                RCLabel *tempLabel = [[RCLabel alloc] initWithFrame:CGRectMake(TWITTER_LEFTWIDTH, height_total, ModelSize.width-TWITTER_LEFTWIDTH-10,100)];
                tempLabel.componentsAndPlainText = componentsDS;
                CGSize optimalSize = [tempLabel optimumSize:YES];
                [tempLabel release];
                cell.RCLabel.frame = CGRectMake(TWITTER_LEFTWIDTH, height_total, ModelSize.width-TWITTER_LEFTWIDTH-10, optimalSize.height+15);
                height_total += optimalSize.height+15;
            }else
            {
                cell.RCLabel.frame=CGRectZero;
            }
            
            if (![[infoDic objectForKey:@"imgs"]isEqual:[NSNull null]]&&[[infoDic objectForKey:@"imgs"]count]>0) {
                /*
                 开一个新的线程去下载图片，图片显示的区域固定了70*70的范围
                 Imgs是图片url数组
                 indexPath是记录显示图片的路径
                 isOriginal标记是否是原文图片
                 */
                NSDictionary *cell_data = [NSDictionary dictionaryWithObjectsAndKeys:
                                           [infoDic objectForKey:@"imgs"],@"imgs",
                                           indexPath, @"indexPath",
                                           [NSNumber numberWithFloat:height_total],@"height",[infoDic objectForKey:@"userId"],@"UserID",
                                           [NSNumber numberWithBool:NO],@"isOriginal",
                                           nil];
                
                if ([[infoDic objectForKey:@"imgs"] count]>1) {
                    cell.contImageFlag.image=[UIImage selfimageNamed:@"more_image@2x.png"];
                    cell.contImageFlag.frame=CGRectMake(TWITTER_LEFTWIDTH+70+2, height_total+70-12, 21, 12);
                }else
                {
                    cell.contImageFlag.image=nil;
                }
                cell.contImage.frame = CGRectMake(TWITTER_LEFTWIDTH, height_total, 70 ,70);
                [cell.contImage setBackgroundColor:[UIColor whiteColor]];
             //   cell.contImage.image = [UIImage selfimageNamed:TWITTER_IMG_DEFAULT];
                cell.contImageBtn.tag=indexPath.row;
                [cell.contImageBtn addTarget:self action:@selector(showImages:) forControlEvents:UIControlEventTouchUpInside];
          //      [NSThread detachNewThreadSelector:@selector(startImageread:) toTarget:self withObject:cell_data];
                height_total += 70;
            }else
            {
                cell.contImage.frame=CGRectZero;
                cell.contImageFlag.frame=CGRectZero;
                cell.contImageBtn.frame=CGRectZero;
            }
            
            if ([[infoDic objectForKey:@"forecastId"] intValue]>0) {
                cell.forcaseBtn.frame=CGRectMake(TWITTER_LEFTWIDTH, height_total,70, 70);
                cell.forcaseBtn.tag=indexPath.row;
                [ cell.forcaseBtn setBackgroundImage:[UIImage selfimageNamed:@"forcase_style@2x.png"] forState:UIControlStateNormal];
            //    [ cell.forcaseBtn addTarget:self action:@selector(toForcaseView:) forControlEvents:UIControlEventTouchUpInside];
                height_total += 70;
            }else
            {
                cell.forcaseBtn.frame=CGRectZero;
            }
            
            if (![[infoDic objectForKey:@"oriWeiBo"]isEqual:[NSNull null]])
            {
                NSDictionary *tempdic = [infoDic objectForKey:@"oriWeiBo"];
                CGFloat bg = 10;
                height_total+=5;
                if ([[tempdic objectForKey:@"isDelete"] intValue]==1) {
                    NSString *contStr=@"";
                    NSString *transformStr = [HtmlString transformString:contStr];
                    cell.oriLabel.delegate=self;
                    [cell.oriLabel setBackgroundColor:[UIColor clearColor]];
                    [cell.oriLabel setFont:[UIFont fontWithName:@"Arial" size:16]];
                    RCLabelComponentsStructure *componentsDS = [RCLabel extractTextStyle:transformStr];
                    cell.oriLabel.componentsAndPlainText = componentsDS;
                    
                    RCLabel *tempLabel = [[RCLabel alloc] initWithFrame:CGRectMake(TWITTER_LEFTWIDTH+5, height_total, ModelSize.width-TWITTER_LEFTWIDTH-23,100000)];
                    tempLabel.componentsAndPlainText = componentsDS;
                    CGSize optimalSize = [tempLabel optimumSize:YES];
                    [tempLabel release];
                    
                    cell.oriLabel.frame = CGRectMake(TWITTER_LEFTWIDTH+5, height_total+5, ModelSize.width-TWITTER_LEFTWIDTH-23, optimalSize.height +5);
                    height_total += optimalSize.height+5 ;
                    bg += optimalSize.height +5;
                    
                }else
                {
                    if (![@""isEqualToString:[tempdic objectForKey:@"content"]]) {
                        NSString *contStr=[NSString stringWithFormat:@"%@%@ :%@",@"@",[tempdic objectForKey:@"nick"],[tempdic objectForKey:@"content"]];
                        NSString *transformStr = [HtmlString transformString:contStr];
                        cell.oriLabel.delegate=self;
                        [cell.oriLabel setBackgroundColor:[UIColor clearColor]];
                        [cell.oriLabel setFont:[UIFont fontWithName:@"Arial" size:16]];
                        RCLabelComponentsStructure *componentsDS = [RCLabel extractTextStyle:transformStr];
                        cell.oriLabel.componentsAndPlainText = componentsDS;
                        
                        RCLabel *tempLabel = [[RCLabel alloc] initWithFrame:CGRectMake(TWITTER_LEFTWIDTH+5, height_total, ModelSize.width-TWITTER_LEFTWIDTH-23,100000)];
                        tempLabel.componentsAndPlainText = componentsDS;
                        CGSize optimalSize = [tempLabel optimumSize:YES];
                        [tempLabel release];
                        
                        cell.oriLabel.frame = CGRectMake(TWITTER_LEFTWIDTH+5, height_total+5, ModelSize.width-TWITTER_LEFTWIDTH-23, optimalSize.height +5);
                        height_total += optimalSize.height +5;
                        bg += optimalSize.height +5;
                    }else
                    {
                        cell.oriLabel.frame=CGRectZero;
                    }
                    if (![[tempdic objectForKey:@"imgs"]isEqual:[NSNull null]]&&[[tempdic objectForKey:@"imgs"]count]>0) {
                        NSDictionary *cell_data = [NSDictionary dictionaryWithObjectsAndKeys:
                                                   [tempdic objectForKey:@"imgs"],@"imgs",
                                                   indexPath, @"indexPath",
                                                   [NSNumber numberWithFloat:height_total],@"height",[tempdic objectForKey:@"userId"],@"UserID",
                                                   [NSNumber numberWithBool:YES],@"isOriginal",
                                                   nil];
                        if ([[tempdic objectForKey:@"imgs"] count]>1) {
                            cell.ori_imageFlag.image=[UIImage selfimageNamed:@"more_image@2x.png"];
                            cell.ori_imageFlag.frame=CGRectMake(TWITTER_LEFTWIDTH+70+2, height_total+70-12, 21, 12);
                        }else
                        {
                            cell.ori_imageFlag.image=nil;
                        }
                        cell.ori_image.frame = CGRectMake(TWITTER_LEFTWIDTH+5, height_total, 70, 70);
                  //      cell.ori_image.image = [UIImage selfimageNamed:TWITTER_IMG_DEFAULT];
                        cell.ori_imageBtn.tag = CELL_RES_IMG_BTN_TAG+indexPath.row;
                        [cell.ori_imageBtn addTarget:self action:@selector(showImages:) forControlEvents:UIControlEventTouchUpInside];
                        [NSThread detachNewThreadSelector:@selector(startImageread:) toTarget:self withObject:cell_data];
                        height_total += 70;
                        bg +=70;
                    }else
                    {
                        cell.ori_image.frame=CGRectZero;
                        cell.ori_imageBtn.frame=CGRectZero;
                        cell.ori_imageFlag.frame=CGRectZero;
                    }
                    if ([[tempdic objectForKey:@"forecastId"] intValue]>0) {
                        cell.oriForcaseBtn.frame=CGRectMake(TWITTER_LEFTWIDTH+5, height_total,70, 70);
                        cell.oriForcaseBtn.tag=indexPath.row;
                        [ cell.oriForcaseBtn setBackgroundImage:[UIImage selfimageNamed:@"forcase_style@2x.png"] forState:UIControlStateNormal];
              //          [ cell.oriForcaseBtn addTarget:self action:@selector(toForcaseView:) forControlEvents:UIControlEventTouchUpInside];
                        bg+=70;
                        height_total += 70;
                    }else
                    {
                        cell.oriForcaseBtn.frame=CGRectZero;
                    }
                }
                cell.ori_backImage.image = [[UIImage selfimageNamed:@"timeline_rt_border.png"]stretchableImageWithLeftCapWidth:30 topCapHeight:14];
                cell.ori_backImage.frame = CGRectMake(TWITTER_LEFTWIDTH, height_total-bg, ModelSize.width-TWITTER_LEFTWIDTH-10, bg+5);
                height_total+=5;
            }else
            {
                cell.ori_image.frame =CGRectZero;
                cell.ori_imageFlag.frame =CGRectZero;
                cell.ori_imageBtn.frame =CGRectZero;
                cell.oriLabel.frame =CGRectZero;
                cell.oriForcaseBtn.frame =CGRectZero;
                cell.ori_backImage.frame =CGRectZero;
            }
            height_total += 10;
            cell.agreeNumLabel.text=[NSString stringWithFormat:@" %d",[[infoDic objectForKey:@"commentNum"]intValue]+[[infoDic objectForKey:@"forwardNum"]intValue]] ;
            CGFloat zt_width = [cell.agreeNumLabel.text sizeWithFont:[UIFont systemFontOfSize:12.0f]].width;
            cell.agreeNumLabel.frame = CGRectMake(ModelSize.width-10-zt_width, height_total, zt_width+10, 18);
            cell.agreeImage.frame = CGRectMake(ModelSize.width-10-zt_width-20, height_total, 18, 18);
        }
        return cell;
}
-(IBAction)toForcaseView:(id)sender
{
    NSLog(@"fwefwefwef");
}




#pragma mark: RCLabelDelegate
-(void)RCLabel:(id)RCLabel didSelectLinkWithURL:(NSString *)url
{
    
    NSLog(@"url======%@",url);
}

#pragma mark - 多线程加载数据cell
//多线程加载图片
-(void)startImageread:(NSDictionary *)data
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSArray *array = [data objectForKey:@"imgs"];
    NSString *string = [array objectAtIndex:0];
    UIImage *newimage=nil;
    newimage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:string]]];//读取的图片
////    if (newimage==nil) {
//        newimage=[UIImage selfimageNamed:TWITTER_IMG_DEFAULT];
//    }
    NSDictionary *cellimage = [NSDictionary dictionaryWithObjectsAndKeys:
                               [data objectForKey:@"indexPath"], @"indexPath",
                               [data objectForKey:@"height"],@"height",
                               newimage,@"image",
                               [data objectForKey:@"isOriginal"],@"isOriginal",array,@"imgs",
                               nil];
    [self performSelectorOnMainThread:@selector(_setOCellImage:) withObject:cellimage waitUntilDone:NO];
    [pool release];
}
-(void)_setOCellImage:(id)celldata
{
    UIImage *newimage=[celldata objectForKey:@"image"];//从参数celldata里面拿出来图片
    RCViewCell *currentCell=(RCViewCell *)[_tableView cellForRowAtIndexPath:[celldata objectForKey:@"indexPath"]];
    CGFloat scale = 1.0;
    CGFloat w = 1.0;
    CGFloat h = 1.0;
    if (newimage.size.width>60) {
        w = newimage.size.width/60;
    }
    if (newimage.size.height>60) {
        h = newimage.size.height/60;
    }
    scale = w>h?w:h;
    CGFloat width = newimage.size.width/scale;
    CGFloat height = newimage.size.height/scale;
    if ([[celldata objectForKey:@"isOriginal"]boolValue]==NO) {
        currentCell.contImage.image = newimage;
        currentCell.contImage.frame = CGRectMake(TWITTER_LEFTWIDTH, [[celldata objectForKey:@"height"]floatValue]+(60-height)/2, width, height);
        currentCell.contImageBtn.frame = currentCell.contImage.frame;
        if ([[celldata objectForKey:@"imgs"] count]>1) {
            currentCell.contImageFlag.frame = CGRectMake(TWITTER_LEFTWIDTH+width+2, [[celldata objectForKey:@"height"]floatValue]+(60-height)/2+height-12, 21, 12);
        }
    }else
    {
        currentCell.ori_image.image = newimage;
        currentCell.ori_image.frame = CGRectMake(TWITTER_LEFTWIDTH+10, [[celldata objectForKey:@"height"]floatValue]+(60-height)/2, width,height);
        currentCell.ori_imageBtn.frame = currentCell.ori_image.frame;
        if ([[celldata objectForKey:@"imgs"] count]) {
            currentCell.ori_imageFlag.frame = CGRectMake(TWITTER_LEFTWIDTH+10+width+2, [[celldata objectForKey:@"height"]floatValue]+(60-height)/2+height-12, 21,12);
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
