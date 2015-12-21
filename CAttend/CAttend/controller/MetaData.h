//
//  MetaData.h
//  CAttend
//
//  Created by 卢棪 on 12/11/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class USERINFO;
@class COURSEINFO;

@interface USERINFO : NSObject

@property (nonatomic, strong) NSString *realName;//姓名
@property (nonatomic, strong) NSString *sex;//性别
@property (nonatomic, strong) NSString *birth;//出生年月
@property (nonatomic, strong) NSString *username;//账号
@property (nonatomic, strong) NSString *subject;//学生专业
@property (nonatomic, strong) NSString *className;//所在班级
@property (nonatomic, strong) NSString *phoneNum;//电话号码
@property (nonatomic, strong) NSNumber *isAttend;//是否已到

@end

@interface COURSEINFO : NSObject

@property (strong,nonatomic) NSString *address;//地址
@property (strong,nonatomic) NSString *weekday;//礼拜
@property (strong,nonatomic) NSString *teacherName;//教师名称
@property (strong,nonatomic) NSString *lessonName;//课程名称
@property (strong,nonatomic) NSString *startWeek;//开始周
@property (strong,nonatomic) NSString *startClass;//开始时间
@property (strong,nonatomic) NSString *classLength;//课程
@property (strong,nonatomic) NSString *endWeek;//结束周
@property (strong,nonatomic) NSString *scheduleId;//课程id

@end