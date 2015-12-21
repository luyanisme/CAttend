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
//  PersonalCenterBoard_iPhone.h
//  CAttend
//
//  Created by 卢棪 on 12/13/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "Bee.h"

#pragma mark -

@interface StudentCenterBoard_iPhone : BeeUIBoard

@property (nonatomic, strong) USERINFO *userInfo;

AS_OUTLET(BeeUIScrollView, list)

@end
