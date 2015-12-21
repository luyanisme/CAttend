
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
//  AttendModel.m
//  CAttend
//
//  Created by 卢棪 on 12/18/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "AttendModel.h"

#pragma mark -

@implementation AttendModel

- (void)load
{
}

- (void)unload
{
}

- (void)attend:(NSString*)username scheduleId:(NSString *)scheduleId{
    self.CANCEL_MSG(API.Attend);
    self.MSG(API.Attend)
    .INPUT(@"username",username)
    .INPUT(@"scheduleId",scheduleId);
}

#pragma mark - 登录信息返回
ON_MESSAGE3(API, Attend, msg)
{
    if (msg.sending)
    {
        
    }
    else if (msg.succeed)
    {
        NSNumber* resultCode = msg.GET_OUTPUT(@"resultCode");
        NSString* resultMessage = msg.GET_OUTPUT(@"resultMessage");
        self.attendSuc = resultMessage;
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