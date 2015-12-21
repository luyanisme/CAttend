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
//  SudentsOfClassBoardCell_iPhone.m
//  CAttend
//
//  Created by 卢棪 on 12/14/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "StudentsOfClassBoardCell_iPhone.h"

#pragma mark -

@implementation StudentsOfClassBoardCell_iPhone

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
        $(@"#class").DATA(userInfo.className);
        $(@"#identifyCode").DATA(userInfo.username);
        
        if ([userInfo.isAttend boolValue]) {
            $(@"#name").ATTR(@"color",@"#0F6B19");
            $(@"#class").ATTR(@"color",@"#0F6B19");
            $(@"#identifyCode").ATTR(@"color",@"#0F6B19");
        } else {
            $(@"#name").ATTR(@"color",@"#A4A4A4");
            $(@"#class").ATTR(@"color",@"#A4A4A4");
            $(@"#identifyCode").ATTR(@"color",@"#A4A4A4");
        }
    }
}

- (void)layoutDidFinish
{
    // TODO: custom layout here
}

@end
