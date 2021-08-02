//
//  BFCommunityDetailsTopCell.m
//  NewTest
//
//  Created by 春晓 on 2017/12/2.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFCommunityDetailsTopCell.h"

@interface BFCommunityDetailsTopCell ()
// 头像
@property (nonatomic , strong) UIImageView *headImageView;
// 名字
@property (nonatomic , strong) UILabel *nameLabel;
// 时间
@property (nonatomic , strong) UILabel *timeLabel;
// 标签
@property (nonatomic , strong) UIImageView *tagImageView;
// 标签
@property (nonatomic , strong) UILabel *tagLabel;
// 删除
@property (nonatomic , strong) UIButton *deleteBtn;
// 编辑
@property (nonatomic , strong) UIButton *editBtn;
@end
@implementation BFCommunityDetailsTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _headImageView = [[UIImageView alloc] init];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = PXTOPT(68 / 2);
    [self.contentView addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(26.0f)];
    _nameLabel.textColor = RGBColor(0, 169, 255);
    [self.contentView addSubview:_nameLabel];
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(20.0f)];
    _timeLabel.textColor = RGBColor(153, 153, 153);
    [self.contentView addSubview:_timeLabel];
//    _titleLabel = [[UILabel alloc] init];
//    _titleLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(38.0f)];
//    _titleLabel.textColor = RGBColor(51, 51, 51);
//    _titleLabel.numberOfLines = 0;
//    [self.contentView addSubview:_titleLabel];
//    _contentLabel = [[UILabel alloc] init];
//    _contentLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(28.0f)];
//    _contentLabel.textColor = RGBColor(51, 51, 51);
//    _contentLabel.numberOfLines = 0;
//    [self.contentView addSubview:_contentLabel];
    
    _tagImageView = [[UIImageView alloc] init];
    _tagImageView.image = [UIImage imageNamed:@"矩形1"];
    _tagImageView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:_tagImageView];
    
    _tagLabel = [[UILabel alloc] init];
    _tagLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(22)];
    _tagLabel.textColor = RGBColor(255, 255, 255);
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_tagLabel];
    
    _deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_deleteBtn setTitle:@"删除" forState:(UIControlStateNormal)];
    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:PXTOPT(26.0f)];
    [_deleteBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    _deleteBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _deleteBtn.layer.borderWidth = 0.5f;
    [self.contentView addSubview:_deleteBtn];
    [_deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    _editBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_editBtn setTitle:@"编辑" forState:(UIControlStateNormal)];
    _editBtn.titleLabel.font = [UIFont systemFontOfSize:PXTOPT(26.0f)];
    [_editBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    _editBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _editBtn.layer.borderWidth = 0.5f;
    [self.contentView addSubview:_editBtn];
    _editBtn.hidden = YES;
    [_editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)layoutSubviews{
    _headImageView.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(20))
    .topSpaceToView(self.contentView, PXTOPT(30))
    .widthIs(PXTOPT(68))
    .heightIs(PXTOPT(68));
    
    _nameLabel.sd_layout
    .leftSpaceToView(_headImageView, PXTOPT(22))
    .topSpaceToView(self.contentView, PXTOPT(36))
    .widthIs(KScreenW - PXTOPT(60 + 68))
    .heightIs(PXTOPT(29));
    
    _timeLabel.sd_layout
    .leftSpaceToView(_headImageView, PXTOPT(20))
    .topSpaceToView(_nameLabel, PXTOPT(14))
    .widthIs(KScreenW - PXTOPT(60 + 68))
    .heightIs(PXTOPT(21));
    
    _tagImageView.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(0))
    .topSpaceToView(_timeLabel, PXTOPT(20))
    .widthIs(50)
    .heightIs(PXTOPT(40));
    
    _tagLabel.sd_layout
    .leftEqualToView(_tagImageView)
    .rightEqualToView(_tagImageView)
    .topEqualToView(_tagImageView)
    .bottomEqualToView(_tagImageView);
    
    _deleteBtn.sd_layout
    .rightSpaceToView(self.contentView, PXTOPT(20))
    .topSpaceToView(self.contentView, PXTOPT(36))
    .widthIs(PXTOPT(60))
    .heightIs(PXTOPT(30));
    
    _editBtn.sd_layout
    .rightSpaceToView(_deleteBtn, PXTOPT(20))
    .topSpaceToView(self.contentView, PXTOPT(36))
    .widthIs(PXTOPT(60))
    .heightIs(PXTOPT(30));
    
//    _titleLabel.sd_layout
//    .leftSpaceToView(self.contentView, PXTOPT(28))
//    .topSpaceToView(_tagImageView, PXTOPT(38))
//    .rightSpaceToView(self.contentView, PXTOPT(28))
//    .heightIs(PXTOPT(38));
//
//    _contentLabel.sd_layout
//    .leftSpaceToView(self.contentView, PXTOPT(28))
//    .topSpaceToView(_titleLabel, PXTOPT(48))
//    .rightSpaceToView(self.contentView, PXTOPT(28))
//    .bottomSpaceToView(self.contentView, PXTOPT(10));
}

- (void)setIsSelfSend:(BOOL)isSelfSend{
    _isSelfSend = isSelfSend;
    _deleteBtn.hidden = _isSelfSend ? NO : YES;
//    _editBtn.hidden = _isSelfSend ? NO : YES;
}

- (void)setModel:(BFCommunityModel *)model{
    if (_model) {
        _model = nil;
    }
    _model = model;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:_model.iPhoto] placeholderImage:[UIImage imageNamed:@"123"]];
    _nameLabel.text = _model.iNickName;
    _timeLabel.text = [BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",_model.pTime] dateFormat:@"YYYY-MM-dd"];
//    _titleLabel.text = _model.pTitle;
//    _contentLabel.text = _model.pCcont;
    if (_model.pKey == 0) {
        _tagLabel.hidden = YES;
        _tagImageView.hidden = YES;
        _tagLabel.text = @"默认";
    }else if (_model.pKey == 1){
        _tagLabel.hidden = NO;
        _tagImageView.hidden = NO;
        _tagLabel.text = @"精华";
    }else if(_model.pKey == 2) {
        _tagLabel.hidden = NO;
        _tagImageView.hidden = NO;
        _tagLabel.text = @"置顶";
    }
}

- (void)deleteBtnClick{
    if (_delegate && [_delegate respondsToSelector:@selector(deleteAction)]) {
        [_delegate deleteAction];
    }
}

- (void)editBtnClick{
//    if (_delegate && [_delegate respondsToSelector:@selector(editActionWithBtn:)]) {
//        [_delegate editActionWithBtn:_editBtn];
//    }
    if(self.isFirstResponder){
        [self resignFirstResponder];
    }else{
        [self becomeFirstResponder];
    }
    
    UIMenuItem *textItem = [[UIMenuItem alloc]initWithTitle:@"文字" action:@selector(editText)];
    UIMenuItem *videoItem = [[UIMenuItem alloc]initWithTitle:@"视频" action:@selector(editVideo)];
    UIMenuItem *imageItem = [[UIMenuItem alloc]initWithTitle:@"图片" action:@selector(editImage)];
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    menuController.menuItems = @[textItem,videoItem,imageItem];
    [menuController setTargetRect:CGRectMake(KScreenW - PXTOPT(230), PXTOPT(36), 100, 100) inView:self.superview];
    [menuController setMenuVisible:YES animated:YES];
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return action==@selector(editText)||
    action==@selector(editVideo)||
    action==@selector(editImage);
}

- (void)editText{
    NSLog(@"编辑文字");
}

- (void)editVideo{
    NSLog(@"编辑视频");
}

- (void)editImage{
    NSLog(@"编辑图片");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
