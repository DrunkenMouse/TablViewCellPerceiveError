//
//  ADPerceiveErrorCell.h
//  TablViewCell视觉错误动画
//
//  Created by 王奥东 on 16/7/30.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADPerceiveErrorCell : UITableViewCell

/**
 *  背景图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
/**
 *  Xib创建Cell
 */
+(instancetype)perceicedErrorCellFromXib:(UITableView *)tableView;

/**
 *  背景图片y值设置
 */

-(void)cellOnTableView:(UITableView *)tableView didScrollView:(UIView *)view;

@end
