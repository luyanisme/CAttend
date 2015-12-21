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
//  PersonalCenterBoard_iPhone.m
//  CAttend
//
//  Created by 卢棪 on 12/13/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "StudentCenterBoard_iPhone.h"
#import "StudentCenterBoardCell_iPhone.h"

#pragma mark -

@interface StudentCenterBoard_iPhone()
{
	//<#@private var#>
}
@end

@implementation StudentCenterBoard_iPhone

DEF_OUTLET(BeeUIScrollView, list)

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

- (void)load
{
}

- (void)unload
{
}

#pragma mark - Signal

ON_CREATE_VIEWS( signal )
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationBarTitle = @"个人信息";
    self.navigationBarLeft  = [UIImage imageNamed:@"navigation-back.png"];
    
    self.list.animationDuration = 0.25;
    self.list.lineCount = 1;
    
    self.list.whenReloading = ^{
        self.list.total = 1;
        BeeUIScrollItem *item = self.list.items[0];
        item.size = CGSizeAuto;
        item.clazz = [StudentCenterBoardCell_iPhone class];
        item.data = [UserModel sharedInstance].userInfo;
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
}

ON_SIGNAL3(StudentCenterBoardCell_iPhone, quit, signal){
    [bee.ui.router open:@"SignBoard_iPhone" animated:YES];
    [bee.ui.router close:@"MainBoard_iPhone"];
}
@end
