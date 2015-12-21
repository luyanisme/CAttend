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
//  StudentsListModel.h
//  CAttend
//
//  Created by 卢棪 on 12/18/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "Bee_OnceViewModel.h"

#pragma mark -

@interface StudentsListModel : BeeOnceViewModel

@property (nonatomic, strong) NSMutableArray *studentList;

- (void)obtainStudents:(NSString *)scheduleid;

@end