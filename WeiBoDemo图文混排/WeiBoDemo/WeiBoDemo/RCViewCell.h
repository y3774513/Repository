//
//  RCViewCell.h
//  RCLabel
//
//  Created by Hang Chen on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCLabel.h"

@interface RCViewCell : UITableViewCell {
	RCLabel *RCLabel;
    RCLabel *oriLabel;
}
@property(nonatomic,retain)  RCLabel *oriLabel;
@property (nonatomic, retain) RCLabel *RCLabel;
@property (retain, nonatomic)  UIImageView *personImg;
@property (retain, nonatomic)  UIImageView *personLevel1;
@property (retain, nonatomic)  UIImageView *personLevel2;
@property (retain, nonatomic)  UIImageView *personLevel3;
@property (retain, nonatomic)  UILabel *personName;
@property (retain, nonatomic)  UIButton *personImgBtn;
@property (retain, nonatomic)  UILabel *timelabel;
@property (retain, nonatomic)  UILabel *agreeNumLabel;
@property (nonatomic, retain)  UIImageView *agreeImage;
@property (retain, nonatomic)  UIImageView *contImage;
@property (retain, nonatomic)  UIImageView *contImageFlag;
@property (retain, nonatomic)  UIImageView *ori_backImage;
@property (retain, nonatomic)  UIImageView *ori_image;
@property (retain, nonatomic)  UIImageView *ori_imageFlag;
@property (retain, nonatomic)  UIButton *contImageBtn;
@property (retain, nonatomic)  UIButton *ori_imageBtn;
@property (retain, nonatomic)  UIButton *forcaseBtn;
@property(retain ,nonatomic)   UIButton *oriForcaseBtn;

@property(retain,nonatomic) UIButton *comentBtn;











@end
