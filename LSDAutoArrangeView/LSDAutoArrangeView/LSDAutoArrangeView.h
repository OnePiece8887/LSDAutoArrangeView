//
//  LSDAutoArrangeView.h
//  LSDAutoArrangeView
//
//  Created by ls on 16/4/21.
//  Copyright © 2016年 lcy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSDAutoArrangeViewDelegate <NSObject>
///点击添加标签按钮的回调
-(void)AutoArrangeViewMarkBtnClick:(UIButton *)markBtn;
///点击标签按钮后的回调
-(void)AutoArrangeViewAddBtnClick:(UIButton *)addBtn;

@end

@interface LSDAutoArrangeView : UIView
/**
 title: 标签分类
 titleArray:具体标签数组
 isAddOption:是否要显示添加标签按钮
 delegate:代理对象
 **/
-(instancetype)initWithMainTitle:(NSString *)title andOptionTitleArray:(NSArray<NSString *> *)titleArray  andLastAddOption:(BOOL)isAddOption delegate:(id<LSDAutoArrangeViewDelegate>)delegate;

///代理属性
@property(weak,nonatomic)id<LSDAutoArrangeViewDelegate> delegate;

@end
