//
//  ViewController.m
//  LSDAutoArrangeView
//
//  Created by ls on 16/4/21.
//  Copyright © 2016年 lcy. All rights reserved.
//

#import "ViewController.h"
#import "LSDAutoArrangeView.h"
#import "Masonry.h"
@interface ViewController ()<LSDAutoArrangeViewDelegate>

///上方视图
@property(strong,nonatomic)UIView *topView;

///中间视图
@property(strong,nonatomic)LSDAutoArrangeView *centerView;

///下方视图
@property(strong,nonatomic)UIView *bottomView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor greenColor];
    
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor yellowColor];
    self.topView = topView;
    [self.view addSubview:topView];
    
    
    NSMutableArray *muArray = [NSMutableArray array];
    ///测试数据
    for (int i = 0; i < 20 ; i ++) {
        NSString *str = [NSString stringWithFormat:@"测试标签%d仅供测试",i];
        [muArray addObject:str];
    }
    #warning  使用构造方法创建对象
    LSDAutoArrangeView *centerView = [[LSDAutoArrangeView alloc]initWithMainTitle:@"标签分类名" andOptionTitleArray:muArray.copy andLastAddOption:YES delegate:self];;
    
    centerView.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:centerView];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor redColor];
    self.bottomView = bottomView;
    
    [self.view addSubview:bottomView];
    
    ///设置子控件的约束
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
    ///设置约束 注意这里不需要设置高度
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(topView.mas_bottom).offset(30);
        make.left.right.equalTo(self.view);
        
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(centerView.mas_bottom).offset(50);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];

    
}


#pragma mark -- 代理方法
-(void)AutoArrangeViewMarkBtnClick:(UIButton *)markBtn{
    
    NSLog(@"%@",markBtn.currentTitle);
    
}

-(void)AutoArrangeViewAddBtnClick:(UIButton *)addBtn{
    
    NSLog(@"%@",addBtn.currentTitle);
}


@end
