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
//  CourseInfoBoard_iPhone.m
//  CAttend
//
//  Created by 卢棪 on 12/14/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "CourseInfoBoard_iPhone.h"
#import "CourseInfoBoardCell_iPhone.h"
#import "LBXScanViewController.h"

#pragma mark -

@interface CourseInfoBoard_iPhone()
{
	//<#@private var#>
}
@end

@implementation CourseInfoBoard_iPhone

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
    
    self.navigationBarTitle = @"课程信息";
    self.navigationBarLeft = [UIImage imageNamed:@"navigation-back.png"];
    
    self.list.animationDuration = 0.25;
    self.list.lineCount = 1;
    
    self.list.whenReloading = ^{
        self.list.total = 1;
        BeeUIScrollItem *item = self.list.items[0];
        item.size = CGSizeAuto;
        item.clazz = [CourseInfoBoardCell_iPhone class];
        item.data = self.courseInfo;
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

/*
 *点击课程名
 */
ON_SIGNAL3(CourseInfoBoardCell_iPhone, tap_name, signal){

}

/*
 *点击教师名
 */
ON_SIGNAL3(CourseInfoBoardCell_iPhone, tap_teacher, signal){
    
}

/*
 *点击老师电话
 */
ON_SIGNAL3(CourseInfoBoardCell_iPhone, tap_teacherPhone, signal){
    
}

/*
 *点击办公室
 */
ON_SIGNAL3(CourseInfoBoardCell_iPhone, tap_office, signal){
    
}

/*
 *点击教材
 */
ON_SIGNAL3(CourseInfoBoardCell_iPhone, tap_courseBook, signal){
    
}

/*
 *点击签到
 */
ON_SIGNAL3(CourseInfoBoardCell_iPhone, attend, signal){
        //设置扫码区域参数
        LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
        style.centerUpOffset = 44;
        style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_On;
        style.photoframeLineW = 6;
        style.photoframeAngleW = 24;
        style.photoframeAngleH = 24;
        style.isNeedShowRetangle = YES;
    
        style.anmiationStyle = LBXScanViewAnimationStyle_NetGrid;
    
    
        //使用的支付宝里面网格图片
        UIImage *imgPartNet = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_part_net"];
    
        style.animationImage = imgPartNet;
        
        [self openScanVCWithStyle:style];
}

- (void)openScanVCWithStyle:(LBXScanViewStyle*)style
{
    LBXScanViewController *vc = [LBXScanViewController new];
    vc.style = style;
    vc.whenAttend = ^{
        BeeUIScrollItem *item = self.list.items[0];
        CourseInfoBoardCell_iPhone *cell = (CourseInfoBoardCell_iPhone*)item.view;
        cell.attend.backgroundColor = [UIColor grayColor];
        [cell.attend setTitle:@"已签到"];
        cell.attend.enabled = NO;
    };
    vc.title = @"签到";
    //vc.isOpenInterestRect = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
