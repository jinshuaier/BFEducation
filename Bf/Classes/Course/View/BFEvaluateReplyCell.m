//
//  BFEvaluateReplyCell.m
//  NewTest
//
//  Created by 春晓 on 2017/12/2.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFEvaluateReplyCell.h"
#import "NSMutableAttributedString+BFAttributedString.h"


@interface BFEvaluateReplyCell ()

@end

#define ReplyBGColor   RGBColor(243, 243, 243)
#define ReplyTextColor RGBColor(153, 153, 153)

@implementation BFEvaluateReplyCell{
    UIView *backView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self layout];
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    }
    return self;
}

- (void)setupUI{
    backView = [[UIView alloc] init];
    [self.contentView addSubview:backView];
    backView.backgroundColor = ReplyBGColor;
    _replyLabel = [[UILabel alloc] init];
    _replyLabel.numberOfLines = 0;
    [backView addSubview:_replyLabel];
}

- (void)layout{
    
    backView.sd_layout
    .leftSpaceToView(self.contentView, 60)
    .rightSpaceToView(self.contentView, PXTOPT(40))
    .topSpaceToView(self.contentView, 0)
    .bottomSpaceToView(self.contentView, 0);
    
    _replyLabel.sd_layout
    .leftSpaceToView(backView, 10)
    .rightEqualToView(backView)
    .topSpaceToView(backView, 0)
    .bottomSpaceToView(backView, 0);
}

- (void)setEvaluateReplyModel:(BFEvaluateReplyModel *)evaluateReplyModel{
    _evaluateReplyModel = evaluateReplyModel;
    NSString *name = [NSString stringWithFormat:@"%@@%@",_evaluateReplyModel.iNickName,_evaluateReplyModel.iNickNames];
    _replyLabel.attributedText =
    [NSMutableAttributedString new]
    .add(name,@{
                NSForegroundColorAttributeName:RGBColor(0, 126, 212),
                NSFontAttributeName :[UIFont systemFontOfSize:11],
                })
    .add(_evaluateReplyModel.pCComment,@{
                                         NSForegroundColorAttributeName:ReplyTextColor,
                                         NSFontAttributeName :[UIFont systemFontOfSize:11],
                                         });
}

- (void)setCourseEvaluateReplyModel:(BFCourseEvaluateReplyModel *)courseEvaluateReplyModel{
    _courseEvaluateReplyModel = courseEvaluateReplyModel;
    NSString *name = [NSString stringWithFormat:@"%@：",_courseEvaluateReplyModel.inickname];
    _replyLabel.attributedText =
    [NSMutableAttributedString new]
    .add(name,@{
                NSForegroundColorAttributeName:RGBColor(0, 126, 212),
                NSFontAttributeName :[UIFont systemFontOfSize:13],
                })
    .add(_courseEvaluateReplyModel.ceeval,@{
                                         NSForegroundColorAttributeName:ReplyTextColor,
                                         NSFontAttributeName :[UIFont systemFontOfSize:13],
                                         });
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
