//
// Created by P.I.akura on 2013/04/22.
// Copyright (c) 2013 P.I.akura. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface AKCalendarModel : NSObject

@property(nonatomic, strong) NSDate *currentDate;

- (NSDate *)day:(int)index;

- (void)nextMonth;

- (void)backMonth;

- (NSInteger)beforeMonthDays;

- (NSInteger)afterMonthStartDay;

- (NSInteger)today;
- (NSInteger)currentIndex;
- (NSInteger)indexOfDay:(NSDate *)date;
@end