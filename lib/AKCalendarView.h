//
// Created by P.I.akura on 2013/04/22.
// Copyright (c) 2013 P.I.akura. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class AKCalendarCell;
@class AKCalendarModel;
@protocol AKCalendarViewDelegate;

@interface AKCalendarView : UIView

@property(nonatomic) id <AKCalendarViewDelegate> delegate;

- (void)selectCellAtIndex:(NSInteger)index;

- (void)updateDays;
- (void)updateDaysWithComplte:(void(^)(AKCalendarView *))complte;

- (CGSize)cellSize;

- (AKCalendarCell *)dequeueReusableCellForIndex:(NSInteger)index;
- (id)dequeueReusableLabelForIndex:(int)i;
- (NSNumber *)selectedIndex;
@end

@protocol AKCalendarViewDelegate <NSObject>

- (void)selectedDay:(NSInteger)index;
- (AKCalendarCell *)calendarView:(AKCalendarView *)calendarView cellForIndex:(NSInteger)indexPath;
- (id)calendarView:(AKCalendarView *)calendarView labelForIndex:(NSInteger)index;
@end