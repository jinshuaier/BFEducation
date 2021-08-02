//
//  ItemCollectionViewCell.h
//  ScrollviewDemo
//
//  Created by zzq on 2018/2/8.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCollectionViewCell : UICollectionViewCell
/**<#添加注释#>**/
@property (weak, nonatomic) IBOutlet UILabel *mainLB;
/**<#添加注释#>**/
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@end
