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
//  AppBoard_iPhone.m
//  CAttend
//
//  Created by 卢棪 on 12/10/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "AppBoard_iPhone.h"
#import "SignBoard_iPhone.h"
#import "MainBoard_iPhone.h"

#pragma mark -

DEF_UI(AppBoard_iPhone, appBoard)

@implementation AppBoard_iPhone

DEF_SINGLETON( AppBoard_iPhone )

- (void)load
{
}

- (void)unload
{
}

#pragma mark Signal

ON_CREATE_VIEWS( signal )
{
    [self.view addSubview:bee.ui.router.view];
    
    //映射stack map
    [bee.ui.router map:@"MainBoard_iPhone" toClass:[MainBoard_iPhone class]];
    [bee.ui.router map:@"SignBoard_iPhone" toClass:[SignBoard_iPhone class]];
    
    [bee.ui.router open:@"SignBoard_iPhone"];
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
}

ON_SIGNAL3( BeeUINavigationBar, RIGHT_TOUCHED, signal )
{
}

@end
