//
//  BFScrollViewCell.m
//  Bf
//
//  Created by 春晓 on 2017/11/27.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFScrollViewCell.h"
#import "BFScrollCell.h"
@interface BFScrollViewCell ()

@end
@implementation BFScrollViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setScrollArray:(NSMutableArray *)scrollArray{
    if (_scrollArray) {
        [_scrollArray removeAllObjects];
        _scrollArray = nil;
    }
    _scrollArray = scrollArray;
    if (!_topScrollView) {
        [self setupUI];
    }
    
}

- (WLScrollView *)topScrollView{
    if (!_topScrollView) {
        [self setupUI];
    }
    return _topScrollView;
}

- (void)setupUI{
    _topScrollView = [[WLScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 130)];
    _topScrollView.isAnimation = NO;
    _topScrollView.scale = 0.8;
    _topScrollView.delegate = self;
    _topScrollView.marginX = 5;
    [_topScrollView starRender];
    _topScrollView.backgroundColor = [UIColor whiteColor];
    _topScrollView.clipsToBounds = NO;
    _topScrollView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _topScrollView.layer.shadowOpacity = 0.5f;
    _topScrollView.layer.shadowRadius = 1.0f;
    _topScrollView.layer.shadowOffset = CGSizeMake(0, 3);
    [self.contentView addSubview:_topScrollView];
}

#pragma mark - WLScrollViewDelegate
- (NSInteger)numOfContentViewScrollView:(WLScrollView *)scrollView{
    return _scrollArray.count;
}

- (WLSubView *)scrollView:(WLScrollView *)scrollView subViewFrame:(CGRect)frame cellAtIndex:(NSInteger)index{
    
    static NSString *cellID = @"123";
    
    BFScrollCell *sub = (BFScrollCell *)[scrollView dequeueReuseCellWithIdentifier:cellID];
    if (!sub) {
        sub = [[BFScrollCell alloc] initWithFrame:frame Identifier:cellID];
    }
    sub.im.image = _scrollArray[index];
    return sub;
}

- (void)scrollView:(WLScrollView *)scrollView didSelectedAtIndex:(NSInteger)index{
    NSLog(@"点击 index %zd",index);
}

- (void)scrollView:(WLScrollView *)scrollView didCurrentCellAtIndex:(NSInteger)index{
    NSLog(@"现在显示的 index %zd",index);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
