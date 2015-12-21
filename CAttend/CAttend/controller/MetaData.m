//
//  MetaData.m
//  CAttend
//
//  Created by 卢棪 on 12/11/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "MetaData.h"

@implementation USERINFO

@synthesize realName = _realName;
@synthesize sex = _sex;
@synthesize birth = _birth;
@synthesize username = _username;
@synthesize subject = _subject;
@synthesize className = _className;
@synthesize phoneNum = _phoneNum;
@synthesize isAttend = _isAttend;

@end

@implementation COURSEINFO

@synthesize address = _address;
@synthesize weekday = _weekday;
@synthesize teacherName = _teacherName;
@synthesize lessonName = _lessonName;
@synthesize startWeek = _startWeek;
@synthesize startClass = _startClass;
@synthesize classLength = _classLength;
@synthesize endWeek = _endWeek;
@synthesize scheduleId = _scheduleId;

@end