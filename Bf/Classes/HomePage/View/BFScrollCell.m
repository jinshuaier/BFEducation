//
//  BFScrollCell.m
//  test
//
//  Created by 乔春晓 on 2017/11/26.
//  Copyright © 2017年 QCX. All rights reserved.
//

#import "BFScrollCell.h"

@implementation BFScrollCell

- (void)createUI{
    self.layer.cornerRadius = 10;
    [self addSubview:self.im];
}

- (UIImageView *)im{
    if (!_im) {
        _im = [[UIImageView alloc]initWithFrame:CGRectMake(0, PXTOPT(20), self.frame.size.width, PXTOPT(224))];
    }
    return _im;
}
@end
