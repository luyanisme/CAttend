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
//  PersonalCenterBoardCell_iPhone.m
//  CAttend
//
//  Created by 卢棪 on 12/13/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "StudentCenterBoardCell_iPhone.h"

#pragma mark -

@implementation StudentCenterBoardCell_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

- (void)load
{
}

- (void)unload
{
}

- (void)dataDidChanged
{
    // TODO: fill data
    if (self.data) {
        USERINFO *userInfo = self.data;
        $(@"#name").DATA(userInfo.realName);
        $(@"#idCode").DATA(userInfo.username);
        $(@"#sex").DATA([userInfo.sex isEqualToString:@"male"] ? @"男" : @"女");
        $(@"#birth").DATA(userInfo.birth);
        $(@"#subject").DATA(userInfo.subject);
        $(@"#className").DATA(userInfo.className);
        $(@"#phoneNum").DATA(userInfo.phoneNum);
    }
}

- (void)layoutDidFinish
{
    // TODO: custom layout here
}

@end
