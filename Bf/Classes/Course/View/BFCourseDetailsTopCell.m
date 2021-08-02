//
//  BFCourseDetailsTopCell.m
//  基本框架
//
//  Created by 春晓 on 2017/11/30.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCourseDetailsTopCell.h"
#import <SDAutoLayout.h>

@interface BFCourseDetailsTopCell ()
// 课程状态
@property (nonatomic , strong) UILabel *courseStateLabel;
// 课程名字
@property (nonatomic , strong) UILabel *courseNameLabel;
// 课程时间
@property (nonatomic , strong) UILabel *courseTimeLabel;
// 剩余名额
@property (nonatomic , strong) UILabel *restNumberLabel;
// 学分
@property (nonatomic , strong) UILabel *creditLabel;
// 报满状态标志
@property (nonatomic , strong) UIImageView *NoRestImageView;
@end

@implementation BFCourseDetailsTopCell{
    UIView *lineView;
    UILabel *creditTextLabel;
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
    _courseStateLabel = [[UILabel alloc] init];
    _courseStateLabel.backgroundColor = RGBColor(0, 119, 219);
    _courseStateLabel.textAlignment = NSTextAlignmentCenter;
    _courseStateLabel.textColor = [UIColor whiteColor];
    _courseStateLabel.layer.masksToBounds = YES;
    _courseStateLabel.layer.cornerRadius = 3;
    _courseStateLabel.font = [UIFont systemFontOfSize:PXTOPT(25)];
    [self.contentView addSubview:_courseStateLabel];
    _courseNameLabel = [[UILabel alloc] init];
    _courseNameLabel.textColor = RGBColor(71, 70, 70);
    _courseNameLabel.font = [UIFont systemFontOfSize:PXTOPT(30)];
    [self.contentView addSubview:_courseNameLabel];
    _courseTimeLabel = [[UILabel alloc] init];
    _courseTimeLabel.textColor = RGBColor(102, 102, 102);
    _courseTimeLabel.font = [UIFont systemFontOfSize:PXTOPT(26)];
    [self.contentView addSubview:_courseTimeLabel];
    _restNumberLabel = [[UILabel alloc] init];
    _restNumberLabel.textColor = RGBColor(153, 153, 153);
    _restNumberLabel.font = [UIFont systemFontOfSize:PXTOPT(26)];
    [self.contentView addSubview:_restNumberLabel];
    creditTextLabel = [[UILabel alloc] init];
    creditTextLabel.textColor = RGBColor(255, 73, 6);
    creditTextLabel.text = @"学分";
    creditTextLabel.font = [UIFont systemFontOfSize:PXTOPT(24)];
    creditTextLabel.hidden = YES;
    [self.contentView addSubview:creditTextLabel];
    _creditLabel = [[UILabel alloc] init];
    _creditLabel.textColor = RGBColor(255, 73, 6);
    _creditLabel.textAlignment = NSTextAlignmentRight;
    _creditLabel.font = [UIFont systemFontOfSize:PXTOPT(36)];
    _creditLabel.hidden = YES;
    [self.contentView addSubview:_creditLabel];
    _NoRestImageView = [[UIImageView alloc] init];
    _NoRestImageView.image = [UIImage imageNamed:@"报满拷贝"];
    [self.contentView addSubview:_NoRestImageView];
    
    lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGBColor(240, 240, 240);
    [self.contentView addSubview:lineView];
}

- (void)layout{
    _courseStateLabel.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(20))
    .topSpaceToView(self.contentView, PXTOPT(30))
    .widthIs(40)
    .heightIs(20);
    
    _NoRestImageView.sd_layout
    .rightSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 5)
    .widthIs(60)
    .heightIs(60);
    
    _courseNameLabel.sd_layout
    .leftSpaceToView(_courseStateLabel, 10)
    .topSpaceToView(self.contentView, 10)
    .rightSpaceToView(_NoRestImageView, 10)
    .heightIs(30);
    
    _courseTimeLabel.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(_courseStateLabel, PXTOPT(20))
    .rightSpaceToView(_NoRestImageView, 10)
    .heightIs(20);
    
    lineView.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(PXTOPT(16));
    
    creditTextLabel.sd_layout
    .rightSpaceToView(self.contentView, 10)
    .bottomSpaceToView(lineView, 10)
    .widthIs(50)
    .heightIs(30);
    
    _creditLabel.sd_layout
    .rightSpaceToView(creditTextLabel, 0)
    .bottomSpaceToView(lineView, 10)
    .widthIs(80)
    .heightIs(30);
    
    _restNumberLabel.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .bottomSpaceToView(lineView, 10)
    .rightSpaceToView(_creditLabel, 10)
    .heightIs(30);
    
    
}

- (void)setCourseModel:(BFCourseModel *)courseModel{
    if (_courseModel){
        _courseModel = nil;
    }
    _courseModel = courseModel;
    
    _courseStateLabel.text = _courseModel.ckey == 0 ? @"直播" : @"视频";
    _courseNameLabel.text = _courseModel.ctitle;
//    _courseTimeLabel.text = [NSString stringWithFormat:@"%@-%@",[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",_courseModel.cstarttime] dateFormat:@"MM月dd日"],[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",_courseModel.cendtime] dateFormat:@"MM月dd日"]];
    
    NSString *checkStr = GetFromUserDefaults(@"checkVersion");
    if ([checkStr isEqualToString:@"1"]) {
        _courseTimeLabel.text = @"";
        if (_courseModel.ckey == 0) {
            _restNumberLabel.text = @"";
            if (_courseModel.cnum == 0) {
                _NoRestImageView.hidden = NO;
            }else{
                _NoRestImageView.hidden = YES;
            }
        }else{
            _restNumberLabel.text = @"";
            _NoRestImageView.hidden = YES;
        }
    }
    else {
        _courseTimeLabel.text = @"有效期 : 180天";
        _creditLabel.text = [NSString stringWithFormat:@"%ld",_courseModel.cprice];
        if (_courseModel.ckey == 0) {
            _restNumberLabel.text = [NSString stringWithFormat:@"剩余%ld名额",_courseModel.cnum];
            if (_courseModel.cnum == 0) {
                _NoRestImageView.hidden = NO;
            }else{
                _NoRestImageView.hidden = YES;
            }
        }else{
            _restNumberLabel.text = [NSString stringWithFormat:@"已学习%ld人",_courseModel.cnum];
            _NoRestImageView.hidden = YES;
        }
    }
}

- (void)setSetCourseModel:(BFSetCourseModel *)setCourseModel{
    if (_setCourseModel){
        _setCourseModel = nil;
    }
    _setCourseModel = setCourseModel;
    
    _courseStateLabel.text = _setCourseModel.ckey == 0 ? @"直播" : @"视频";
    _courseNameLabel.text = _setCourseModel.cstitle;
//    _courseTimeLabel.text = [NSString stringWithFormat:@"%@-%@",[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",_setCourseModel.cstarttime] dateFormat:@"MM月dd日"],[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",_setCourseModel.cendtime] dateFormat:@"MM月dd日"]];
    
    NSString *checkStr = GetFromUserDefaults(@"checkVersion");
    if ([checkStr isEqualToString:@"1"]) {
        _courseTimeLabel.text = @"";
        if (_setCourseModel.ckey == 0) {
            _restNumberLabel.text = @"";
            if (_setCourseModel.cnum == 0) {
                _NoRestImageView.hidden = NO;
            }else{
                _NoRestImageView.hidden = YES;
            }
        }else{
            _restNumberLabel.text = @"";
            _NoRestImageView.hidden = YES;
        }
    }
    else {
        _courseTimeLabel.text = @"有效期 : 180天";
        _creditLabel.text = [NSString stringWithFormat:@"%ld",_setCourseModel.csprice];
        if (_setCourseModel.ckey == 0) {
            _restNumberLabel.text = [NSString stringWithFormat:@"剩余%ld名额",_courseModel.cnum];
            if (_setCourseModel.cnum == 0) {
                _NoRestImageView.hidden = NO;
            }else{
                _NoRestImageView.hidden = YES;
            }
        }else{
            _restNumberLabel.text = [NSString stringWithFormat:@"已学习%ld人",_courseModel.cnum];
            _NoRestImageView.hidden = YES;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
