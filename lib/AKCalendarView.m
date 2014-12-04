//
// Created by P.I.akura on 2013/04/22.
// Copyright (c) 2013 P.I.akura. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "AKCalendarView.h"
#import "AKCalendarCell.h"

#define kWeekDays 7
#define kWeeks 6

@interface AKCalendarViewObject : NSObject
@property(nonatomic) NSInteger index;
@property(nonatomic) CGRect frame;
@property(nonatomic) NSMutableArray *array;
@end

@implementation AKCalendarViewObject
@end

@implementation AKCalendarView {
    NSArray *weeks;
    NSArray *days;
    AKCalendarCell *selectedButton;

    NSLock *_lock;
    NSInteger _updateFlag;
}

- (void)setDelegate:(id <AKCalendarViewDelegate>)delegate {
    _delegate = delegate;
}

- (void)updateDays {
    [self updateDaysWithComplte:^(id o){}];
}
- (void)updateDaysWithComplte:(void(^)(AKCalendarView *))complte {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _lock = [[NSLock alloc] init];
    });
    [self performSelectorInBackground:@selector(_updateDays:) withObject:complte];
}

- (void)_updateDays:(void(^)(AKCalendarView *))complte {
    [_lock lock];
    if (_updateFlag == 0) {
        do {
            _updateFlag = 1;
            [_lock unlock];
            [self createWeeks:[self cellSize]];
            [self createDays:[self cellSize]];
            complte(self);
            [_lock lock];
        } while (_updateFlag != 1);
        _updateFlag = 0;
    } else {
        _updateFlag = 2;
    }
    [_lock unlock];
}

- (void)createButton:(AKCalendarViewObject *)object {
    NSInteger index = object.index;
    AKCalendarCell *button = [_delegate calendarView:self cellForIndex:index];
    if (button) {
        button.frame = object.frame;
        [button setTag:index];

        [button addTarget:self action:@selector(touchCell:) forControlEvents:UIControlEventTouchUpInside];

        id v = [self dequeueReusableCellForIndex:index];
        if (v) {
            [v removeFromSuperview];
            [self addSubview:button];
            object.array[index] = button;
        } else {
            [self addSubview:button];
            [object.array addObject:button];
        }
    }
}

- (void)createDays:(CGSize)size {
    [self performSelectorOnMainThread:@selector(cancelSelectedButton) withObject:nil waitUntilDone:YES];

    AKCalendarViewObject *object = [AKCalendarViewObject new];
    CGRect frame = CGRectMake(0, size.height + 1, size.width, size.height);
    object.array = @[].mutableCopy;
    for (int i = 0; i < kWeeks; i++, frame.origin.y += size.height + 1) {
        frame.origin.x = 0;
        for (int j = 0; j < kWeekDays; j++, frame.origin.x += size.width + 1) {
            object.index = i * kWeekDays + j;
            object.frame = frame;
            [self performSelectorOnMainThread:@selector(createButton:) withObject:object waitUntilDone:YES];
        }
    }
    days = object.array;
}

- (void)cancelSelectedButton {
    selectedButton.selected = NO;
    selectedButton = nil;
}

- (void)touchCell:(id)sender {
    selectedButton.selected = NO;
    selectedButton = sender;
    selectedButton.selected = YES;
    if ([_delegate respondsToSelector:@selector(selectedDay:)]) {
        [_delegate selectedDay:[sender tag]];
    }
}

- (void)selectCellAtIndex:(NSInteger)index {
    [self touchCell:days[index]];
}

- (void)createWeeks:(CGSize)size {
    AKCalendarViewObject *object = [AKCalendarViewObject new];
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    object.array = @[].mutableCopy;
    for (object.index = 0; object.index < kWeekDays; object.index++, frame.origin.x += size.width + 1) {
        object.frame = frame;
        [self performSelectorOnMainThread:@selector(createLabel:) withObject:object waitUntilDone:YES];
    }
    weeks = object.array;
}

- (void)createLabel:(AKCalendarViewObject *)object {
    UILabel *label = [_delegate calendarView:self labelForIndex:object.index];
    if (label) {
        label.frame = object.frame;

        id v = [self dequeueReusableLabelForIndex:object.index];
        if (v) {
            [v removeFromSuperview];
            [self addSubview:label];
            object.array[object.index] = label;
        } else {
            [self addSubview:label];
            [object.array addObject:label];
        }
    }
}

- (id)dequeueReusableLabelForIndex:(NSInteger)i {
    if (i < weeks.count) {
        return weeks[i];
    } else {
        return nil;
    }
}

- (CGSize)cellSize {
    return CGSizeMake((NSInteger) (self.frame.size.width / kWeekDays) - 1, (NSInteger) (self.frame.size.height / (kWeeks + 1)) - 1);
}

- (NSInteger)indexForIndexPath:(NSIndexPath *)path {
    return path.section * 7 + path.row;
}

- (AKCalendarCell *)dequeueReusableCellForIndex:(NSInteger)index {
    if (index < days.count) {
        return days[index];
    } else {
        return nil;
    }
}

- (NSNumber *)selectedIndex {
    return (selectedButton) ? @(selectedButton.tag) : nil;
}
@end
