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
//  SignBoard_iPhone.m
//  CAttend
//
//  Created by 卢棪 on 12/10/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "SignBoard_iPhone.h"
#import "AppBoard_iPhone.h"
#import "MainBoard_iPhone.h"
#pragma mark -

@interface SignBoard_iPhone()
{
    BOOL _isStudent;
}
@end

@implementation SignBoard_iPhone

DEF_MODEL(UserModel, userModel)

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

- (void)load
{
    [UserModel modelWithObserver:self];
}

- (void)unload
{
    [self.userModel removeAllObservers];
}

#pragma mark - Signal

ON_CREATE_VIEWS( signal )
{
    self.view.backgroundColor = [UIColor whiteColor];
}

ON_DELETE_VIEWS( signal )
{
}

ON_LAYOUT_VIEWS( signal )
{
}

ON_WILL_APPEAR( signal )
{
    //改变状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

ON_DID_APPEAR( signal )
{
}

ON_WILL_DISAPPEAR( signal )
{
    [self.view endEditing:YES];
}

ON_DID_DISAPPEAR( signal )
{
    //改变状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

ON_SIGNAL3( BeeUINavigationBar, LEFT_TOUCHED, signal )
{
}

ON_SIGNAL3( BeeUINavigationBar, RIGHT_TOUCHED, signal )
{
}

ON_SIGNAL3(SignBoard_iPhone, sign, signal){
    
    NSString * userName = $(@"userName").text.trim;
    NSString * password = $(@"password").text.trim;

    if (userName.length == 0) {
        [self presentMessageTips:@"请输入用户名"];
        return;
    }
    
    if (password.length == 0) {
        [self presentMessageTips:@"请输入密码"];
        return;
    }
    
    [[UserModel sharedInstance] login:userName password:password memberType:_isStudent ? @"student" : @"teacher"];
}

ON_SIGNAL3(SignBoard_iPhone, chooseStudent, signal){
    if (!_isStudent) {
        $(@"#choose_teacher").ATTR(@"image",@"url(unchoose_circle.png)");
        $(@"#choose_student").ATTR(@"image",@"url(choosed_circle.png)");
        _isStudent = YES;
    }
}

ON_SIGNAL3(SignBoard_iPhone, chooseTeacher, signal){
    if (_isStudent) {
        $(@"#choose_student").ATTR(@"image",@"url(unchoose_circle.png)");
        $(@"#choose_teacher").ATTR(@"image",@"url(choosed_circle.png)");
        _isStudent = NO;
    }
}

ON_MESSAGE3(API, Login, msg)
{
    if(msg.sending)
    {
        [bee.ui.appBoard presentLoadingTips:@"登录中..."];
    }
    
    if (msg.succeed)
    {
        [bee.ui.appBoard dismissTips];
        [bee.ui.router map:@"MainBoard_iPhone" toClass:[MainBoard_iPhone class]];
        [bee.ui.router open:@"MainBoard_iPhone" animated:YES];
    }
    else if (msg.failed)
    {
        [self presentFailureTips:msg.errorDesc];
    }
}

@end
