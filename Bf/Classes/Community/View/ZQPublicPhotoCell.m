//
//  ZQPublicPhotoCell.m
//  ZQArbutus
//
//  Created by 陈大鹰 on 19/03/2017.
//  Copyright © 2017 ZQ. All rights reserved.
//

#import "ZQPublicPhotoCell.h"

@implementation ZQPublicPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)deletePhoto:(UIButton *)sender {
  [self.delegate delegatePhotoFromCell:self];
}

@end
