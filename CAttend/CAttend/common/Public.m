//
//  Public.m
//  CAttend
//
//  Created by 卢棪 on 12/11/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "Public.h"

@implementation Public

+ (NSString *)obtainCurrentDate{
    NSDate* currentDate = [NSDate date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSString* dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"now time is %@",dateString);
    return [dateString substringToIndex:10];
}

+ (NSInteger)obtainWeek{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    
    if ([comps weekday] - 2 >= 0) {
        return [comps weekday] - 2;
    } else {
        return [comps weekday] + 5;
    }
    
}
@end
