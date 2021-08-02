//
//  BFCourseDetailsTeacherCell.m
//  NewTest
//
//  Created by 春晓 on 2017/11/30.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFCourseDetailsTeacherCell.h"
#import <SDAutoLayout.h>

@interface BFCourseDetailsTeacherCell ()
// 头像
@property (nonatomic , strong) UIImageView *headerImageView;
// 老师名字
@property (nonatomic , strong) UILabel *teacherNameLabel;
// 老师简介
@property (nonatomic , strong) UILabel *teacherIntroduceLabel;

@end

@implementation BFCourseDetailsTeacherCell{
    UIView *lineView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setupUI];
        [self layout];
    }
    return self;
}

- (void)setupUI{
    _teacherNameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_teacherNameLabel];
    _teacherNameLabel.textColor = RGBColor(51, 51, 51);
    _teacherNameLabel.font = [UIFont systemFontOfSize:PXTOPT(28)];
    _teacherIntroduceLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_teacherIntroduceLabel];
    _teacherIntroduceLabel.textColor = RGBColor(153, 153, 153);
    _teacherIntroduceLabel.font = [UIFont systemFontOfSize:PXTOPT(24)];
    _headerImageView = [[UIImageView alloc] init];
    _headerImageView.layer.masksToBounds = YES;
    _headerImageView.layer.cornerRadius = PXTOPT(100) / 2;
    [self.contentView addSubview:_headerImageView];
    
//    lineView = [[UIView alloc] init];
//    lineView.backgroundColor = [UIColor lightGrayColor];
//    [self.contentView addSubview:lineView];
}

- (void)layout{
    _headerImageView.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(30))
    .centerYIs(TeacherCellHeight / 2)
    .widthIs(PXTOPT(100))
    .heightIs(PXTOPT(100));
    
    _teacherNameLabel.sd_layout
    .leftSpaceToView(_headerImageView, 10)
    .topEqualToView(_headerImageView)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(20);
    
    _teacherIntroduceLabel.sd_layout
    .leftSpaceToView(_headerImageView, 10)
    .topSpaceToView(_teacherNameLabel, 5)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(20);
}

- (void)setTeacher:(BFCourseDetailsTeachers *)teacher{
//    if (_teacher){
//        _teacher = nil;
//    }
    _teacher = teacher;
    
    _teacherNameLabel.text = _teacher.inickname;
    _teacherIntroduceLabel.text = _teacher.iintr;
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:_teacher.iphoto] placeholderImage:[UIImage imageNamed:@"123"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
