//
//  SystemDefine.h
//  AIProject
//
//  Created by 阿汤哥 on 2018/9/10.
//  Copyright © 2018年 徐泽. All rights reserved.
//

#ifndef SystemDefine_h
#define SystemDefine_h

/*----------字体专区----------*/

/**
 平方常体
 */
#define kPfFont(a)          [UIFont fontWithName:@"PingFangSC-Regular" size:kAuto(a)]
#define kFont(a)          [UIFont fontWithName:@"PingFangSC-Regular" size:a]

/**
 平方中黑体
 */
#define kPfMidFont(a)          [UIFont fontWithName:@"PingFangSC-Medium" size:kAuto(a)]
#define kMidFont(a)          [UIFont fontWithName:@"PingFangSC-Medium" size:a]

/**
 平方粗体
 */
#define kPfBoldFont(a)          [UIFont fontWithName:@"PingFangSC-Bold" size:kAuto(a)]
#define kBoldFont(a)          [UIFont fontWithName:@"PingFangSC-Bold" size:a]


/*----------颜色专区----------*/

/**
 RGB
 */
#define UIColorFromRGB(rgbValue)          [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kColorRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define kColorRGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]

/**
 主题色
 */
#define kMainColor          UIColorFromRGB(0xFC6B61)

/**
 背景色
 */
#define kBackgroundColor    UIColorFromRGB(0xf4f4f4)



/*----------尺寸专区----------*/

/**
 屏幕宽
 */
#define KSCREENWIDTH          [UIScreen mainScreen].bounds.size.width

/**
 屏幕高
 */
#define KSCREENHEIGHT          [UIScreen mainScreen].bounds.size.height

/**
 iphoneX适配
 */
#define kState_Height (IS_IPHONE_X ? 44.f : 20.f)
#define kBottom_Height (IS_IPHONE_X ? 34.f : 0.f)
#define kNavationBarHeight          44
#define kNavationBarAndStateHeight          kState_Height+kNavationBarHeight

/**
 适配尺寸
 */
#define kAuto(a) (a)*KSCREENWIDTH/375


/*----------快捷专区----------*/

/**
 图片
 */
#define kimage(name)          [UIImage imageNamed:name]



/*----------系统专区----------*/

//iOS11以上
#define IS_SYSTEM_IOS11_UP [[[UIDevice currentDevice] systemVersion] floatValue]>=11.0

//iOS11以下
#define IS_SYSTEM_IOS11_DOWN [[[UIDevice currentDevice] systemVersion] floatValue]<11.0

//iOS10以下
#define IS_SYSTEM_IOS10_DOWN [[[UIDevice currentDevice] systemVersion] floatValue]<10.0

/**
 手机型号
 */
#define IS_IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_6 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.width - ( double )375 ) < DBL_EPSILON )
#define IS_IPHONE_6P ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#endif /* SystemDefine_h */
