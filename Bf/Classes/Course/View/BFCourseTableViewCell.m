//
//  BFCourseTableViewCell.m
//  Bf
//
//  Created by 春晓 on 2018/4/17.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFCourseTableViewCell.h"

#import "BFCourseCollectionViewCell.h"


@interface BFCourseTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
// collection
@property (nonatomic , strong) UICollectionView *collectionView;
@end

static NSString *collectionCell = @"collectionCell";

@implementation BFCourseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, CollectionRowMargin, 0, CollectionRowMargin);
        layout.itemSize = CGSizeMake(CollectionCellWidth, 160);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 170 * 3) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[BFCourseCollectionViewCell class] forCellWithReuseIdentifier:collectionCell];
        [self.contentView addSubview:_collectionView];
    }
    return self;
}

#pragma mark -collectionView-
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _courseArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BFCourseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    cell.courseDict = _courseArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(courseClickActionWithItem:withCell:)]) {
        [_delegate courseClickActionWithItem:indexPath.item withCell:self];
    }
}

#pragma mark -setter-
- (void)setCourseArray:(NSArray *)courseArray{
    _courseArray = courseArray;
    if (_courseArray.count % 2 == 0) {
        _collectionView.frame = CGRectMake(0, 0, KScreenW, 170 * _courseArray.count / 2);
    }else{
        _collectionView.frame = CGRectMake(0, 0, KScreenW, 170 * (_courseArray.count / 2 + 1));
    }
    [_collectionView reloadData];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
