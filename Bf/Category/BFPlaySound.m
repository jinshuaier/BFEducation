//
//  BFPlaySound.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/7.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFPlaySound.h"

@implementation BFPlaySound
-(id)initForPlayingVibrate {
    self = [super init];
    if (self) {
        soundID = kSystemSoundID_Vibrate;
    }
    return self;
}

-(id)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type {
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] pathForResource:resourceName ofType:type];
        if (path) {
            SystemSoundID theSoundID;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)([NSURL fileURLWithPath:path]), &theSoundID);
            if (error == kAudioServicesNoError) {
                soundID = theSoundID;
            }
            else {
                NSLog(@"failed to create sound");
            }
        }
    }
    return self;
}

-(void)play {
    AudioServicesPlaySystemSound(soundID);
}

-(void)dealloc {
    AudioServicesDisposeSystemSoundID(soundID);
}
@end
