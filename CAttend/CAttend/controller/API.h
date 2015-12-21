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
//  API.h
//  CAttend
//
//  Created by 卢棪 on 12/13/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "Bee.h"
#import "MetaData.h"

#pragma mark -

@interface API : BeeController

#pragma mark - 用户登录
AS_MESSAGE( Login )

#pragma mark - 课程请求
AS_MESSAGE( CourseInfo )

#pragma mark - 获取学生列表
AS_MESSAGE( StudentsOfClass )

#pragma mark - 学生点名
AS_MESSAGE( Attend )
@end
