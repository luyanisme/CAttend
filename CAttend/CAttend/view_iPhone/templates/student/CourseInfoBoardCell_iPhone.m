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
//  CourseInfoBoardCell_iPhone.m
//  CAttend
//
//  Created by 卢棪 on 12/14/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "CourseInfoBoardCell_iPhone.h"

#pragma mark -

@implementation CourseInfoBoardCell_iPhone
DEF_OUTLET(BeeUIButton, attend)
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
        COURSEINFO *courseInfo = self.data;
        $(@"#name").DATA(courseInfo.lessonName);
        $(@"#teacher").DATA(courseInfo.teacherName);
        $(@"#start_end").DATA([NSString stringWithFormat:@"从第%@周到第%@周",courseInfo.startWeek,courseInfo.endWeek]);
    }
}

- (void)layoutDidFinish
{
    // TODO: custom layout here
}

@end
