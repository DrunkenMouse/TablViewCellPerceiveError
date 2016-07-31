//
//  ADPerceiveErrorCell.m
//  TablViewCell视觉错误动画
//
//  Created by 王奥东 on 16/7/30.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ADPerceiveErrorCell.h"

static NSString * const PerceivedErrorID = @"cell";
@implementation ADPerceiveErrorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //cell超出部分不显示
    self.clipsToBounds = YES;
    
}

+(instancetype)perceicedErrorCellFromXib:(UITableView *)tableView{
    
    ADPerceiveErrorCell *cell = [tableView dequeueReusableCellWithIdentifier:PerceivedErrorID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
    }
    return cell;
    
}

/**
 *  背景图片y值设置
 */
-(void)cellOnTableView:(UITableView *)tableView didScrollView:(UIView *)view{
    //tableView上cell自身与目标view重叠的范围
    CGRect rect = [tableView convertRect:self.frame toView:view];
    
    //以屏幕中心点为0点，获取能看到的每个cell离中心点得值是多少
    float distanceCenter = CGRectGetHeight(view.frame)/2 - CGRectGetMinY(rect);
    
    //图片高度-cell的高度(获取图片超出cell高度部分)图片肯定要比cell大，否则不会有视觉差效果
    float difference = CGRectGetHeight(self.backgroundImage.frame) - CGRectGetHeight(self.frame);
    //应该移动的距离
    
    float imageMove = (distanceCenter / CGRectGetHeight(view.frame)) * difference;
    
    //旧的图片frame
    CGRect imageRect = self.backgroundImage.frame;
    //移动
    imageRect.origin.y = imageMove - (difference / 2);
    //新的图片frame
    self.backgroundImage.frame = imageRect;
  
    
    
}





@end
