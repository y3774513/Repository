//
//  UIImage+imageNamed_Hack.m
//  apns
//
//  Created by 千牛互动  on 13-3-5.
//  Copyright (c) 2013年 千牛互动. All rights reserved.
//

#import "UIImage+imageNamed_Hack.h"

@implementation UIImage (imageNamed_Hack)
+ (UIImage *)selfimageNamed:(NSString *)name {
    
    return [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath], name ] ];
}
@end
