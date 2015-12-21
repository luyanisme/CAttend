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
//  AttendModel.h
//  CAttend
//
//  Created by 卢棪 on 12/18/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "Bee_OnceViewModel.h"

#pragma mark -

@interface AttendModel : BeeOnceViewModel

@property (nonatomic, strong) NSString *attendSuc;//签到成功提示
- (void)attend:(NSString*)userId scheduleId:(NSString *)scheduleId;

@end