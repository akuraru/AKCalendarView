//
// Created by P.I.akura on 2013/04/22.
// Copyright (c) 2013 P.I.akura. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "AKCalendarModel.h"
#import "NSDate+Escort.h"

#define kOneDay 86400

@interface AKCalendarModel ()
@property (nonatomic, strong) NSDate *firstDay;
@end

@implementation AKCalendarModel {
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
    NSDateComponents *comps = [self components:self.currentDate];
    [comps setWeekOfMonth:1];
    [comps setWeekday:1];

    self.firstDay = [calendar dateFromComponents:comps];
}

- (NSDateComponents *)components:(NSDate *)date {
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    return [calendar components:unitFlags fromDate:date];
}

- (NSDate *)day:(int)index {
    return [self.firstDay dateByAddingDays:index];
}
- (NSInteger)indexForDate:(NSDate *)day {
    return [self.firstDay daysAfterDate:day];
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
    self.currentDate = [self.currentDate dateByAddingMonths:month];
}

- (NSInteger)beforeMonthDays {
    return [self betweenDaysWithDate:self.firstDay after:self.currentDate];
}

- (NSInteger)afterMonthStartDay {
    return [self betweenDaysWithDate:self.firstDay after:[self currentNextMonth]];
}

- (NSInteger)betweenDaysWithDate:(NSDate *)date after:(NSDate *)after {
    return [after timeIntervalSinceDate:date] / kOneDay;;
}

- (NSDate *)currentNextMonth {
    return [self.currentDate dateByAddingMonths:1];
}

- (NSInteger)today {
    return [self.firstDay daysBeforeDate:[NSDate date]];
}

- (NSInteger)currentIndex {
    return [self beforeMonthDays];
}

- (NSInteger)indexOfDay:(NSDate *)date {
    return [self.firstDay daysBeforeDate:date];
}
@end