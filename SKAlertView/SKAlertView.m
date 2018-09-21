//
//  SKAlertView.m
//  AIProject
//
//  Created by 阿汤哥 on 2018/9/21.
//  Copyright © 2018年 徐泽. All rights reserved.
//

#import "SKAlertView.h"

#define ZL_screenWidth [UIScreen mainScreen].bounds.size.width
#define ZL_screenHeight [UIScreen mainScreen].bounds.size.height
#define ZL_alertView_width 280
#define ZL_margin_X (ZL_screenWidth - ZL_alertView_width) * 0.5
#define ZL_lineColor UIColorFromRGB(0xDDDDDD)

@interface SKAlertView()

/** 遮盖 */
@property (nonatomic, strong) UIButton *coverView;
/** 背景View */
@property (nonatomic, strong) UIView *bg_view;
/** 标题提示文字 */
@property (nonatomic, copy) NSString *messageTitle;
/** 内容提示文字 */
@property (nonatomic, copy) NSString *contentTitle;

/** SGAlertViewBottomViewTypeOne */
@property (nonatomic, strong) UIView *bottomViewOne;
/** SGAlertViewBottomViewTypeTwo */
@property (nonatomic, strong) UIView *bottomViewTwo;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIButton *right_button;
@property (nonatomic, strong) UIButton *left_button;

@end

@implementation SKAlertView

/** 动画时间 */
static CGFloat const SG_animateWithDuration = 0.2;
/** 距离X轴的间距 */
static CGFloat const margin_X = 20;
/** 距离Y轴的间距 */
static CGFloat const margin_Y = 20;
/** 标题字体大小 */
static CGFloat const message_text_fond = 17;
/** 内容字体大小 */
static CGFloat const content_text_fond = 14;

- (instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelString sureButtonTitles:(nullable NSString *)sureString sureButtonClick:(sureButtonClick)sure cancelButtonClick:(cancelButtonClick)cancel{
    if (self = [super init]) {
        [self setUIWithTitle:title message:message cancelButtonTitle:cancelString sureButtonTitles:sureString];
        
        self.cancelClick = ^{
            cancel();
        };
        
        self.shureClick = ^{
            sure();
        };
    }
    return self;
}

- (void)setUIWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelString sureButtonTitles:(nullable NSString *)sureString{
    self.frame = [UIScreen mainScreen].bounds;
    
    // 背景视图
    self.coverView = [[UIButton alloc] init];
    self.coverView.frame = self.bounds;
    self.coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    [self addSubview:self.coverView];
    
    // 提示标题
    UILabel *message_label = [[UILabel alloc] init];
    message_label.textAlignment = NSTextAlignmentCenter;
    message_label.numberOfLines = 0;
    message_label.text = title;
    message_label.font = kPfMidFont(17);
    message_label.textColor = UIColorFromRGB(0x444444);
    CGSize message_labelSize = [self sizeWithText:message_label.text font:kPfMidFont(17) maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    // 设置Message的frame
    CGFloat message_label_X = margin_X;
    CGFloat message_label_Y;
    if (message_label.text == nil) {
        message_label_Y = 5;
    } else {
        message_label_Y = margin_Y;
    }
    CGFloat message_label_W = ZL_alertView_width - 2 * message_label_X;
    CGFloat message_label_H = message_labelSize.height;
    message_label.frame = CGRectMake(message_label_X, message_label_Y, message_label_W, message_label_H);
    
    // 提示内容
    UILabel *content_label = [[UILabel alloc] init];
    content_label.textAlignment = NSTextAlignmentCenter;
    content_label.numberOfLines = 0;
    content_label.text = message;
    content_label.font = kPfFont(content_text_fond);
    content_label.textColor = UIColorFromRGB(0x333333);
    CGSize content_labelSize = [self sizeWithText:content_label.text font:kPfFont(content_text_fond) maxSize:CGSizeMake(ZL_alertView_width - 2 * margin_X, MAXFLOAT)];
    // 设置内容的frame
    CGFloat content_label_X = margin_X;
    CGFloat content_label_Y = CGRectGetMaxY(message_label.frame) + margin_Y * 0.8;
    CGFloat content_label_W = ZL_alertView_width - 2 * content_label_X;
    CGFloat content_label_H = content_labelSize.height;
    content_label.frame = CGRectMake(content_label_X, content_label_Y, content_label_W, content_label_H);
    
    // 顶部View
    UIView *topView = [[UIView alloc] init];
    // 设置顶部View的frame
    CGFloat topView_X = 0;
    CGFloat topView_Y = 0;
    CGFloat topView_W = ZL_alertView_width;
    CGFloat topView_H;
    
    if (content_label.text == nil) {
        topView_H = CGRectGetMaxY(message_label.frame) + 25;
    } else {
        topView_H = CGRectGetMaxY(content_label.frame) + 25;
    }
    topView.frame = CGRectMake(topView_X, topView_Y, topView_W, topView_H);
    
    [topView addSubview:message_label];
    [topView addSubview:content_label];
    
    if (!cancelString) {
        // 创建底部View
        self.bottomViewOne = [[UIView alloc] init];
        CGFloat bottomView_X = 0;
        CGFloat bottomView_Y = CGRectGetMaxY(topView.frame);
        CGFloat bottomView_W = ZL_alertView_width;
        CGFloat bottomView_H = 45;
        _bottomViewOne.frame = CGRectMake(bottomView_X, bottomView_Y, bottomView_W, bottomView_H);
        _bottomViewOne.backgroundColor = ZL_lineColor;
        
        // 给 bottomViewOne 添加子视图
        self.button = [[UIButton alloc] init];
        CGFloat button_X = 0;
        CGFloat button_Y = 1;
        CGFloat button_W = bottomView_W;
        CGFloat button_H = bottomView_H - button_Y;
        _button.frame = CGRectMake(button_X, button_Y, button_W, button_H);
        _button.backgroundColor = [UIColor whiteColor];
        [_button setTitle:sureString forState:(UIControlStateNormal)];
        [_button setTitleColor:kMainColor forState:(UIControlStateNormal)];
        _button.titleLabel.font = kPfFont(16);
        [_button addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self.bottomViewOne addSubview:_button];
        
        // 背景View
        self.bg_view = [[UIView alloc] init];
        CGFloat bg_viewW = ZL_alertView_width;
        CGFloat bg_viewH = topView.frame.size.height + 45;
        CGFloat bg_viewX = ZL_margin_X;
        CGFloat bg_viewY = (ZL_screenHeight - bg_viewH-20) * 0.5;
        _bg_view.frame = CGRectMake(bg_viewX, bg_viewY, bg_viewW, bg_viewH);
        _bg_view.layer.cornerRadius = 7;
        _bg_view.layer.masksToBounds = YES;
        _bg_view.backgroundColor = [UIColor whiteColor];
        
        [_bg_view addSubview:topView];
        [_bg_view addSubview:_bottomViewOne];
        [self.coverView addSubview:_bg_view];
        
    } else {
        
        // 创建底部View
        self.bottomViewTwo = [[UIView alloc] init];
        CGFloat bottomView_X = 0;
        CGFloat bottomView_Y = CGRectGetMaxY(topView.frame);
        CGFloat bottomView_W = ZL_alertView_width;
        CGFloat bottomView_H = 45;
        _bottomViewTwo.frame = CGRectMake(bottomView_X, bottomView_Y, bottomView_W, bottomView_H);
        _bottomViewTwo.backgroundColor = ZL_lineColor;
        
        // 给 bottomViewOne 添加子视图
        self.left_button = [[UIButton alloc] init];
        CGFloat left_button_X = 0;
        CGFloat left_button_Y = 1;
        CGFloat left_button_W = bottomView_W * 0.5;
        CGFloat left_button_H = bottomView_H - left_button_Y;
        _left_button.frame = CGRectMake(left_button_X, left_button_Y, left_button_W, left_button_H);
        _left_button.backgroundColor = [UIColor whiteColor];
        [_left_button setTitle:cancelString forState:(UIControlStateNormal)];
        [_left_button setTitleColor:UIColorFromRGB(0x333333) forState:(UIControlStateNormal)];
        _left_button.titleLabel.font = kPfFont(16);
        [_left_button addTarget:self action:@selector(leftButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self.bottomViewTwo addSubview:_left_button];
        
        self.right_button = [[UIButton alloc] init];
        CGFloat right_button_X = CGRectGetMaxX(_left_button.frame) + 1;
        CGFloat right_button_Y = 1;
        CGFloat right_button_W = bottomView_W - right_button_X;
        CGFloat right_button_H = bottomView_H - left_button_Y;
        _right_button.frame = CGRectMake(right_button_X, right_button_Y, right_button_W, right_button_H);
        _right_button.backgroundColor = [UIColor whiteColor];
        [_right_button setTitle:sureString forState:(UIControlStateNormal)];
        [_right_button setTitleColor:kMainColor forState:(UIControlStateNormal)];
        _right_button.titleLabel.font = kPfFont(16);
        [_right_button addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self.bottomViewTwo addSubview:_right_button];
        
        // 背景View
        self.bg_view = [[UIView alloc] init];
        CGFloat bg_viewW = ZL_alertView_width;
        CGFloat bg_viewH = topView.frame.size.height + 45;
        CGFloat bg_viewX = ZL_margin_X;
        CGFloat bg_viewY = (ZL_screenHeight - bg_viewH-20) * 0.5;
        _bg_view.frame = CGRectMake(bg_viewX, bg_viewY, bg_viewW, bg_viewH);
        _bg_view.layer.cornerRadius = 7;
        _bg_view.layer.masksToBounds = YES;
        _bg_view.backgroundColor = [UIColor whiteColor];
        
        [_bg_view addSubview:topView];
        [_bg_view addSubview:_bottomViewTwo];
        [self.coverView addSubview:_bg_view];
    }
}

/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (void)show {
    
    if (self.superview != nil) return;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    [UIView animateWithDuration:SG_animateWithDuration animations:^{
        [self animationWithAlertView];
    }];
}

- (void)rightButtonClick {
    [UIView animateWithDuration:SG_animateWithDuration animations:^{
        [self dismiss];
    } completion:^(BOOL finished) {
        if(self.shureClick){
            self.shureClick();
        }
    }];
}

- (void)leftButtonClick {
    [UIView animateWithDuration:SG_animateWithDuration animations:^{
        [self dismiss];
    } completion:^(BOOL finished) {
        if(self.cancelClick){
            self.cancelClick();
        }
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:SG_animateWithDuration animations:^{
        
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

-(void)animationWithAlertView {
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.15;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.bg_view.layer addAnimation:animation forKey:nil];
}

@end
