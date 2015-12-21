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
//  StudentsListModel.m
//  CAttend
//
//  Created by 卢棪 on 12/18/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "StudentsListModel.h"

#pragma mark -

@implementation StudentsListModel

- (void)load
{
}

- (void)unload
{
}

- (void)obtainStudents:(NSString *)scheduleid{
    self.CANCEL_MSG(API.StudentsOfClass);
    self.MSG(API.StudentsOfClass)
    .INPUT(@"scheduleid",scheduleid);
}

#pragma mark - 登录信息返回
ON_MESSAGE3(API, StudentsOfClass, msg)
{
    if (msg.sending)
    {
        
    }
    else if (msg.succeed)
    {
        NSNumber* resultCode = msg.GET_OUTPUT(@"resultCode");
        NSString* resultMessage = msg.GET_OUTPUT(@"resultMessage");
        self.studentList = msg.GET_OUTPUT(@"studentList");
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