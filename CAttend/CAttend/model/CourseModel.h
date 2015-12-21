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
//  CourseModel.h
//  CAttend
//
//  Created by 卢棪 on 12/14/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "Bee_OnceViewModel.h"

#pragma mark -

@interface CourseModel : BeeOnceViewModel

@property (nonatomic, strong) NSMutableArray *courseList;

- (void)obtainCourse:(NSString*)identifyCode;

@end