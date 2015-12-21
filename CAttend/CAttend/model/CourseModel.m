//
//   ______    ______    ______
//  /\  __ \  /\  ___\  /\  ___\
//  \ \  __<  \ \  __\_ \ \  __\_
//   \ \_____\ \ \_____\ \ \_____\
//    \/_____/  \/_____/  \/_____/
//
//  Powered by BeeFramework
//
//
//  CourseModel.m
//  CAttend
//
//  Created by 卢棪 on 12/14/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "CourseModel.h"

#pragma mark -

@implementation CourseModel

- (void)load
{
}

- (void)unload
{
}

#pragma mark -

- (void)obtainCourse:(NSString*)identifyCode{
    self.CANCEL_MSG(API.CourseInfo);
    self.MSG(API.CourseInfo)
    .INPUT(@"identifyCode",identifyCode)
    .INPUT(@"memberType",[UserModel sharedInstance].memberType);
}

#pragma mark - 登录信息返回
ON_MESSAGE3(API, CourseInfo, msg)
{
    if (msg.sending)
    {
        
    }
    else if (msg.succeed)
    {
        NSNumber* resultCode = msg.GET_OUTPUT(@"resultCode");
        NSString* resultMessage = msg.GET_OUTPUT(@"resultMessage");
        self.courseList = msg.GET_OUTPUT(@"courseList");
        if(0 != resultCode.intValue)
        {
            msg.errorDesc = resultMessage;
            msg.failed = YES;
            return;
        }
        
    }
    else if (msg.failed)
    {
        //要携带错误信息到页面展示
        if(0 == msg.errorDesc.length)
        {
            msg.errorDesc = @"网络异常";
        }
    }
}

@end