//
//  ChapterTableViewCell.m
//  WLN_Tianxing
//
//  Created by wln100-IOS1 on 15/12/23.
//  Copyright © 2015年 TianXing. All rights reserved.
//

#import "ChapterTableViewCell.h"
#import "CLLThreeTreeModel.h"
#import "CLLThreeTreeTableViewCell.h"
#import "BFCourseModel.h"
#import "BFTimeTransition.h"

#import "BFLittleChapterModel.h"
#import "BFCourseModel.h"

@implementation ChapterTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.dataArray = [NSMutableArray array];
        self.chapterIdArray = [NSMutableArray array];
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews
{
    self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenW - PXTOPT(30) - 19, -4, 19, 64)];
    [self.contentView addSubview:self.imageView2];
    self.chapterName2 = [[UILabel alloc] initWithFrame:CGRectMake(PXTOPT(30), 8, 183, 21)];
    self.chapterName2.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.chapterName2];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 59, [UIScreen mainScreen].bounds.size.width, 1) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CLLThreeTreeTableViewCell class] forCellReuseIdentifier:@"testCell"];
}

- (void)showTableView {
    [self.contentView addSubview:self.tableView];
}

- (void)hiddenTableView {
    [self.tableView removeFromSuperview];
}


- (void)configureCellWithModel:(BFLittleChapterModel *)model {
//    [self.dataArray removeAllObjects];
    self.dataArray = model.child.mutableCopy;
//    for (NSDictionary *dict in array) {
////        NSString *str = dict[@"chapterName"];
////        [self.dataArray addObject:str];
////
////        NSString *chapterId = dict[@"cid"];
////        [self.chapterIdArray addObject:chapterId];
//
//        BFCourseModel *model = [BFCourseModel mj_objectWithKeyValues:dict];
//        [self.dataArray addObject:model];
//    }
    
    CGRect frame = self.tableView.frame;
    frame.size.height = 60 * self.dataArray.count;
    self.tableView.frame = frame;
    [self.tableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLLThreeTreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"testCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[CLLThreeTreeTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"testCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BFCourseModel *model = self.dataArray[indexPath.row];
    cell.littleTitleLabel.text = model.ctitle;
    cell.titleImgView.image = [UIImage imageNamed:@"直播"];
    cell.timeLabel.text = [NSString stringWithFormat:@"%@-%@",[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",model.cstarttime] dateFormat:@"MM月dd号 hh:mm"],[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",model.cendtime] dateFormat:@"hh:mm"]];
//    //判断cell的位置选择折叠图片
//    if (indexPath.row == self.dataArray.count - 1) {
//        cell.image.image = [UIImage imageNamed:@"三级圆环"];
//        [cell.image setContentMode:UIViewContentModeScaleAspectFit];
//    }else{
//        cell.image.image = [UIImage imageNamed:@"三级圆环"];
//        [cell.image setContentMode:UIViewContentModeScaleAspectFit];
//    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}




@end
