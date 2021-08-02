//
//  BFMiddleCollectionCell.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/29.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//


//@property (strong, nonatomic) UIImageView *topImage;
//@property (strong, nonatomic) UIImageView *middleImg0;
//@property (strong, nonatomic) UILabel *middleLbl0;
//@property (strong, nonatomic) UIImageView *middleImg1;
//@property (strong, nonatomic) UILabel *middleLbl1;
//@property (strong, nonatomic) UIImageView *middleImg2;
//@property (strong, nonatomic) UILabel *middleLbl2;
//@property (strong, nonatomic) UILabel *moreLabel;
//@property (strong, nonatomic) UILabel *specialistLbl;
//@property (strong, nonatomic) UILabel *consultLbl;

#import "BFMiddleCollectionCell.h"
@interface BFMiddleCollectionCell()

@property (nonatomic, strong) AppDelegate *appDelegate;

@end
@implementation BFMiddleCollectionCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        AppDelegate  *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.appDelegate = appDelegate;
        _topImage  = [[UIImageView alloc] initWithFrame:CGRectMake((200 - 67.5)/2   , 20, 67.5   , 60  )];
        _topImage.image = [UIImage imageNamed:@"国产"];
        [self.contentView addSubview:_topImage];
        
        _topLbl = [[UILabel alloc] initWithFrame:CGRectMake((200 - 100)/2   , _topImage.bottom + 10, 100   , 15  )];
        _topLbl.text = @"国产";
        _topLbl.textColor = RGBColor(51, 51, 51);
        _topLbl.font = [UIFont fontWithName:BFfont size:14];
        _topLbl.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_topLbl];
        
        
        _middleImg0 = [[UIImageView alloc] initWithFrame:CGRectMake((200 - 35 * 3)/4   , _topLbl.bottom + 20, 35   , 35  )];
        _middleImg0.image = [UIImage imageNamed:@"长城"];
        [self.contentView addSubview:_middleImg0];
        
        _middleLbl0 = [[UILabel alloc] initWithFrame:CGRectMake((200 - 35 * 3)/4   , _middleImg0.bottom + 7, 35   , 11  )];
        _middleLbl0.text = @"长城";
        _middleLbl0.textColor = RGBColor(102, 102, 102);
        _middleLbl0.font = [UIFont fontWithName:BFfont size:11];
        _middleLbl0.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_middleLbl0];
        
        _middleImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(_middleImg0.right + (200 - 35 * 3)/4   , _topLbl.bottom + 20, 35   , 35  )];
        _middleImg1.image = [UIImage imageNamed:@"比亚迪"];
        [self.contentView addSubview:_middleImg1];
        
        _middleLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(_middleImg0.right + (200 - 35 * 3)/4   , _middleImg1.bottom + 7, 35   , 11  )];
        _middleLbl1.text = @"比亚迪";
        _middleLbl1.textColor = RGBColor(102, 102, 102);
        _middleLbl1.font = [UIFont fontWithName:BFfont size:11];
        _middleLbl1.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_middleLbl1];
        
        _middleImg2 = [[UIImageView alloc] initWithFrame:CGRectMake(_middleImg1.right + (200 - 35 * 3)/4   , _topLbl.bottom + 20, 35   , 35  )];
        _middleImg2.image = [UIImage imageNamed:@"吉利"];
        [self.contentView addSubview:_middleImg2];
        
        _middleLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(_middleImg1.right + (200 - 35 * 3)/4   , _middleImg2.bottom + 7, 35   , 11  )];
        _middleLbl2.text = @"吉利";
        _middleLbl2.textColor = RGBColor(102, 102, 102);
        _middleLbl2.font = [UIFont fontWithName:BFfont size:11];
        _middleLbl2.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_middleLbl2];
        
        _moreLabel = [[UILabel alloc] initWithFrame:CGRectMake((200 - 150)/2   , _middleLbl1.bottom + 14.5, 150   , 12  )];
        _moreLabel.text = @"更多车型>";
        _moreLabel.textColor = RGBColor(153, 153, 153);
        _moreLabel.font = [UIFont fontWithName:BFfont size:11.0f];
        _moreLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_moreLabel];
        
        _specialistLbl = [[UILabel alloc] initWithFrame:CGRectMake((200 - 122.5)/2   , _moreLabel.bottom + 15, 122.5   , 30  )];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"26位专家在线"]];
        [AttributedStr addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:19.0]
                              range:NSMakeRange(0,2)];
        [AttributedStr addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:11.0]
                              range:NSMakeRange(2,5)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:RGBColor(0, 157, 255)
                              range:NSMakeRange(0,7)];
        _specialistLbl.attributedText = AttributedStr;
        _specialistLbl.backgroundColor = RGBColor(239, 247, 255);
        _specialistLbl.layer.cornerRadius = 15;
        _specialistLbl.clipsToBounds = YES;
        _specialistLbl.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_specialistLbl];
        
        _consultLbl = [[UILabel alloc] initWithFrame:CGRectMake((200 - 122.5)/2   , _specialistLbl.bottom + 10, 122.5   , 30  )];
        _consultLbl.text = @"立即咨询";
        _consultLbl.font = [UIFont fontWithName:BFfont size:14.0f];
        _consultLbl.textColor = RGBColor(255, 255, 255);
        _consultLbl.backgroundColor = RGBColor(51, 150, 252);
        _consultLbl.layer.cornerRadius = 15;
        _consultLbl.clipsToBounds = YES;
        _consultLbl.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_consultLbl];
    }
    return self;
}
@end
