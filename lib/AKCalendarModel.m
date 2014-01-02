//
// Created by P.I.akura on 2013/04/22.
// Copyright (c) 2013 P.I.akura. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "AKCalendarModel.h"
#import "NSDate+Escort.h"

#define kOneDay 86400

@implementation AKCalendarModel {
    NSDate *firstDay;
    NSCalendar *calendar;
}
- (id)init {
    self = [super init];
    if (self) {
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [self createCurrentDate];
        [self updateFirstDay];
    }
    return self;
}

- (void)createCurrentDate {
    NSDateComponents *comps = [self components:[NSDate date]];
    comps.day = 1;
    self.currentDate = [calendar dateFromComponents:comps];
}

- (void)updateFirstDay {
    NSDateComponents *comps = [self components:_currentDate];
    [comps setWeekOfMonth:1];
    [comps setWeekday:1];

    firstDay = [calendar dateFromComponents:comps];
}

- (NSDateComponents *)components:(NSDate *)date {
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    return [calendar components:unitFlags fromDate:date];
}

- (NSDate *)day:(int)index {
    return [firstDay dateByAddingDays:index];
}
- (NSInteger)indexForDate:(NSDate *)day {
    return [firstDay daysAfterDate:day];
}

- (void)nextMonth {
    [self updateDate:1];
    [self updateFirstDay];
}

- (void)backMonth {
    [self updateDate:-1];
    [self updateFirstDay];
}

- (void)updateDate:(NSInteger)month {
    _currentDate = [_currentDate dateByAddingMonths:month];
}

- (NSInteger)beforeMonthDays {
    return [self betweenDaysWithDate:firstDay after:self.currentDate];
}

- (NSInteger)afterMonthStartDay {
    return [self betweenDaysWithDate:firstDay after:[self currentNextMonth]];
}

- (NSInteger)betweenDaysWithDate:(NSDate *)date after:(NSDate *)after {
    return [after timeIntervalSinceDate:date] / kOneDay;;
}

- (NSDate *)currentNextMonth {
    return [_currentDate dateByAddingMonths:1];
}

- (NSInteger)today {
    return [firstDay daysBeforeDate:[NSDate date]];
}

- (NSInteger)currentIndex {
    return [self beforeMonthDays];
}
@end