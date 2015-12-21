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
//  SudentsOfClassBoard_iPhone.h
//  CAttend
//
//  Created by 卢棪 on 12/14/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "Bee.h"

#pragma mark -

@interface StudentsOfClassBoard_iPhone : BeeUIBoard

AS_OUTLET(BeeUIScrollView, list)

AS_MODEL(StudentsListModel, studentsListModel)

@property (nonatomic, strong) NSString *scheduleId;
@end
