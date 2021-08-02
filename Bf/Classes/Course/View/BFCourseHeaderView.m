//
//  BFCourseHeaderView.m
//  Bf
//
//  Created by 春晓 on 2018/4/17.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFCourseHeaderView.h"
#import "NSMutableAttributedString+BFAttributedString.h"

@interface BFCourseHeaderView ()
// title
@property (nonatomic , strong) UILabel *titleLabel;
@end

@implementation BFCourseHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
    }
    return self;
    
    
}
-(void)createSubviews{
    //自定义的UI
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 10)];
    [self addSubview:lineView];
    lineView.backgroundColor = RGBColor(245, 245, 245);
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, KScreenW, 54)];
//    _titleLabel.text = @"/   电动汽车   /";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
//    NSString *name = [NSString stringWithFormat:@"%@@%@",_evaluateReplyModel.iNickName,_evaluateReplyModel.iNickNames];
    _titleLabel.attributedText =
    [NSMutableAttributedString new]
    .add(@"/    ",@{
                NSForegroundColorAttributeName:RGBColor(180, 180, 180),
                NSFontAttributeName :[UIFont systemFontOfSize:11],
                })
    .add(titleStr,@{
                                         NSForegroundColorAttributeName:RGBColor(51, 51, 51),
                                         NSFontAttributeName :[UIFont systemFontOfSize:15],
                                         })
    .add(@"    /",@{
                    NSForegroundColorAttributeName:RGBColor(180, 180, 180),
                    NSFontAttributeName :[UIFont systemFontOfSize:11],
                    });
//    _titleLabel.text = [NSString stringWithFormat:@"/    %@    /",_titleStr];
}

@end
