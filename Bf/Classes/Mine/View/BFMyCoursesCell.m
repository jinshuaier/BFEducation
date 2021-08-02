//
//  BFMyCoursesCell.m
//  Bf
//
//  Created by 春晓 on 2017/12/16.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFMyCoursesCell.h"
#import "BFTimeTransition.h"

@interface BFMyCoursesCell()
/*背景view*/
@property (nonatomic,strong) UIView *backView;
/*课程封面*/
@property (nonatomic,strong) UIImageView *classImg;
/*课程名称*/
@property (nonatomic,strong) UILabel *classTitle;
/*课程时间*/
@property (nonatomic,strong) UILabel *classTime;
/*课程学分*/
@property (nonatomic,strong) UILabel *classScore;
/*已经学习进度*/
@property (nonatomic , strong) UILabel *haveLearnedProgramLabel;
/*失效*/
@property (nonatomic,strong) UIImageView *loseEfficacyImageView;
/*进入直播间按钮*/
@property (nonatomic,strong) UIButton *enterLiveRoomBtn;
/*距离开课时间*/
@property (nonatomic,strong) UILabel *liveCorseStartTimeLabel;
@end
@implementation BFMyCoursesCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.classImg];
        [self.backView addSubview:self.classTitle];
        [self.backView addSubview:self.classTime];
        [self.backView addSubview:self.classScore];
        self.classScore.hidden = YES;
        [self.backView addSubview:self.haveLearnedProgramLabel];
        [self.backView addSubview:self.loseEfficacyImageView];
        [self.backView addSubview:self.enterLiveRoomBtn];
        [self.backView addSubview:self.liveCorseStartTimeLabel];
    }
    return self;
}

-(void)layoutSubviews {
    
    self.backView.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 5)
    .bottomSpaceToView(self.contentView, 5);
    
    self.classImg.sd_layout
    .leftSpaceToView(self.backView, 10)
    .topSpaceToView(self.backView, 10)
    .bottomSpaceToView(self.backView, 10)
    .widthIs(130);
    
    self.enterLiveRoomBtn.sd_layout
    .rightSpaceToView(self.backView, 5)
    .topSpaceToView(self.backView, 30)
    .heightIs(30)
    .widthIs(70);
    
    self.classTitle.sd_layout
    .topSpaceToView(self.backView, 10)
    .leftSpaceToView(self.classImg, 10)
    .rightSpaceToView(self.backView, 20)
    .heightIs(20);
    
    self.classTime.sd_layout
    .topSpaceToView(self.classTitle, 10)
    .leftSpaceToView(self.classImg, 10)
    .rightSpaceToView(self.backView, 20)
    .heightIs(20);
    
    self.classScore.sd_layout
    .bottomSpaceToView(self.backView, 10)
    .leftSpaceToView(self.classImg, 10)
    .widthIs(10)
    .heightIs(20);
    
    self.loseEfficacyImageView.sd_layout
    .bottomSpaceToView(self.backView, 20)
    .rightSpaceToView(self.backView, 5)
    .topSpaceToView(self.backView, 20)
    .widthIs(60);
    
    self.haveLearnedProgramLabel.sd_layout
    .bottomEqualToView(self.classTime)
    .rightSpaceToView(self.backView, 5)
    .topEqualToView(self.classTime)
    .leftEqualToView(self.enterLiveRoomBtn);
    
    self.liveCorseStartTimeLabel.sd_layout
    .bottomEqualToView(self.classScore)
    .rightSpaceToView(self.backView, 5)
    .topEqualToView(self.classScore)
    .leftSpaceToView(self.classScore, 5);
}

-(UIView *)backView {
    if (_backView == nil) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 5.0f;
    }
    return _backView;
}

- (UILabel *)haveLearnedProgramLabel{
    if (_haveLearnedProgramLabel == nil) {
        _haveLearnedProgramLabel = [[UILabel alloc] init];
        _haveLearnedProgramLabel.text = @"已经学习20%";
        _haveLearnedProgramLabel.font = [UIFont fontWithName:BFfont size:10.0f];
        _haveLearnedProgramLabel.textAlignment = NSTextAlignmentRight;
        _haveLearnedProgramLabel.textColor = [UIColor blackColor];
    }
    return _haveLearnedProgramLabel;
}

- (UIImageView *)loseEfficacyImageView{
    if (_loseEfficacyImageView == nil) {
        _loseEfficacyImageView = [[UIImageView alloc] init];
        _loseEfficacyImageView.image = [UIImage imageNamed:@"报满拷贝"];
        _loseEfficacyImageView.layer.cornerRadius = 5.0f;
        _loseEfficacyImageView.clipsToBounds = YES;
        _loseEfficacyImageView.contentMode = UIViewContentModeScaleAspectFit;
        _loseEfficacyImageView.hidden = YES;
    }
    return _loseEfficacyImageView;
}

-(UIImageView *)classImg {
    if (_classImg == nil) {
        _classImg = [[UIImageView alloc] init];
        _classImg.image = [UIImage imageNamed:@"组3"];
        _classImg.layer.cornerRadius = 5.0f;
        _classImg.clipsToBounds = YES;
        _classImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _classImg;
}

-(UILabel *)classTitle {
    if (_classTitle == nil) {
        _classTitle = [[UILabel alloc] init];
        _classTitle.text = @"宝马车系列维修";
        _classTitle.font = [UIFont fontWithName:BFfont size:14.0f];
        _classTitle.textColor = [UIColor blackColor];
    }
    return _classTitle;
}

-(UILabel *)classTime {
    if (_classTime == nil) {
        _classTime = [[UILabel alloc] init];
        _classTime.text = @"11月22号-12月22号";
        _classTime.font = [UIFont fontWithName:BFfont size:12.0f];
        _classTime.textColor = [UIColor grayColor];
    }
    return _classTime;
}

- (UIButton *)enterLiveRoomBtn{
    if (!_enterLiveRoomBtn) {
        _enterLiveRoomBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_enterLiveRoomBtn setTitle:@"进入直播间" forState:(UIControlStateNormal)];
        [_enterLiveRoomBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _enterLiveRoomBtn.backgroundColor = RGBColor(0, 164, 255);
        _enterLiveRoomBtn.titleLabel.font = [UIFont fontWithName:BFfont size:13];
        _enterLiveRoomBtn.layer.masksToBounds = YES;
        _enterLiveRoomBtn.layer.cornerRadius = 3;
    }
    return _enterLiveRoomBtn;
}

-(UILabel *)classScore {
    if (_classScore == nil) {
        _classScore = [[UILabel alloc] init];
        _classScore.text = @"300学分";
        _classScore.font = [UIFont fontWithName:BFfont size:13.0f];
        _classScore.textColor = [UIColor redColor];
    }
    return _classScore;
}

- (UILabel *)liveCorseStartTimeLabel{
    if (_liveCorseStartTimeLabel == nil) {
        _liveCorseStartTimeLabel = [[UILabel alloc] init];
        _liveCorseStartTimeLabel.text = @"距离开课还剩1小时30分";
        _liveCorseStartTimeLabel.font = [UIFont fontWithName:BFfont size:13.0f];
        _liveCorseStartTimeLabel.textAlignment = NSTextAlignmentRight;
        _liveCorseStartTimeLabel.textColor = [UIColor grayColor];
    }
    return _liveCorseStartTimeLabel;
}

- (void)setCourseModel:(BFCourseModel *)courseModel{
    if (_courseModel) {
        _courseModel = nil;
    }
    _courseModel = courseModel;
    [_classImg sd_setImageWithURL:[NSURL URLWithString:_courseModel.cscover] placeholderImage:PLACEHOLDER];
    _classTitle.text = _courseModel.ctitle;
    _classScore.text = [NSString stringWithFormat:@"%ld学分",_courseModel.cprice];
    _classTime.text = [NSString stringWithFormat:@"%@-%@",[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",_courseModel.cstarttime] dateFormat:@"MM月dd号"],[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",_courseModel.cendtime] dateFormat:@"MM月dd号"]];
    if (_courseModel.ckey == 0 && _courseModel.isLoseEfficacy) {
        _enterLiveRoomBtn.hidden = YES;
        _liveCorseStartTimeLabel.hidden = YES;
        _haveLearnedProgramLabel.hidden = YES;
        _loseEfficacyImageView.hidden = YES;
    }else if(_courseModel.ckey == 0 && !_courseModel.isLoseEfficacy){
        _loseEfficacyImageView.hidden = YES;
        _enterLiveRoomBtn.hidden = NO;
        _liveCorseStartTimeLabel.hidden = NO;
        _haveLearnedProgramLabel.hidden = YES;
        _liveCorseStartTimeLabel.text = [BFTimeTransition diffTimeTransformWithTime:_setCourseModel.cstarttime];
    }else{
        _loseEfficacyImageView.hidden = YES;
        _enterLiveRoomBtn.hidden = YES;
        _liveCorseStartTimeLabel.hidden = YES;
        _haveLearnedProgramLabel.hidden = YES;
    }
}

- (void)setSetCourseModel:(BFSetCourseModel *)setCourseModel{
    if (_setCourseModel) {
        _setCourseModel = nil;
    }
    _setCourseModel = setCourseModel;
    [_classImg sd_setImageWithURL:[NSURL URLWithString:_setCourseModel.cscover] placeholderImage:PLACEHOLDER];
    _classTitle.text = _setCourseModel.cstitle;
    _classScore.text = [NSString stringWithFormat:@"%ld学分",_setCourseModel.csprice];
    _classTime.text = [NSString stringWithFormat:@"%@-%@",[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",_setCourseModel.cstarttime] dateFormat:@"MM月dd号"],[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",_setCourseModel.cendtime] dateFormat:@"MM月dd号"]];
    if (_courseModel.ckey == 0 && _courseModel.isLoseEfficacy) {
        _enterLiveRoomBtn.hidden = YES;
        _liveCorseStartTimeLabel.hidden = YES;
        _haveLearnedProgramLabel.hidden = YES;
        _loseEfficacyImageView.hidden = YES;
    }else if(_courseModel.ckey == 0 && !_courseModel.isLoseEfficacy){
        _loseEfficacyImageView.hidden = YES;
        _enterLiveRoomBtn.hidden = NO;
        _liveCorseStartTimeLabel.hidden = NO;
        _haveLearnedProgramLabel.hidden = YES;
        _liveCorseStartTimeLabel.text = [BFTimeTransition diffTimeTransformWithTime:_setCourseModel.cstarttime];
    }else{
        _loseEfficacyImageView.hidden = YES;
        _enterLiveRoomBtn.hidden = YES;
        _liveCorseStartTimeLabel.hidden = YES;
        _haveLearnedProgramLabel.hidden = YES;
    }
}

- (void)setMyCourseModel:(BFMyCourseModel *)myCourseModel{
    if (_myCourseModel) {
        _myCourseModel = nil;
    }
    _myCourseModel = myCourseModel;
    [_classImg sd_setImageWithURL:[NSURL URLWithString:_myCourseModel.cCover] placeholderImage:[UIImage imageNamed:@"组3"]];
    _classTitle.text = _myCourseModel.cTitle;
    _classScore.text = [NSString stringWithFormat:@"%ld学分",_myCourseModel.rCRedit];
//    _classTime.text = [NSString stringWithFormat:@"%@-%@",[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",_myCourseModel.cstarttime] dateFormat:@"MM月dd号"],[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",_myCourseModel.cendtime] dateFormat:@"MM月dd号"]];
    _classTime.text = [NSString stringWithFormat:@"%@-%@",_myCourseModel.cStartDateTime,_myCourseModel.cEndDateTime];
    if (_myCourseModel.csKey == 0 && _myCourseModel.isLoseEfficacy) {
        _enterLiveRoomBtn.hidden = YES;
        _liveCorseStartTimeLabel.hidden = YES;
        _haveLearnedProgramLabel.hidden = YES;
        _loseEfficacyImageView.hidden = YES;
    }else if(_myCourseModel.csKey == 0 && !_myCourseModel.isLoseEfficacy){
        _loseEfficacyImageView.hidden = YES;
        _enterLiveRoomBtn.hidden = NO;
        _liveCorseStartTimeLabel.hidden = NO;
        _haveLearnedProgramLabel.hidden = YES;
        _liveCorseStartTimeLabel.text = [BFTimeTransition diffTimeTransformWithTime:_setCourseModel.cstarttime];
    }else{
        _loseEfficacyImageView.hidden = YES;
        _enterLiveRoomBtn.hidden = YES;
        _liveCorseStartTimeLabel.hidden = YES;
        _haveLearnedProgramLabel.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
