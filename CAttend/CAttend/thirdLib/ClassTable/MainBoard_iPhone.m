//
//  CTDayViewController.m
//  collectionViewTest
//
//  Created by 钟由 on 14-9-11.
//  Copyright (c) 2014年 flywarrior24@163.com. All rights reserved.
//

#import "MainBoard_iPhone.h"
#import "CTDayViewCell.h"
#import "Public.h"
#import "StudentCenterBoard_iPhone.h"
#import "TeacherCenterBoard_iPhone.h"
#import "CourseInfoBoard_iPhone.h"
#import "StudentsOfClassBoard_iPhone.h"

@interface MainBoard_iPhone ()

@property (nonatomic, strong) NSMutableArray *mondayCourseArray;
@property (nonatomic, strong) NSMutableArray *tuesdayCourseArray;
@property (nonatomic, strong) NSMutableArray *wednesdayCourseArray;
@property (nonatomic, strong) NSMutableArray *thursedayCourseArray;
@property (nonatomic, strong) NSMutableArray *fridayCourseArray;
@property (nonatomic, strong) NSMutableArray *saturdayCourseArray;
@property (nonatomic, strong) NSMutableArray *sundayCourseArray;
@property (nonatomic, assign) NSInteger monCourseArrayPosition;
@property (nonatomic, assign) NSInteger tuesCourseArrayPosition;
@property (nonatomic, assign) NSInteger wednesCourseArrayPosition;
@property (nonatomic, assign) NSInteger thurseCourseArrayPosition;
@property (nonatomic, assign) NSInteger friCourseArrayPosition;
@property (nonatomic, assign) NSInteger saturCourseArrayPosition;
@property (nonatomic, assign) NSInteger sunCourseArrayPosition;
@property (nonatomic, assign) NSInteger monCourseCount;
@property (nonatomic, assign) NSInteger tuesCourseCount;
@property (nonatomic, assign) NSInteger wednesCourseCount;
@property (nonatomic, assign) NSInteger thurseCourseCount;
@property (nonatomic, assign) NSInteger friCourseCount;
@property (nonatomic, assign) NSInteger saturCourseCount;
@property (nonatomic, assign) NSInteger sunCourseCount;
@property (nonatomic, strong) NSString * indicator;
@end



@implementation MainBoard_iPhone

DEF_MODEL(CourseModel, courseModel)

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

ON_CREATE_VIEWS( signal )
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBarShown = YES;
    self.navigationBarTitle = [Public obtainCurrentDate];
    self.navigationBarRight = [UIImage imageNamed:@"more_white.png"];
    _myView = [[UIView alloc]initWithFrame:self.bounds];
    _myView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_myView];
    self.mondayCourseArray = [[NSMutableArray alloc] init];
    self.tuesdayCourseArray = [[NSMutableArray alloc] init];
    self.wednesdayCourseArray = [[NSMutableArray alloc]init];
    self.thursedayCourseArray = [[NSMutableArray alloc] init];
    self.fridayCourseArray = [[NSMutableArray alloc] init];
    self.saturdayCourseArray = [[NSMutableArray alloc] init];
    self.sundayCourseArray = [[NSMutableArray alloc] init];
    [self _init];

}

- (void)_init{
    
    self.courseModel = [CourseModel modelWithObserver:self];
    self.data = [[CTCollectionViewDataSource alloc] init];
    //初始化
    self.monCourseArrayPosition = 0;
    self.tuesCourseArrayPosition = 0;
    self.wednesCourseArrayPosition = 0;
    self.tuesCourseArrayPosition = 0;
    self.thurseCourseArrayPosition = 0;
    self.friCourseArrayPosition = 0;
    self.saturCourseArrayPosition = 0;
    self.sunCourseArrayPosition = 0;
    self.monCourseCount = 0;
    self.tuesCourseCount = 0;
    self.wednesCourseCount = 0;
    self.friCourseCount = 0;
    self.thurseCourseCount = 0;
    self.saturCourseCount = 0;
    self.sunCourseCount = 0;
//    [self initCourseArray];
//    [self initCourseArray2];
    //设置backgroundScrollView在window中的大小
    self.backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, HEADER_DAY_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - HEADER_DAY_HEIGHT-64)];
    
    //设置backgroundScrollView滑动范围大小
    self.backgroundScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 7, self.backgroundScrollView.frame.size.height);
    self.backgroundScrollView.showsHorizontalScrollIndicator = NO;
    self.backgroundScrollView.showsVerticalScrollIndicator = NO;
    self.backgroundScrollView.delegate = self;
    self.backgroundScrollView.pagingEnabled = YES;
    self.backgroundScrollView.bounces = NO;
    [self.view addSubview:self.backgroundScrollView];
    
    //添加Indicator(它相对day的起点,X为5,Y为27,宽为day宽-2倍X,高为day高-27)
    self.dayIndicator = [[UIView alloc] initWithFrame:CGRectMake(INDICATOR_INDEX, HEADER_DAY_HEIGHT - 3,  HEADER_DAY_WIDTH - 2*INDICATOR_INDEX , 3)];
    self.dayIndicator.backgroundColor = [UIColor colorWithRed:0.06f green:0.42f blue:0.10f alpha:1.00f];
    [self.view addSubview:self.dayIndicator];
    
    //在backgroundScrollView的top添加dayLabel(用于显示每天)
    NSArray *weekdayText = @[@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日"];
    for (NSInteger i = 0; i < 7; ++i) {
        
        //添加Label显示
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(i * HEADER_DAY_WIDTH, 0, HEADER_DAY_WIDTH, HEADER_DAY_HEIGHT)];
        lab.backgroundColor = [UIColor clearColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor colorWithRed:0.06f green:0.42f blue:0.10f alpha:1.00f];
        lab.alpha = 0.8;
        lab.text = weekdayText[i];
        lab.font = [UIFont systemFontOfSize:14];
        lab.tag = DAY_LABEL_TAG_BASE + i;
        [_myView addSubview:lab];
        
        //添加Button用于点击跳转
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * HEADER_DAY_WIDTH, 0, HEADER_DAY_WIDTH, HEADER_DAY_HEIGHT);
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = DAY_BUTTON_TAG_BASE + i;
        [btn addTarget:self action:@selector(selectWeekday:) forControlEvents:UIControlEventTouchUpInside];
        [_myView addSubview:btn];
        
    }
    
    
}

- (void)initClassTable{
    for (NSInteger i = 0; i < 7; ++i) {
    //添加TableView用于显示每天的课程信息
        UITableView *classTable = [[UITableView alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, self.backgroundScrollView.frame.size.height + 5)];
        classTable.delegate = self;
        classTable.dataSource = self;
        classTable.showsHorizontalScrollIndicator = NO;
        classTable.showsVerticalScrollIndicator = NO;
        classTable.backgroundColor = [UIColor clearColor];
        classTable.tag = TABLE_VIEW_TAG_BASE + i;
        classTable.allowsSelectionDuringEditing = YES;
        //classTable.separatorStyle = UITableViewCellSelectionStyleNone;
        UINib *dayCourseInfoCellNib = [UINib nibWithNibName:@"CTDayViewCell" bundle:nil];
        [classTable registerNib:dayCourseInfoCellNib forCellReuseIdentifier:@"CTDayViewCell"];
        [self.backgroundScrollView addSubview:classTable];
    }
}

ON_SIGNAL3( BeeUINavigationBar, LEFT_TOUCHED, signal )
{
}

ON_SIGNAL3( BeeUINavigationBar, RIGHT_TOUCHED, signal )
{
    if ([[UserModel sharedInstance].memberType isEqualToString:@"student"]) {
        StudentCenterBoard_iPhone *personalBoard = [StudentCenterBoard_iPhone board];
        [self.stack pushBoard:personalBoard animated:YES];
    } else {
        TeacherCenterBoard_iPhone *personalBoard = [TeacherCenterBoard_iPhone board];
        [self.stack pushBoard:personalBoard animated:YES];
    }
    
}

ON_WILL_APPEAR(signal){
    [self currentWeekDay];
}

ON_LOAD_DATAS(signal){
    [self.courseModel obtainCourse:[UserModel sharedInstance].userInfo.username];
}

ON_MESSAGE3(API, CourseInfo, msg)
{
    if(msg.sending)
    {
        [self presentLoadingTips:@"等待中..."];
    }
    
    if (msg.succeed)
    {
        self.data.courseInfoArray = self.courseModel.courseList;
        [self initCourseArray];
        [self initCourseArray2];
        [self initClassTable];
        [self dismissTips];
    }
    else if (msg.failed)
    {
        [self presentFailureTips:msg.errorDesc];
    }
}

-(void) initCourseArray{
    self.mondayCourseArray = [[NSMutableArray alloc] init];
    self.tuesdayCourseArray = [[NSMutableArray alloc] init];
    self.wednesdayCourseArray = [[NSMutableArray alloc] init];
    self.thursedayCourseArray = [[NSMutableArray alloc] init];
    self.fridayCourseArray = [[NSMutableArray alloc] init];
    self.saturdayCourseArray = [[NSMutableArray alloc] init];
    self.sundayCourseArray = [[NSMutableArray alloc] init];
    NSArray *courseArray = [self.data sortByDayAndCourseNumber];
    for(COURSEINFO *courseinfo in courseArray){
        BOOL flag = TRUE;
        while (flag) {
        switch ([courseinfo.weekday integerValue] + 1) {
            case 1:{
                if(_monCourseArrayPosition < [courseinfo.startClass integerValue]){
                    COURSEINFO *newCourse = [[COURSEINFO alloc]init];
                    newCourse.startClass = [NSString stringWithFormat:@"%d",(int)_monCourseArrayPosition];
                    newCourse.classLength = @"2";
                    ++_monCourseArrayPosition;
                    ++_monCourseArrayPosition;
                    [self.mondayCourseArray addObject:newCourse];
                }
                else{
                    [self.mondayCourseArray addObject:courseinfo];
                    _monCourseArrayPosition = [courseinfo.startClass integerValue] + [courseinfo.classLength integerValue];
                    flag = FALSE;
                }
                break;
            }
            case 2:{
                if(_tuesCourseArrayPosition < [courseinfo.startClass integerValue]){
                    COURSEINFO *newCourse = [[COURSEINFO alloc]init];
                    newCourse.startClass = [NSString stringWithFormat:@"%d",(int)_tuesCourseArrayPosition];
                    newCourse.classLength = @"2";
                    ++_tuesCourseArrayPosition;
                    ++_tuesCourseArrayPosition;
                    [self.tuesdayCourseArray addObject:newCourse];
                }
                else{
                    [self.tuesdayCourseArray addObject:courseinfo];
                    _tuesCourseArrayPosition = [courseinfo.startClass integerValue] + [courseinfo.classLength integerValue];
                    flag = FALSE;
                }
                break;
            }
            case 3:{
                if(_wednesCourseArrayPosition < [courseinfo.startClass integerValue]){
                    COURSEINFO *newCourse = [[COURSEINFO alloc]init];
                    newCourse.startClass = [NSString stringWithFormat:@"%d",(int)_wednesCourseArrayPosition];
                    newCourse.classLength = @"2";
                    ++_wednesCourseArrayPosition;
                    ++_wednesCourseArrayPosition;
                    [self.wednesdayCourseArray addObject:newCourse];
                }
                else{
                    [self.wednesdayCourseArray addObject:courseinfo];
                    _wednesCourseArrayPosition = [courseinfo.startClass integerValue] + [courseinfo.classLength integerValue];
                    flag = FALSE;
                }
                break;
            }
            case 4:{
                if(_thurseCourseArrayPosition < [courseinfo.startClass integerValue]){
                    COURSEINFO *newCourse = [[COURSEINFO alloc]init];
                    newCourse.startClass = [NSString stringWithFormat:@"%d",(int)_thurseCourseArrayPosition];
                    newCourse.classLength = @"2";
                    ++_thurseCourseArrayPosition;
                    ++_thurseCourseArrayPosition;
                    [self.thursedayCourseArray addObject:newCourse];
                }
                else{
                    [self.thursedayCourseArray addObject:courseinfo];
                    _thurseCourseArrayPosition = [courseinfo.startClass integerValue] + [courseinfo.classLength integerValue];
                    flag = FALSE;
                }
                break;
            }
            case 5:{
                if(_friCourseArrayPosition < [courseinfo.startClass integerValue]){
                    COURSEINFO *newCourse = [[COURSEINFO alloc]init];
                    newCourse.startClass = [NSString stringWithFormat:@"%d",(int)_friCourseArrayPosition];
                    newCourse.classLength = @"2";
                    ++_friCourseArrayPosition;
                    ++_friCourseArrayPosition;
                    [self.fridayCourseArray addObject:newCourse];
                }
                else{
                    [self.fridayCourseArray addObject:courseinfo];
                    _friCourseArrayPosition = [courseinfo.startClass integerValue] + [courseinfo.classLength integerValue];
                    flag = FALSE;
                }
                break;
            }
            case 6:{
                if(_saturCourseArrayPosition < [courseinfo.startClass integerValue]){
                    COURSEINFO *newCourse = [[COURSEINFO alloc]init];
                    newCourse.startClass = [NSString stringWithFormat:@"%d",(int)_saturCourseArrayPosition];
                    newCourse.classLength = @"2";
                    ++_saturCourseArrayPosition;
                    ++_saturCourseArrayPosition;
                    [self.saturdayCourseArray addObject:newCourse];
                }
                else{
                    [self.saturdayCourseArray addObject:courseinfo];
                    _saturCourseArrayPosition = [courseinfo.startClass integerValue] + [courseinfo.classLength integerValue];
                    flag = FALSE;
                }
                break;
            }
            case 7:{
                if(_sunCourseArrayPosition < [courseinfo.startClass integerValue]){
                    COURSEINFO *newCourse = [[COURSEINFO alloc]init];
                    newCourse.startClass = [NSString stringWithFormat:@"%d",(int)_sunCourseArrayPosition];
                    newCourse.classLength = @"2";
                    ++_sunCourseArrayPosition;
                    ++_sunCourseArrayPosition;
                    [self.sundayCourseArray addObject:newCourse];
                }
                else{
                    [self.sundayCourseArray addObject:courseinfo];
                    _sunCourseArrayPosition = [courseinfo.startClass integerValue] + [courseinfo.classLength integerValue];
                    flag = FALSE;
                }
                break;
            }
        }
        }
    }
}

-(void) initCourseArray2{
    NSInteger len = COURSE_COUNT/2;
    if([self dayCourseArray:(_sundayCourseArray)]<len){
        for(NSInteger i = _sundayCourseArray.count ; i<len ;++i){
            COURSEINFO *newCourse = [[COURSEINFO alloc]init];
            newCourse.startClass = [NSString stringWithFormat:@"%d",(int)_sunCourseArrayPosition];
            ++_sunCourseArrayPosition;
            ++_sunCourseArrayPosition;
            newCourse.classLength = @"2";
            [self.sundayCourseArray addObject:newCourse];
        }
    }
    if([self dayCourseArray:(_saturdayCourseArray)]<len){
        for(NSInteger i = _saturdayCourseArray.count ; i<len ;++i){
            COURSEINFO *newCourse = [[COURSEINFO alloc]init];
            newCourse.startClass = [NSString stringWithFormat:@"%d",(int)_saturCourseArrayPosition];
            ++_saturCourseArrayPosition;
            ++_saturCourseArrayPosition;
            newCourse.classLength = @"2";
            [_saturdayCourseArray addObject:newCourse];
        }
    }
    if([self dayCourseArray:(_fridayCourseArray)]<len){
        for(NSInteger i = _fridayCourseArray.count ; i<len ;++i){
            COURSEINFO *newCourse = [[COURSEINFO alloc]init];
            newCourse.startClass = [NSString stringWithFormat:@"%d",(int)_friCourseArrayPosition];
            ++_friCourseArrayPosition;
            ++_friCourseArrayPosition;
            newCourse.classLength = @"2";
            [_fridayCourseArray addObject:newCourse];
        }
    }
    if([self dayCourseArray:(_thursedayCourseArray)]<len){
        for(NSInteger i = _thursedayCourseArray.count ; i<len ;++i){
            COURSEINFO *newCourse = [[COURSEINFO alloc]init];
            newCourse.startClass = [NSString stringWithFormat:@"%d",(int)_thurseCourseArrayPosition];
            ++_thurseCourseArrayPosition;
            ++_thurseCourseArrayPosition;
            newCourse.classLength = @"2";
            [_thursedayCourseArray addObject:newCourse];
        }
    }
    if([self dayCourseArray:(_wednesdayCourseArray)]<len){
        for(NSInteger i = _wednesdayCourseArray.count ; i<len ;++i){
            COURSEINFO *newCourse = [[COURSEINFO alloc]init];
            newCourse.startClass = [NSString stringWithFormat:@"%d",(int)_wednesCourseArrayPosition];
            ++_wednesCourseArrayPosition;
            ++_wednesCourseArrayPosition;
            newCourse.classLength = @"2";
            [_wednesdayCourseArray addObject:newCourse];
        }
    }
    if([self dayCourseArray:(_tuesdayCourseArray)]<len){
        for(NSInteger i = _tuesdayCourseArray.count ; i<len ;++i){
            COURSEINFO *newCourse = [[COURSEINFO alloc]init];
            newCourse.startClass = [NSString stringWithFormat:@"%d",(int)_tuesCourseArrayPosition];
            ++_tuesCourseArrayPosition;
            ++_tuesCourseArrayPosition;
            newCourse.classLength = @"2";
            [_tuesdayCourseArray addObject:newCourse];
        }
    }
    if([self dayCourseArray:(_mondayCourseArray)]<len){
        for(NSInteger i = _mondayCourseArray.count ; i<len ;++i){
            COURSEINFO *newCourse = [[COURSEINFO alloc]init];
            newCourse.startClass = [NSString stringWithFormat:@"%d",(int)_monCourseArrayPosition];
            ++_monCourseArrayPosition;
            ++_monCourseArrayPosition;
            newCourse.classLength = @"2";
            [_mondayCourseArray addObject:newCourse];
        }
    }
}

- (void)currentWeekDay{
    [self changeDayIndicater:[Public obtainWeek] animation:NO];
    CGRect frame = self.backgroundScrollView.frame;
    frame.origin.x = [Public obtainWeek] * self.view.frame.size.width;
    [self.backgroundScrollView scrollRectToVisible:frame animated:NO];
}

- (void)selectWeekday:(UIButton*)sender
{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag - DAY_BUTTON_TAG_BASE;
    [self changeDayIndicater:tag animation:YES];
    
    CGRect frame = self.backgroundScrollView.frame;
    frame.origin.x = tag * self.view.frame.size.width;
    [self.backgroundScrollView scrollRectToVisible:frame animated:YES];
}

- (void)changeDayIndicater:(NSInteger)index animation:(BOOL)animation
{
    //index表示当前选中Day所在的位置，currentIndex表示前一次选中Day所在位置
    if (index == self.currentIndex) return;
    
    if (animation) {
        //动画效果，Duration为动画持续时间，delay为动画开始前延迟调用的时间，animations为动画效果的代码块
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             UILabel *currentLab = (UILabel *)[self.view viewWithTag:DAY_LABEL_TAG_BASE + self.currentIndex];
                             currentLab.alpha = 0.5;
                             
                             UILabel *newLab = (UILabel *)[self.view viewWithTag:DAY_LABEL_TAG_BASE + index];
                             newLab.alpha = 1;
                             
                             self.currentIndex = (int)index;
                             
                             CGRect frame = self.dayIndicator.frame;
                             frame.origin.x = index * HEADER_DAY_WIDTH + INDICATOR_INDEX;
                             self.dayIndicator.frame = frame;
                         }
                         completion:^(BOOL finished) {
                         }];

    } else {
        UILabel *currentLab = (UILabel *)[self.view viewWithTag:DAY_LABEL_TAG_BASE + self.currentIndex];
        currentLab.alpha = 0.5;
        
        UILabel *newLab = (UILabel *)[self.view viewWithTag:DAY_LABEL_TAG_BASE + index];
        newLab.alpha = 1;
        
        self.currentIndex = (int)index;
        
        CGRect frame = self.dayIndicator.frame;
        frame.origin.x = index * HEADER_DAY_WIDTH + INDICATOR_INDEX;
        self.dayIndicator.frame = frame;
    }
}


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger tableTag = tableView.tag;
    NSInteger rowNumber = COURSE_COUNT;
    switch (tableTag) {
        case TABLE_VIEW_TAG_BASE:
            rowNumber = _mondayCourseArray.count;
            break;
        case TABLE_VIEW_TAG_BASE +1:
            rowNumber = _tuesdayCourseArray.count;
            break;
        case TABLE_VIEW_TAG_BASE +2:
            rowNumber = _wednesdayCourseArray.count;
            break;
        case TABLE_VIEW_TAG_BASE +3:
            rowNumber = _thursedayCourseArray.count;
            break;
        case TABLE_VIEW_TAG_BASE +4:
            rowNumber = _fridayCourseArray.count;
            break;
        case TABLE_VIEW_TAG_BASE +5:
            rowNumber = _saturdayCourseArray.count;
            break;
        case TABLE_VIEW_TAG_BASE +6:
            rowNumber = _sundayCourseArray.count;
            break;
        default:
            return 0;
            break;
    }
    return rowNumber;
}

- (NSInteger )dayCourseArray:(NSMutableArray *)dayCourseArray {
    NSInteger dayCourseLength = 0;
    for (int i = 0; i <dayCourseArray.count; ++i) {
        COURSEINFO *courseInfo = [dayCourseArray objectAtIndex:i];
        if(courseInfo.lessonName != nil)
            dayCourseLength += [courseInfo.classLength integerValue];
    }
    return dayCourseLength;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger tableTag = tableView.tag;
    COURSEINFO *courseInfo = nil;
    int row = (int)indexPath.row;
    switch (tableTag) {
        case TABLE_VIEW_TAG_BASE:{
                courseInfo = [_mondayCourseArray objectAtIndex:row];
                break;
        }
        case TABLE_VIEW_TAG_BASE+1:{
                courseInfo = [_tuesdayCourseArray objectAtIndex:row];
                break;
        }
        case TABLE_VIEW_TAG_BASE+2:{
                courseInfo = [_wednesdayCourseArray objectAtIndex:row];
                break;
        }
        case TABLE_VIEW_TAG_BASE+3:{
                courseInfo = [_thursedayCourseArray objectAtIndex:row];
                break;
        }
        case TABLE_VIEW_TAG_BASE+4:{
                courseInfo = [_fridayCourseArray objectAtIndex:row];
                break;
        }
        case TABLE_VIEW_TAG_BASE+5:{
                courseInfo = [_saturdayCourseArray objectAtIndex:row];
                break;
        }
        case TABLE_VIEW_TAG_BASE+6:{
                courseInfo = [_sundayCourseArray objectAtIndex:row];
                break;
        }
        default:
            break;
    }
    static NSString *indentifier = @"CTDayViewCell";
    CTDayViewCell *courseCell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (courseCell == nil) {
        courseCell = [[CTDayViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    courseCell.courseName.text = courseInfo.lessonName ? [NSString stringWithFormat:@"%@@%@",courseInfo.lessonName,courseInfo.teacherName] : nil;
    courseCell.courseAddress.text = courseInfo.address;
        courseCell.courseNum.text = [NSString stringWithFormat:@"%d-%d",[courseInfo.startClass integerValue]+1,([courseInfo.startClass integerValue] + [courseInfo.classLength integerValue] - 1) + 1];
    courseCell.coursePeriod.text = courseInfo.startWeek ? [NSString stringWithFormat:@"从第%@周到第%@周",courseInfo.startWeek,courseInfo.endWeek] : nil;
    return courseCell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 87;
}


#pragma mark - scrollview delegate

//触摸屏幕来滚动画面还是其他的方法使得画面滚动，皆触发该函数
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x > 0) {
        self.isScrollingWeekday = YES;
    }
    if (!self.isScrollingWeekday && scrollView.contentOffset.x <= 0) {
        [scrollView setContentOffset:CGPointMake(0, scrollView.contentOffset.y)];
        return;
    }
}

//触摸屏幕并拖拽画面，再松开，最后停止时，触发该函数
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
    self.isScrollingWeekday = NO;
}

//滚动停止时，触发该函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.backgroundScrollView) {
        NSInteger page = floor((scrollView.contentOffset.x - self.view.frame.size.width / 2) / self.view.frame.size.width) + 1;
        [self changeDayIndicater:page animation:YES];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger tableTag = tableView.tag;
    COURSEINFO *courseInfo = nil;
    int row = (int)indexPath.row;
    switch (tableTag) {
        case TABLE_VIEW_TAG_BASE:{
            courseInfo = [_mondayCourseArray objectAtIndex:row];
            if (!courseInfo.lessonName) {
                return;
            }
            if ([[UserModel sharedInstance].memberType isEqualToString:@"student"]) {
                CourseInfoBoard_iPhone *board = [CourseInfoBoard_iPhone board];
                board.courseInfo = courseInfo;
                [self.stack pushBoard:board animated:YES];
            } else {
                StudentsOfClassBoard_iPhone *board = [StudentsOfClassBoard_iPhone board];
                board.scheduleId = courseInfo.scheduleId;
                [self.stack pushBoard:board animated:YES];
            }
            break;
        }
        case TABLE_VIEW_TAG_BASE+1:{
            courseInfo = [_tuesdayCourseArray objectAtIndex:row];
            if (!courseInfo.lessonName) {
                return;
            }
            if ([[UserModel sharedInstance].memberType isEqualToString:@"student"]) {
                CourseInfoBoard_iPhone *board = [CourseInfoBoard_iPhone board];
                board.courseInfo = courseInfo;
                [self.stack pushBoard:board animated:YES];
            } else {
                StudentsOfClassBoard_iPhone *board = [StudentsOfClassBoard_iPhone board];
                board.scheduleId = courseInfo.scheduleId;
                [self.stack pushBoard:board animated:YES];
            }
            break;
        }
        case TABLE_VIEW_TAG_BASE+2:{
            courseInfo = [_wednesdayCourseArray objectAtIndex:row];
            if (!courseInfo.lessonName) {
                return;
            }
            if ([[UserModel sharedInstance].memberType isEqualToString:@"student"]) {
                CourseInfoBoard_iPhone *board = [CourseInfoBoard_iPhone board];
                board.courseInfo = courseInfo;
                [self.stack pushBoard:board animated:YES];
            } else {
                StudentsOfClassBoard_iPhone *board = [StudentsOfClassBoard_iPhone board];
                board.scheduleId = courseInfo.scheduleId;
                [self.stack pushBoard:board animated:YES];
            }
            break;
        }
        case TABLE_VIEW_TAG_BASE+3:{
            courseInfo = [_thursedayCourseArray objectAtIndex:row];
            if (!courseInfo.lessonName) {
                return;
            }
            if ([[UserModel sharedInstance].memberType isEqualToString:@"student"]) {
                CourseInfoBoard_iPhone *board = [CourseInfoBoard_iPhone board];
                board.courseInfo = courseInfo;
                [self.stack pushBoard:board animated:YES];
            } else {
                StudentsOfClassBoard_iPhone *board = [StudentsOfClassBoard_iPhone board];
                board.scheduleId = courseInfo.scheduleId;
                [self.stack pushBoard:board animated:YES];
            }
            break;
        }
        case TABLE_VIEW_TAG_BASE+4:{
            courseInfo = [_fridayCourseArray objectAtIndex:row];
            if (!courseInfo.lessonName) {
                return;
            }
            if ([[UserModel sharedInstance].memberType isEqualToString:@"student"]) {
                CourseInfoBoard_iPhone *board = [CourseInfoBoard_iPhone board];
                board.courseInfo = courseInfo;
                [self.stack pushBoard:board animated:YES];
            } else {
                StudentsOfClassBoard_iPhone *board = [StudentsOfClassBoard_iPhone board];
                board.scheduleId = courseInfo.scheduleId;
                [self.stack pushBoard:board animated:YES];
            }
            break;
        }
        case TABLE_VIEW_TAG_BASE+5:{
            courseInfo = [_saturdayCourseArray objectAtIndex:row];
            if (!courseInfo.lessonName) {
                return;
            }
            if ([[UserModel sharedInstance].memberType isEqualToString:@"student"]) {
                CourseInfoBoard_iPhone *board = [CourseInfoBoard_iPhone board];
                board.courseInfo = courseInfo;
                [self.stack pushBoard:board animated:YES];
            } else {
                StudentsOfClassBoard_iPhone *board = [StudentsOfClassBoard_iPhone board];
                board.scheduleId = courseInfo.scheduleId;
                [self.stack pushBoard:board animated:YES];
            }
            break;
        }
        case TABLE_VIEW_TAG_BASE+6:{
            courseInfo = [_sundayCourseArray objectAtIndex:row];
            if (!courseInfo.lessonName) {
                return;
            }
            if ([[UserModel sharedInstance].memberType isEqualToString:@"student"]) {
                CourseInfoBoard_iPhone *board = [CourseInfoBoard_iPhone board];
                board.courseInfo = courseInfo;
                [self.stack pushBoard:board animated:YES];
            } else {
                StudentsOfClassBoard_iPhone *board = [StudentsOfClassBoard_iPhone board];
                board.scheduleId = courseInfo.scheduleId;
                [self.stack pushBoard:board animated:YES];
            }
            break;
        }
        default:
            break;
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
