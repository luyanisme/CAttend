//
//	 ______    ______    ______    
//	/\  __ \  /\  ___\  /\  ___\   
//	\ \  __<  \ \  __\_ \ \  __\_ 
//	 \ \_____\ \ \_____\ \ \_____\ 
//	  \/_____/  \/_____/  \/_____/ 
//
//	Powered by BeeFramework
//
//
//  API.m
//  CAttend
//
//  Created by 卢棪 on 12/13/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "API.h"
#import "ServerConfig.h"
#import "Public.h"

#pragma mark -

@implementation API

#pragma mark - POST user/login
DEF_MESSAGE_( Login, msg )
{
    if ( msg.sending )
    {
        NSString* userName = msg.GET_INPUT(@"userName");
        NSString* password = msg.GET_INPUT(@"password");
        NSString* memberType = msg.GET_INPUT(@"memberType");
        
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND(@"username",userName);
        requestBody.APPEND(@"password",password);
        requestBody.APPEND(@"memberType",memberType);
        
        NSString* url = @"cattend/login";
        NSString * requestURI = @"";
        
        requestURI = [NSString stringWithFormat:@"%@%@", [ServerConfig sharedInstance].url, url];
        
        NSData* data = [NSJSONSerialization dataWithJSONObject:[requestBody objectToDictionary] options:NSJSONWritingPrettyPrinted error:nil];
        
        msg.HTTP_POST( requestURI ).HEADER(@"Content-Type", @"application/json").BODY(data);
        
    }
    else if ( msg.succeed )
    {
        
        NSDictionary* response = msg.responseJSONDictionary;
        NSNumber* resultCode = [response objectAtPath:@"resultCode"];
        NSString* resultMessage = [response objectAtPath:@"resultMessage"];
        USERINFO* userInfo =  [USERINFO objectFromDictionary:[response dictAtPath:@"rows"]];
        
        
        msg.OUTPUT( @"resultCode", resultCode );
        msg.OUTPUT( @"resultMessage", resultMessage );
        msg.OUTPUT( @"userInfo", userInfo );
    }
    else if ( msg.failed )
    {
        NSLog(@"登录失败");
    }
    else if ( msg.cancelled )
    {
    }
}

#pragma mark -- POST CourseInfo
DEF_MESSAGE_(CourseInfo, msg)
{
    if(msg.sending)
    {
        NSString *identifyCode = msg.GET_INPUT(@"identifyCode");
        NSString *memberType = msg.GET_INPUT(@"memberType");
        
        NSString* url = [NSString stringWithFormat:@"cattend/%@Schedule/", memberType];
        NSString * requestURI = [NSString stringWithFormat:@"%@%@%@/", [ServerConfig sharedInstance].url, url,identifyCode];
        msg.HTTP_GET( requestURI ).HEADER(@"Content-Type", @"application/json");
    }
    else if (msg.succeed)
    {
        NSLog(@"获取课程信息成功");
        NSDictionary* response = msg.responseJSONDictionary;
        NSNumber* resultCode = [response objectAtPath:@"resultCode"];
        NSString* resultMessage = [response objectAtPath:@"resultMessage"];
        NSArray* courseList = [COURSEINFO objectsFromArray:[response objectAtPath:@"rows"]];
        
        msg.OUTPUT(@"resultCode",resultCode);
        msg.OUTPUT(@"resultMessage",resultMessage);
        msg.OUTPUT(@"courseList",courseList);
    }
    else if (msg.failed)
    {
        
    }
    else if (msg.cancelled)
    {
        
    }
}

#pragma mark -- POST StudentsOfClass
DEF_MESSAGE_(StudentsOfClass, msg)
{
    if(msg.sending)
    {
        NSString* url = @"cattend/scheduleStudentList";
        NSString *requestURI = [NSString stringWithFormat:@"%@%@/%@/%@/",[ServerConfig sharedInstance].url, url,msg.GET_INPUT(@"scheduleid"),[Public obtainCurrentDate]];
        msg.HTTP_GET( requestURI ).HEADER(@"Content-Type", @"application/json");
    }
    else if (msg.succeed)
    {
        NSLog(@"获取学生列表成功");
        NSDictionary* response = msg.responseJSONDictionary;
        NSNumber* resultCode = [response objectAtPath:@"resultCode"];
        NSString* resultMessage = [response objectAtPath:@"resultMessage"];
        NSArray* studentList = [USERINFO objectsFromArray:[response objectAtPath:@"rows"]];
        
        msg.OUTPUT(@"resultCode",resultCode);
        msg.OUTPUT(@"resultMessage",resultMessage);
        msg.OUTPUT(@"studentList",studentList);
    }
    else if (msg.failed)
    {
        
    }
    else if (msg.cancelled)
    {
        
    }
}

#pragma mark - POST Attend
DEF_MESSAGE_( Attend, msg )
{
    if ( msg.sending )
    {
        NSString* username = msg.GET_INPUT(@"username");
        NSString* scheduleId = msg.GET_INPUT(@"scheduleId");
        
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND(@"username",username);
        requestBody.APPEND(@"scheduleId",scheduleId);
        requestBody.APPEND(@"date",[Public obtainCurrentDate]);
        
        NSString* url = @"cattend/checking";
        NSString * requestURI = @"";
        
        requestURI = [NSString stringWithFormat:@"%@%@", [ServerConfig sharedInstance].url, url];
        
        NSData* data = [NSJSONSerialization dataWithJSONObject:[requestBody objectToDictionary] options:NSJSONWritingPrettyPrinted error:nil];
        
        msg.HTTP_POST( requestURI ).HEADER(@"Content-Type", @"application/json").BODY(data);
        
    }
    else if ( msg.succeed )
    {
        
        NSDictionary* response = msg.responseJSONDictionary;
        NSNumber* resultCode = [response objectAtPath:@"resultCode"];
        NSString* resultMessage = [response objectAtPath:@"resultMessage"];
        
        msg.OUTPUT( @"resultCode", resultCode );
        msg.OUTPUT( @"resultMessage", resultMessage );
    }
    else if ( msg.failed )
    {
        NSLog(@"登录失败");
    }
    else if ( msg.cancelled )
    {
    }
}

@end
