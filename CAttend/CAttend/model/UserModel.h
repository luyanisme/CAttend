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
//  UserModel.h
//  CAttend
//
//  Created by 卢棪 on 12/11/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "Bee_OnceViewModel.h"

#pragma mark -

@interface UserModel : BeeOnceViewModel

AS_SINGLETON(UserModel)

- (void)login:(NSString *)userName password:(NSString *)password memberType:(NSString *)memberType;

@property (nonatomic, strong) USERINFO *userInfo;
@property (nonatomic, strong) NSString *memberType;

@end