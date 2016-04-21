//
//  LSDAutoArrangeView.m
//  LSDAutoArrangeView
//
//  Created by ls on 16/4/21.
//  Copyright © 2016年 lcy. All rights reserved.
//

#import "LSDAutoArrangeView.h"
#import "Masonry.h"

static const NSInteger KLSDAutoArrangeViewMargin = 20;
#define KYScreenWidth   [UIScreen mainScreen].bounds.size.width

@interface LSDAutoArrangeView ()

///标签分类
@property(copy,nonatomic)NSString *title;

///存放标签的数组
@property(strong,nonatomic)NSArray *titleArray;

///是否有添加标签选项
@property(assign,nonatomic)BOOL isAddOption;

@end

@implementation LSDAutoArrangeView
#pragma mark -- 构造方法
-(instancetype)initWithMainTitle:(NSString *)title andOptionTitleArray:(NSArray<NSString *> *)titleArray andLastAddOption:(BOOL)isAddOption delegate:(id<LSDAutoArrangeViewDelegate>)delegate{

    LSDAutoArrangeView *autoView = [[LSDAutoArrangeView alloc]init];
    
    autoView.title = title;
    autoView.titleArray = titleArray;
    autoView.isAddOption = isAddOption;
    autoView.delegate = delegate;
    
    return autoView;

}



-(instancetype)initWithFrame:(CGRect)frame{
    
    
    if (self = [super initWithFrame:frame]) {
        
#pragma mark -- 注意这里使用异步可以让子控件的数据显示
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setupUI];
            
        });
        
    }
    return self;
    
}

#pragma mark -- 设置子控件
-(void)setupUI{
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = self.title;
    titleLabel.textColor = [UIColor redColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.contentMode = UIViewContentModeScaleAspectFit;
    [titleLabel sizeToFit];
    [self addSubview:titleLabel];
    
    for (int i = 0; i < _titleArray.count; i ++) {
        
        UIButton *btn = [[UIButton alloc]init];
 
        [btn setTitle:_titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"link_button_02"] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:@"more_selected"] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"link_button_02"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn sizeToFit];
        
        [self addSubview:btn];
    }
    
    if (_isAddOption) {
        UIButton *addBtn = [[UIButton alloc]init];
        
        [addBtn setTitle:@"添加其他标签" forState:UIControlStateNormal];
        
        [addBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [addBtn setImage:[UIImage imageNamed:@"addbtn"] forState:UIControlStateNormal];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"link_button_02"] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        addBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [addBtn sizeToFit];
       
        [self addSubview:addBtn];
    }
    
    
    
}

#pragma mark -- 在这个方法里设置子控件的frame
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat subX = 0;
    CGFloat subY = 0;
    
    CGFloat sum = 0;
    NSInteger lineCount = 0;
#pragma mark -- 在这里可以监听到子控件的frame
    
    for (int i = 0; i < self.subviews.count; i ++) {
        
        UIView *sub = self.subviews[i];
        
        NSString *str = NSStringFromCGRect(sub.frame);
        
        CGRect rect =  CGRectFromString(str);
        
        ///设置子控件的x坐标
        subX =  sum  + KLSDAutoArrangeViewMargin;
        ///记录每行的最后一个子控件的位置
        sum = subX + rect.size.width;
        
        if (sum > KYScreenWidth ) {
            ///当超出屏幕宽度时 让控件换行 并重新设置x坐标 sum归零
            lineCount ++;
            sum = 0;
            
#warning 对子控件的x重新设置
            subX =  sum  + KLSDAutoArrangeViewMargin;
            sum = subX + rect.size.width;
        }
        
        subY = lineCount * rect.size.height;
        
#warning 这里使用的宽和高 必须使用subview.frame.size.width
        sub.frame = CGRectMake(subX, subY, rect.size.width, rect.size.height);
        
        if (i == self.subviews.count - 1) {
            NSLog(@"%@",NSStringFromCGRect(sub.frame));
#warning 当是最后一个子控件时 设置自定义View的高度约束
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(CGRectGetMaxY(sub.frame));
            }];
        }
    }
    
    
}
#pragma mark -- 标签按钮的点击事件
-(void)btnClick:(UIButton *)sender{
    
    NSLog(@"标签按钮被点击了");
    
    sender.selected = !sender.selected;
    
    if ([self.delegate respondsToSelector:@selector(AutoArrangeViewMarkBtnClick:)]) {
        [self.delegate AutoArrangeViewMarkBtnClick:sender];
    }
    
}
#pragma mark -- 添加按钮的点击事件
-(void)addBtnClick:(UIButton *)sender{
    
    NSLog(@"点击添加按钮");
    
    if ([self.delegate respondsToSelector:@selector(AutoArrangeViewAddBtnClick:)]) {
        [self.delegate AutoArrangeViewAddBtnClick:sender];
    }
    
}


@end
