//
//  BFPlaySound.h
//  Bf
//
//  Created by 陈大鹰 on 2017/12/7.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
@interface BFPlaySound : NSObject
{
    SystemSoundID soundID;
}
//为播放震动效果初始化
-(id)initForPlayingVibrate;
//为播放系统音效初始化(无需提供音频文件)  resourceName系统音效名称  type系统音效类型
-(id)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type;
//播放音效
-(void)play;
@end
