//
//  BFCourseDetailsTeachers.h
//  NewTest
//
//  Created by 春晓 on 2017/11/30.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, TeacherRole) {
    TeacherRole_Give,   // 授课老师
    TeacherRole_Help    // 授课老师
};
@interface BFCourseDetailsTeachers : NSObject

// 老师角色
@property (nonatomic , assign) TeacherRole teacherRole;

// 老师简介
@property (nonatomic , strong) NSString *iintr;
// 老师Id
@property (nonatomic , assign) NSInteger uid;
// 老师简介
@property (nonatomic , strong) NSString *iphoto;


//
@property (nonatomic , assign) NSInteger ablocked;
//
@property (nonatomic , assign) NSInteger cendtime;
//
@property (nonatomic , assign) NSInteger classid;
// 老师简介
@property (nonatomic , strong) NSString *cscover;;
//
@property (nonatomic , assign) NSInteger csid;
//
@property (nonatomic , assign) NSInteger cskey;
//
@property (nonatomic , assign) NSInteger csnum;
//
@property (nonatomic , assign) NSInteger cstarttime;
//
@property (nonatomic , strong) NSString *cstitle;
//
@property (nonatomic , assign) NSInteger csvideo;
// 老师简介
@property (nonatomic , strong) NSString *inickname;
//
@property (nonatomic , assign) NSInteger rcredit;

+ (instancetype)initWithDict:(NSDictionary *)dict;

@end
