//
//  CTDayViewController.h
//  collectionViewTest
//
//  Created by 钟由 on 14-9-11.
//  Copyright (c) 2014年 flywarrior24@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTCollectionViewDataSource.h"
#import "CTDefinition.h"
#import "CTCourseInfo.h"

@interface MainBoard_iPhone : BeeUIBoard<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (strong,nonatomic) CTCollectionViewDataSource *data;

//@property (strong,nonatomic) UIView *view;
@property (strong,nonatomic) UIScrollView *backgroundScrollView;
@property (strong,nonatomic) UIView *dayIndicator;
@property (strong,nonatomic) UIView *myView;

@property int currentIndex;
@property (nonatomic) BOOL isScrollingWeekday;

AS_MODEL(CourseModel, courseModel)

@end

@interface MainBoard_iPhone(private)
- (CTCourseInfo*)dayCourseArray:(NSMutableArray  *(__strong *))dayCourseArray
courseArrayCellPosition:(NSInteger *)courseArrayCellPosition adCount:(NSInteger *)cnt;
@end