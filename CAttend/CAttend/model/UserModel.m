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
//  UserModel.m
//  CAttend
//
//  Created by 卢棪 on 12/11/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "UserModel.h"

#pragma mark -

@implementation UserModel

DEF_SINGLETON(UserModel)

- (void)load
{
}

- (void)unload
{
}

#pragma mark -

- (void)login:(NSString *)userName password:(NSString *)password memberType:(NSString *)memberType{
    self.CANCEL_MSG(API.Login);
    self.MSG(API.Login).INPUT(@"userName",userName).INPUT(@"password",password).INPUT(@"memberType",memberType);
    self.memberType = memberType;
}

#pragma mark - 登录信息返回
ON_MESSAGE3(API, Login, msg)
{
    if (msg.sending)
    {
        
    }
    else if (msg.succeed)
    {
        NSNumber* resultCode = msg.GET_OUTPUT(@"resultCode");
        NSString* resultMessage = msg.GET_OUTPUT(@"resultMessage");
        
        if(0 != resultCode.intValue)
        {
            msg.errorDesc = resultMessage;
            msg.failed = YES;
            return;
        }
        
        self.userInfo = msg.GET_OUTPUT(@"userInfo");
        
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