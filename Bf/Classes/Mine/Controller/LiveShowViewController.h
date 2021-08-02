//
//  LiveShowViewController.h
//  LiveVideoCoreDemo
//
//  Created by Alex.Shi on 16/3/2.
//  Copyright © 2016年 com.Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "CCPush/CCPushUtil.h"
#import "ASValueTrackingSlider.h"

@interface LiveShowViewController : UIViewController< ASValueTrackingSliderDataSource, ASValueTrackingSliderDelegate,CCPushUtilDelegate,UIAlertViewDelegate>

//横竖屏推流
@property (nonatomic, assign) Boolean                       IsHorizontal;
/*房间id*/
@property (nonatomic,copy) NSString *roomId;
@end
