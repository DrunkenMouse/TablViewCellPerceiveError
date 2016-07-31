//
//  ViewController.m
//  TablViewCell视觉错误动画
//
//  Created by 王奥东 on 16/7/30.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ViewController.h"
#import "ADPerceiveErrorCell.h"

/**
 
     每行cell上backImage高度都超过cell的高度
     只是awakeFromNib时通过cell.clipsToBounds将超出的部位减去不显示
     滚动结束时先获取自身tableView可视视图的所有cell
     而后通过自定义cell对象方法修改Cell的backImage.frame
     让其产生滚动显示效果
     图片加载完毕后也要调用一次滚动结束后的方法
     让cell的backImage.frame显示上半部分滚
 
     自定义方法设置：
     先获取tableView上cell自身与目标view重叠的范围
     以屏幕中心点为0点，获取能看到的每个cell离中心点得值是多少(distanceCenter)
     若cell分布在中心点(屏幕高度一半)上下则值为正负，所以每个cell的滚动效果可能不一样
     获取图片高度-cell的高度值(difference)而后计算出应该移动的距离
     (distanceCenter / CGRectGetHeight(view.frame))* difference;
     所以越距离屏幕中心点的移动距离越小，且屏幕中心点上方时移动正值，下方负值
     而后修改旧backgroundImage.frame让其产生滚动显示效果
 
 */

#define ADCount 10


#define ADGetImage(row) [UIImage imageNamed:[NSString stringWithFormat:@"%zd",row]]

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(nonatomic,strong)UITableView *perceivedErrorTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

-(void)setup{

    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.rowHeight = 200;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor blackColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.perceivedErrorTableView = tableView;
    [self.view addSubview:tableView];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ADCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ADPerceiveErrorCell *cell = [ADPerceiveErrorCell perceicedErrorCellFromXib:tableView];
    
    cell.backgroundImage.image = ADGetImage(indexPath.row + 1);
    
    return cell;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    
    //获取可视视图的所有cell
    NSArray *visibleCells = [self.perceivedErrorTableView visibleCells];

    for (ADPerceiveErrorCell *cell in visibleCells) {
        //可见视图设置背景图片Y值
        [cell cellOnTableView:self.perceivedErrorTableView didScrollView:self.view];
    }
  
}

//视图加载完在调用scrollViewDidScroll方法
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self scrollViewDidScroll:[[UIScrollView alloc]init]];
    
}








@end
