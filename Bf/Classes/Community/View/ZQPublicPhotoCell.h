//
//  ZQPublicPhotoCell.h
//  ZQArbutus
//
//  Created by 陈大鹰 on 19/03/2017.
//  Copyright © 2017 ZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZQPublicPhotoCellDelegate <NSObject>

@required
- (void)delegatePhotoFromCell: (UICollectionViewCell *)cell;

@end

@interface ZQPublicPhotoCell : UICollectionViewCell

@property (weak, nonatomic) id<ZQPublicPhotoCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
- (IBAction)deletePhoto:(UIButton *)sender;

@end
