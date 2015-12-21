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
//  SudentsOfClassBoard_iPhone.m
//  CAttend
//
//  Created by 卢棪 on 12/14/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "StudentsOfClassBoard_iPhone.h"
#import "StudentsOfClassBoardCell_iPhone.h"
#import "MyQRViewController.h"

#pragma mark -

@interface StudentsOfClassBoard_iPhone()
{
	//<#@private var#>
    NSMutableArray *_studentList;
}
@end

@implementation StudentsOfClassBoard_iPhone

DEF_MODEL(StudentsListModel, studentsListModel)
DEF_OUTLET(BeeUIScrollView, list)

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

- (void)load
{
    _studentList = [NSMutableArray array];
    self.studentsListModel = [StudentsListModel modelWithObserver:self];
}

- (void)unload
{
    [self.studentsListModel removeObserver:self];
}

#pragma mark - Signal

ON_CREATE_VIEWS( signal )
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationBarTitle = @"学生列表";
    self.navigationBarLeft  = [UIImage imageNamed:@"navigation-back.png"];
    self.navigationBarRight = @"点名";
    
    self.list.animationDuration = 0.25;
    self.list.lineCount = 1;
    
    self.list.whenReloading = ^{
        self.list.total = _studentList.count;
        for (int i=0; i<self.list.total; i++) {
            BeeUIScrollItem *item = self.list.items[i];
            item.size = CGSizeAuto;
            item.clazz = [StudentsOfClassBoardCell_iPhone class];
            item.data = _studentList[i];
        }
        
    };

}

ON_DELETE_VIEWS( signal )
{
}

ON_LAYOUT_VIEWS( signal )
{
}

ON_WILL_APPEAR( signal )
{
    [self.studentsListModel obtainStudents:self.scheduleId];
}

ON_DID_APPEAR( signal )
{
}

ON_WILL_DISAPPEAR( signal )
{
}

ON_DID_DISAPPEAR( signal )
{
}

ON_SIGNAL3( BeeUINavigationBar, LEFT_TOUCHED, signal )
{
    [self.navigationController popViewControllerAnimated:YES];
}

ON_SIGNAL3( BeeUINavigationBar, RIGHT_TOUCHED, signal )
{
    MyQRViewController *qrvc = [[MyQRViewController alloc]init];
    qrvc.scheduleId = self.scheduleId;
    qrvc.title = @"点名";
    [self.navigationController pushViewController:qrvc animated:YES];
}

ON_MESSAGE3(API, StudentsOfClass, msg)
{
    if(msg.sending)
    {
        [self presentLoadingTips:@"等待中..."];
    }
    
    if (msg.succeed)
    {
        _studentList = self.studentsListModel.studentList;
        [self.list reloadData];
        [self dismissTips];
    }
    else if (msg.failed)
    {
        [self presentFailureTips:msg.errorDesc];
    }
}

@end
