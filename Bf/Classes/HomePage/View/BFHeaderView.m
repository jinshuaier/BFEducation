//
//  BFHeaderView.m
//  test
//
//  Created by 乔春晓 on 2017/11/25.
//  Copyright © 2017年 QCX. All rights reserved.
//

#import "BFHeaderView.h"
#import <SDAutoLayout.h>
@interface BFHeaderView ()
// 提示图片
@property (nonatomic, strong) UIImageView *titleImageView;
// 提示文字
@property (nonatomic, strong) UILabel *titleLabel;
// 更多按钮
@property (nonatomic, strong) UIButton *moreBtn;
@end

@implementation BFHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)createHeaderView{
    return [[self alloc] initWithFrame:CGRectMake(0, 0, KScreenW, HeaderViewHeight)];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpUI];
        [self layout];
    }
    return self;
}

- (void)setUpUI{
    _titleImageView = [[UIImageView alloc] init];
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:PXTOPT(32)];
    [self addSubview:_titleImageView];
    [self addSubview:_titleLabel];
    _moreBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_moreBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_moreBtn setTitle:@"更多" forState:(UIControlStateNormal)];
    [_moreBtn setImage:[UIImage imageNamed:@"图层8"] forState:(UIControlStateNormal)];
    _moreBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 40, 0, 0);
    _moreBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -18, 0, 0);
    [_moreBtn setFont:[UIFont systemFontOfSize:PXTOPT(24)]];
    [_moreBtn setTitleColor:CCRGBColor(102, 102, 102) forState:(UIControlStateNormal)];
    [self addSubview:_moreBtn];
    [_moreBtn addTarget:self action:@selector(moreAction) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)layout{
    _titleImageView.sd_layout
    .leftSpaceToView(self, PXTOPT(48))
    .widthIs(15)
    .heightIs(15)
    .centerYEqualToView(self);
    
    _titleLabel.sd_layout
    .leftSpaceToView(_titleImageView, PXTOPT(18))
    .widthIs(KScreenW / 2)
    .heightIs(PXTOPT(32))
    .centerYEqualToView(self);
    
    _moreBtn.sd_layout
    .rightSpaceToView(self, PXTOPT(42))
    .widthIs(50)
    .heightIs(self.height)
    .centerYEqualToView(self);
}

- (void)moreAction{
    if (_delegate && [_delegate respondsToSelector:@selector(moreInformation)]) {
        [_delegate moreInformation];
    }
}

- (void)setTitleStr:(NSString *)titleStr{
    if (_titleStr) {
        _titleStr = nil;
    }
    _titleStr = titleStr;
    _titleLabel.text = _titleStr;
}

- (void)setTitleImg:(UIImage *)titleImg{
    if (_titleImg) {
        _titleImg = nil;
    }
    _titleImg = titleImg;
    _titleImageView.image = _titleImg;
}

- (void)setIsHiddenMoreBtn:(BOOL)isHiddenMoreBtn{
    _isHiddenMoreBtn = isHiddenMoreBtn;
    _moreBtn.hidden = _isHiddenMoreBtn;
}

@end
