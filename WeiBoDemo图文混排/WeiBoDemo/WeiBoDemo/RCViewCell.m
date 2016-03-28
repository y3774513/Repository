//
//  RCViewCell.m
//  RCLabel
//
//  Created by Hang Chen on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RCViewCell.h"
#import <QuartzCore/QuartzCore.h>
#define ModelSize [[UIScreen mainScreen]bounds].size
#define CELL_INFO_IMG_BTN_TAG 10000
#define CELL_RES_IMG_BTN_TAG 2000000
#define TWITTER_FONTSIZE_NAME 15

#define TWITTER_LEFTWIDTH 62
#define MAX_TEXT_LENGTH 140
#define TWITTER_FONTSIZE_INFO 15
#define TWITTER_FONTSIZE_TITLE 16
#define TWITTER_FONTSIZE_NAME 15
#define TWITTER_FONTSIZE_TIME 12
#define TWITTER_TEXTCOLOR_INFO [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0]
#define TWITTER_TEXTCOLOR_TIME [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0]
#define SELECTED_COLOR [UIColor colorWithRed:27.0/255 green:116.0/255 blue:174.0/255 alpha:1.0f]//信息流tap切换选中的文字颜色
#define TextName @"Arial"
@implementation RCViewCell
@synthesize RCLabel;
@synthesize agreeImage;
@synthesize oriLabel;
@synthesize oriForcaseBtn;
@synthesize personImg,personLevel1,personLevel2,personLevel3,personName,personImgBtn,timelabel,agreeNumLabel,contImage,contImageFlag,ori_backImage,ori_image,ori_imageFlag,contImageBtn,ori_imageBtn,forcaseBtn,comentBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor=[UIColor colorWithRed:251.0/255 green:249.0/255 blue:249.0/255 alpha:1.0];
        
        UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ModelSize.width, 1)];
        [line setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:line];
        [line release];
        
        
        personImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        personImg.image=[UIImage imageNamed:@"default_avatar@2x.png"];
        [self.contentView addSubview:personImg];
        
        personImgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        personImgBtn.frame=CGRectMake(10, 10, 40, 40);
        [self.contentView addSubview:personImgBtn];
        
        personName=[[UILabel alloc] initWithFrame:CGRectMake(TWITTER_LEFTWIDTH, 15, 200, 21)];
        personName.backgroundColor = [UIColor clearColor];
        personName.textAlignment=NSTextAlignmentLeft;
        personName.textColor = TWITTER_TEXTCOLOR_INFO;
        personName.font = [UIFont systemFontOfSize:TWITTER_FONTSIZE_NAME];
        [self.contentView  addSubview:personName];
        
        //时间
        timelabel=[[UILabel alloc] initWithFrame:CGRectMake(210, 8, 100, 20)];
        timelabel.backgroundColor = [UIColor clearColor];
        timelabel.textColor = TWITTER_TEXTCOLOR_TIME;
        timelabel.textAlignment = NSTextAlignmentRight;
        timelabel.font = [UIFont fontWithName:TextName size:TWITTER_FONTSIZE_TIME];//[UIFont systemFontOfSize:TWITTER_FONTSIZE_TIME];
        [self  addSubview:timelabel];

        personLevel1=[[UIImageView alloc] initWithFrame:CGRectZero];
        personLevel2=[[UIImageView alloc] initWithFrame:CGRectZero];
        personLevel3=[[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:personLevel1];
        [self.contentView addSubview:personLevel2];
        [self.contentView addSubview:personLevel3];
        
        RCLabel *label = [[RCLabel alloc] initWithFrame:CGRectMake(TWITTER_LEFTWIDTH, 35, ModelSize.width-TWITTER_LEFTWIDTH-10,100)];
		self.RCLabel = label;
        [label release];
		[self.contentView addSubview:self.RCLabel];

        contImage=[[UIImageView alloc] initWithFrame:CGRectZero];
        contImageFlag=[[UIImageView alloc] initWithFrame:CGRectZero];
        contImageBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        contImageBtn.frame=CGRectZero;
        
        forcaseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        forcaseBtn.frame=CGRectZero;
        [self.contentView addSubview:contImage];
        [self.contentView addSubview:contImageFlag];
        [self.contentView addSubview:contImageBtn];
        [self.contentView addSubview:forcaseBtn];

        //背景回复框
        ori_backImage=[[UIImageView alloc] initWithFrame:CGRectZero];
        ori_backImage.image=[UIImage imageNamed:@"timeline_rt_border.png"];
        [ori_backImage.image stretchableImageWithLeftCapWidth:130 topCapHeight:14];
        [self.contentView addSubview:ori_backImage];

        oriLabel=[[RCLabel alloc] initWithFrame:CGRectMake(TWITTER_LEFTWIDTH, 35, ModelSize.width-TWITTER_LEFTWIDTH-20,100)];
        self.oriLabel=oriLabel;
        [self.contentView addSubview:oriLabel];

        ori_image=[[UIImageView alloc] initWithFrame:CGRectZero];
        ori_imageFlag=[[UIImageView alloc]initWithFrame:CGRectZero];
        ori_imageBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        oriForcaseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:ori_image];
        [self.contentView addSubview:ori_imageFlag];
        [self.contentView addSubview:ori_imageBtn];
        [self.contentView addSubview:oriForcaseBtn];
        
        
        
        agreeImage= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"agree@2x.png"]];
        agreeImage.frame=CGRectMake(ModelSize.width-80, self.frame.size.height-30, 18, 18);


        agreeNumLabel=[[UILabel alloc] init];
        agreeNumLabel.frame=CGRectMake(ModelSize.width-60, self.frame.size.height-30, 60 ,18);
        agreeNumLabel.backgroundColor = [UIColor clearColor];
        agreeNumLabel.textColor = TWITTER_TEXTCOLOR_TIME;
        agreeNumLabel.font =[UIFont fontWithName:TextName size:12];// [UIFont systemFontOfSize:TWITTER_FONTSIZE_TIME];
        
        
        comentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        comentBtn.frame=CGRectZero;
        [comentBtn setBackgroundImage:[UIImage imageNamed:@"response_bg@2x.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:comentBtn];
        
        [self.contentView addSubview:agreeNumLabel];
        [self.contentView addSubview:agreeImage];
    }
    return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	CGSize optimumSize = [self.RCLabel optimumSize:YES];
	CGRect frame = [self.RCLabel frame];
	frame.size.height = (int)optimumSize.height + 15;
	[self.RCLabel setFrame:frame];
}

- (void)dealloc {
	self.RCLabel = nil;
    [personImg release];
    [personLevel1 release];
    [personLevel2 release];
    [personLevel3 release];
    [personName release];
    [timelabel release];
    [agreeNumLabel release];
    [contImage release];
    [contImageFlag release];
    [ori_backImage release];
    [ori_image release];
    [ori_imageFlag release];
    [super dealloc];
}
@end

