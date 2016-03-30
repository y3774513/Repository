//
//  APPHeader.h
//  LessonProject
//
//  Created by young on 15/10/4.
//  Copyright © 2015年 LO.Young. All rights reserved.
//

#ifndef APPHeader_h
#define APPHeader_h

#define kHeight      [[UIScreen mainScreen] bounds].size.height
#define kWidth       [[UIScreen mainScreen] bounds].size.width

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)

// View 坐标(x,y)和宽高(width,height)
#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height

// 系统控件默认高度
#define kStatusBarHeight        (20.f)

#define kTopBarHeight           (44.f)
#define kBarHeight              (64.f)
#define kBottomBarHeight        (49.f)

#define kCellDefaultHeight      (44.f)

#define kEnglishKeyboardHeight  (216.f)
#define kChineseKeyboardHeight  (252.f)
#define KFaceViewHeight         (216.f) //表情键盘高度

// 颜色(RGB)
#define RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#endif /* APPHeader_h */
