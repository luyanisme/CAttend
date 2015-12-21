//
//  CTCollectionViewDataSource.m
//  collectionViewTest
//
//  Created by 钟由 on 14-9-11.
//  Copyright (c) 2014年 flywarrior24@163.com. All rights reserved.
//

#import "CTCollectionViewDataSource.h"
#import "CTCourseInfo.h"
#import "CTCollectionViewCell.h"
#import "CTHeadViewCell.h"

@implementation CTCollectionViewDataSource

- (id)init{
    
    self = [super init];
    if (self!=nil)
    {
        [self initTestData];
    }
    return self;
}

-(void) initTestData{
}

- (NSArray *)indexPathsOfEventsBetweenMinDay:(int)minDay andMaxDay:(int)maxDay betweenCourseNum:(int)startCourseNum andCourseNum:(int)endCourseNum
{
    NSMutableArray *indexPaths = [NSMutableArray array];
    for(int i = 0; i < _courseInfoArray.count ; ++i){
        COURSEINFO *course = [_courseInfoArray objectAtIndex:i];
        if([course.weekday integerValue]>= minDay && [course.weekday integerValue]<= maxDay && [course.startClass integerValue] >= startCourseNum && [course.startClass integerValue] + [course.classLength integerValue]-1 <= endCourseNum){
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [indexPaths addObject:indexPath];
        }
    }
    return indexPaths;
}


- (NSComparisonResult) myCompare:(COURSEINFO *)courseinfo {
    COURSEINFO *now = (COURSEINFO *)self;
    if([now.weekday integerValue]> [courseinfo.weekday integerValue])
        return NSOrderedAscending;
    else if([now.weekday integerValue]< [courseinfo.weekday integerValue])
        return NSOrderedDescending;
    else{
        if([now.startClass integerValue] >[courseinfo.startClass integerValue])
            return NSOrderedAscending;
        else
            return NSOrderedDescending;
    }
}

- (NSArray *)sortByDayAndCourseNumber{
    [_courseInfoArray sortUsingComparator:^NSComparisonResult(id obj1,id obj2){
        COURSEINFO *first = (COURSEINFO *)obj1;
        COURSEINFO *second = (COURSEINFO *)obj2;
        if([first.weekday integerValue]< [second.weekday integerValue])
            return NSOrderedAscending;
        else if([first.weekday integerValue]> [second.weekday integerValue])
            return NSOrderedDescending;
        else{
            if([first.startClass integerValue] < [second.startClass integerValue])
                return NSOrderedAscending;
            else
                return NSOrderedDescending;
        }
    }];
    return _courseInfoArray;
}
@end
