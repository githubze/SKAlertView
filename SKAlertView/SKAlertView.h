//
//  SKAlertView.h
//  AIProject
//
//  Created by 阿汤哥 on 2018/9/21.
//  Copyright © 2018年 徐泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemDefine.h"

typedef void(^sureButtonClick)(void);
typedef void(^cancelButtonClick)(void);

@interface SKAlertView : UIView

/**
 确定
 */
@property (nonatomic, copy) sureButtonClick shureClick;

/**
 取消
 */
@property (nonatomic, copy) cancelButtonClick cancelClick;

- (instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelString sureButtonTitles:(nullable NSString *)sureString sureButtonClick:(sureButtonClick)sure cancelButtonClick:(cancelButtonClick)cancel;

- (void)show;

@end
