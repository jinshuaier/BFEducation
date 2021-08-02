//
//  BFCDTeacherRoleCell.m
//  NewTest
//
//  Created by 春晓 on 2017/11/30.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFCDTeacherRoleCell.h"
#import <SDAutoLayout.h>

@interface BFCDTeacherRoleCell ()
// 老师角色
@property (nonatomic , strong) UILabel *teacherRoleLabel;
// 老师简介
@property (nonatomic , strong) UILabel *teacherIntroduceLabel;
// 头像
@property (nonatomic , strong) UIImageView *headerImageView;
// 老师名字
@property (nonatomic , strong) UILabel *teacherNameLabel;
// 展开关闭按钮
@property (nonatomic , strong) UIImageView *expansionImageView;


// 头像1
@property (nonatomic , strong) UIImageView *headerImageView1;
// 老师名字1
@property (nonatomic , strong) UILabel *teacherNameLabel1;
// 头像2
@property (nonatomic , strong) UIImageView *headerImageView2;
// 老师名字2
@property (nonatomic , strong) UILabel *teacherNameLabel2;
// 头像3
@property (nonatomic , strong) UIImageView *headerImageView3;
// 老师名字3
@property (nonatomic , strong) UILabel *teacherNameLabel3;
// 头像4
@property (nonatomic , strong) UIImageView *headerImageView4;
// 老师名字4
@property (nonatomic , strong) UILabel *teacherNameLabel4;

@end
#define HeaderImageViewWH PXTOPT(100)

@implementation BFCDTeacherRoleCell{
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
    
    [self.contentView addSubview:self.teacherRoleLabel];
    [self.contentView addSubview:self.teacherNameLabel];
    [self.contentView addSubview:self.headerImageView];
    [self.contentView addSubview:self.teacherIntroduceLabel];
    [self.contentView addSubview:self.expansionImageView];
    
    [self.contentView addSubview:self.teacherNameLabel1];
    [self.contentView addSubview:self.headerImageView1];
    [self.contentView addSubview:self.teacherNameLabel2];
    [self.contentView addSubview:self.headerImageView2];
    [self.contentView addSubview:self.teacherNameLabel3];
    [self.contentView addSubview:self.headerImageView3];
    [self.contentView addSubview:self.teacherNameLabel4];
    [self.contentView addSubview:self.headerImageView4];
    
    self.teacherNameLabel1.tag = 10001;
    self.teacherNameLabel2.tag = 10002;
    self.teacherNameLabel3.tag = 10003;
    self.teacherNameLabel4.tag = 10004;
    
    self.headerImageView1.tag  = 20001;
    self.headerImageView2.tag  = 20002;
    self.headerImageView3.tag  = 20003;
    self.headerImageView4.tag  = 20004;
    
    UIFont *font = [UIFont fontWithName:BFfont size:PXTOPT(28)];
    self.teacherNameLabel.font  = font;
    self.teacherNameLabel1.font = font;
    self.teacherNameLabel2.font = font;
    self.teacherNameLabel3.font = font;
    self.teacherNameLabel4.font = font;
    
    lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGBColor(240, 240, 240);
    [self.contentView addSubview:lineView];
}

- (void)layout{
    _teacherRoleLabel.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(30);
    
    _expansionImageView.sd_layout
    .rightSpaceToView(self.contentView, 15)
    .topEqualToView(_teacherRoleLabel)
    .widthIs(15)
    .heightIs(15);
    
    _headerImageView.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(30))
    .topSpaceToView(_teacherRoleLabel, 10)
    .widthIs(HeaderImageViewWH)
    .heightIs(HeaderImageViewWH);
    
    _teacherNameLabel.sd_layout
    .leftSpaceToView(_headerImageView, 10)
    .topSpaceToView(_teacherRoleLabel, 13)
    .rightEqualToView(_teacherRoleLabel)
    .heightIs(20);
    
    _teacherIntroduceLabel.sd_layout
    .leftSpaceToView(_headerImageView, 10)
    .topSpaceToView(_teacherNameLabel, 5)
    .rightEqualToView(_teacherRoleLabel)
    .heightIs(20);
    
    lineView.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(3);
    
    _headerImageView1.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(30))
    .topSpaceToView(_teacherRoleLabel, 10)
    .widthIs(HeaderImageViewWH)
    .heightIs(HeaderImageViewWH);
    
    _teacherNameLabel1.sd_layout
    .leftEqualToView(_headerImageView1)
    .rightEqualToView(_headerImageView1)
    .topSpaceToView(_headerImageView1, PXTOPT(16))
    .heightIs(PXTOPT(30));
    
    _headerImageView2.sd_layout
    .leftSpaceToView(_headerImageView1, PXTOPT(46))
    .topEqualToView(_headerImageView1)
    .widthIs(HeaderImageViewWH)
    .heightIs(HeaderImageViewWH);
    
    _headerImageView3.sd_layout
    .leftSpaceToView(_headerImageView2, PXTOPT(46))
    .topEqualToView(_headerImageView1)
    .widthIs(HeaderImageViewWH)
    .heightIs(HeaderImageViewWH);
    
    _headerImageView4.sd_layout
    .leftSpaceToView(_headerImageView3, PXTOPT(46))
    .topEqualToView(_headerImageView1)
    .widthIs(HeaderImageViewWH)
    .heightIs(HeaderImageViewWH);
    
    _teacherNameLabel2.sd_layout
    .leftEqualToView(_headerImageView2)
    .rightEqualToView(_headerImageView2)
    .topSpaceToView(_headerImageView2, PXTOPT(16))
    .heightIs(PXTOPT(30));
    
    _teacherNameLabel3.sd_layout
    .leftEqualToView(_headerImageView3)
    .rightEqualToView(_headerImageView3)
    .topSpaceToView(_headerImageView3, PXTOPT(16))
    .heightIs(PXTOPT(30));
    
    _teacherNameLabel4.sd_layout
    .leftEqualToView(_headerImageView4)
    .rightEqualToView(_headerImageView4)
    .topSpaceToView(_headerImageView4 , PXTOPT(16))
    .heightIs(PXTOPT(30));
}

// 展开
- (void)expansionCell{
    self.teacherIntroduceLabel.hidden = NO;
    self.teacherNameLabel.hidden      = NO;
    self.headerImageView.hidden       = NO;
    
    self.teacherNameLabel1.hidden     = YES;
    self.headerImageView1.hidden      = YES;
    self.teacherNameLabel2.hidden     = YES;
    self.headerImageView2.hidden      = YES;
    self.teacherNameLabel3.hidden     = YES;
    self.headerImageView3.hidden      = YES;
    self.teacherNameLabel4.hidden     = YES;
    self.headerImageView4.hidden      = YES;
    
    _expansionImageView.image = [UIImage imageNamed:@"返回拷贝4"];
}

// 合闭
- (void)closeCell{
    [self closeCellWithCount:_teachersArray.count];
    _expansionImageView.image = [UIImage imageNamed:@"返回拷贝5"];
}

// 合闭
- (void)closeCellWithCount:(NSInteger)count{
    self.teacherIntroduceLabel.hidden = YES;
    self.teacherNameLabel.hidden      = YES;
    self.headerImageView.hidden       = YES;
    
    if (count < 4) {
        for (NSInteger i = count; i < 4; i++) {
            UILabel *label = [self.contentView viewWithTag:10001 + i];
            UIImageView *imgView = [self.contentView viewWithTag:20001 + i];
            label.hidden = YES;
            imgView.hidden = YES;
        }
    }
    
    for (int i = 0; i < count; i++) {
        UILabel *label = [self.contentView viewWithTag:10001 + i];
        UIImageView *imgView = [self.contentView viewWithTag:20001 + i];
        label.hidden = NO;
        imgView.hidden = NO;
    }
}

- (void)setTeacher:(BFCourseDetailsTeachers *)teacher{
//    if (_teacher){
//        _teacher = nil;
//    }
    _teacher = teacher;
    
    _teacherNameLabel.text = _teacher.inickname;
    _teacherIntroduceLabel.text = _teacher.iintr;
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:_teacher.iphoto] placeholderImage:[UIImage imageNamed:@"123"]];
    _teacherRoleLabel.text = _teacher.teacherRole == TeacherRole_Give ? @"授课老师" : @"辅导老师";
    
    [self expansionCell];
    _expansionImageView.hidden = _teachersArray.count == 0;
    lineView.hidden = _teacher.teacherRole == TeacherRole_Give ? YES : NO;
}

- (void)setTeachersArray:(NSMutableArray *)teachersArray{
//    if (_teachersArray) {
//        [_teachersArray removeAllObjects];
//        _teachersArray = nil;
//    }
    _teachersArray = teachersArray;
    _teacherRoleLabel.text = @"授课老师";
    NSInteger count = 0;
    
    if (_teachersArray.count > 4) {
        count = 4;
    }else{
        count = _teachersArray.count;
    }
    
    for (int i = 0; i < count; i++) {
        BFCourseDetailsTeachers *teacher = _teachersArray[i];
        UILabel *label = [self.contentView viewWithTag:10001 + i];
        label.text = teacher.inickname;
        label.textColor = RGBColor(51, 51, 51);
        label.font = [UIFont systemFontOfSize:PXTOPT(28)];
        UIImageView *imgView = [self.contentView viewWithTag:20001 + i];
        [imgView sd_setImageWithURL:[NSURL URLWithString:teacher.iphoto] placeholderImage:[UIImage imageNamed:@"123"]];
        if (i == 0) {
            _teacher = _teachersArray[i];
            _teacherRoleLabel.text = _teacher.teacherRole == TeacherRole_Give ? @"授课老师" : @"辅导老师";
            _teacherNameLabel.text = _teacher.inickname;
            _teacherIntroduceLabel.text = _teacher.iintr;
            [_headerImageView sd_setImageWithURL:[NSURL URLWithString:_teacher.iphoto] placeholderImage:[UIImage imageNamed:@"123"]];
        }
    }
    [self closeCellWithCount:count];
    _expansionImageView.hidden = NO;
    lineView.hidden = YES;
}

#pragma mark -lazy-
- (UILabel *)teacherRoleLabel{
    if (!_teacherRoleLabel){
        _teacherRoleLabel = [[UILabel alloc] init];
        _teacherRoleLabel.textColor = RGBColor(51, 51, 51);
        _teacherRoleLabel.font = [UIFont systemFontOfSize:PXTOPT(28)];
    }
    return _teacherRoleLabel;
}

- (UIImageView *)expansionImageView{
    if (!_expansionImageView) {
        _expansionImageView = [[UIImageView alloc] init];
        _expansionImageView.contentMode = UIViewContentModeScaleAspectFit;
        _expansionImageView.image =[UIImage imageNamed:@"返回拷贝5"];
    }
    return _expansionImageView;
}

- (UILabel *)teacherIntroduceLabel{
    if (!_teacherIntroduceLabel){
        _teacherIntroduceLabel = [[UILabel alloc] init];
        _teacherIntroduceLabel.textColor = RGBColor(153, 153, 153);
        _teacherIntroduceLabel.font = [UIFont systemFontOfSize:PXTOPT(24)];
    }
    return _teacherIntroduceLabel;
}

- (UIImageView *)headerImageView{
    if (!_headerImageView){
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.layer.masksToBounds = YES;
        _headerImageView.layer.cornerRadius = HeaderImageViewWH / 2;
    }
    return _headerImageView;
}

- (UILabel *)teacherNameLabel{
    if (!_teacherNameLabel){
        _teacherNameLabel = [[UILabel alloc] init];
        _teacherNameLabel.textColor = RGBColor(51, 51, 51);
        _teacherNameLabel.font = [UIFont systemFontOfSize:PXTOPT(28)];
    }
    return _teacherNameLabel;
}

- (UIImageView *)headerImageView1{
    if (!_headerImageView1){
        _headerImageView1 = [[UIImageView alloc] init];
        _headerImageView1.layer.masksToBounds = YES;
        _headerImageView1.layer.cornerRadius = HeaderImageViewWH / 2;
    }
    return _headerImageView1;
}

- (UILabel *)teacherNameLabel1{
    if (!_teacherNameLabel1){
        _teacherNameLabel1 = [[UILabel alloc] init];
    }
    return _teacherNameLabel1;
}

- (UIImageView *)headerImageView2{
    if (!_headerImageView2){
        _headerImageView2 = [[UIImageView alloc] init];
        _headerImageView2.layer.masksToBounds = YES;
        _headerImageView2.layer.cornerRadius = HeaderImageViewWH / 2;
    }
    return _headerImageView2;
}

- (UILabel *)teacherNameLabel2{
    if (!_teacherNameLabel2){
        _teacherNameLabel2 = [[UILabel alloc] init];
    }
    return _teacherNameLabel2;
}

- (UIImageView *)headerImageView3{
    if (!_headerImageView3){
        _headerImageView3 = [[UIImageView alloc] init];
        _headerImageView3.layer.masksToBounds = YES;
        _headerImageView3.layer.cornerRadius = HeaderImageViewWH / 2;
    }
    return _headerImageView3;
}

- (UILabel *)teacherNameLabel3{
    if (!_teacherNameLabel3){
        _teacherNameLabel3 = [[UILabel alloc] init];
    }
    return _teacherNameLabel3;
}

- (UIImageView *)headerImageView4{
    if (!_headerImageView4){
        _headerImageView4 = [[UIImageView alloc] init];
        _headerImageView4.layer.masksToBounds = YES;
        _headerImageView4.layer.cornerRadius = HeaderImageViewWH / 2;
    }
    return _headerImageView4;
}

- (UILabel *)teacherNameLabel4{
    if (!_teacherNameLabel4){
        _teacherNameLabel4 = [[UILabel alloc] init];
    }
    return _teacherNameLabel4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
