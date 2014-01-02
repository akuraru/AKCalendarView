
#import "MainViewController.h"
#import "AKCalendarView.h"
#import "AKCalendarModel.h"
#import "AKCalendarCell.h"
#import "SampleCell.h"
#import <NSDate-Escort/NSDate+Escort.h>

@interface MainViewController () <AKCalendarViewDelegate>

@end

@implementation MainViewController {
    __weak IBOutlet AKCalendarView *_calendar;
    AKCalendarModel *model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    model = [[AKCalendarModel alloc] init];
    _calendar.delegate = self;
}
- (IBAction)previousMonth:(id)sender {
    [model backMonth];
    [_calendar updateDays];
}
- (IBAction)nextMonth:(id)sender {
    [model nextMonth];
    [_calendar updateDaysWithComplte:^(AKCalendarView *calendar){
        if ([model.currentDate isSameMonthAsDate:[NSDate date]]) {
            [calendar selectCellAtIndex:[model today]];
        } else {
            [calendar selectCellAtIndex:[model currentIndex]];
        }
    }];
}

- (void)selectedDay:(NSInteger)index {
    NSLog(@"%d", index);
}
- (AKCalendarCell *)calendarView:(AKCalendarView *)calendarView cellForIndex:(NSInteger)index {
    AKCalendarCell *calendarButton = [calendarView dequeueReusableCellForIndex:index];
    if (!calendarButton) {
        calendarButton = [SampleCell create];
    }
    NSDate *date = [model day:index];
    [calendarButton update:date inCurrentMonth:[model.currentDate isSameMonthAsDate:date]];

    [NSThread sleepForTimeInterval:0.02];
    return calendarButton;
}

- (UILabel *)calendarView:(AKCalendarView *)calendarView labelForIndex:(NSInteger)index {
    UILabel *label = [calendarView dequeueReusableLabelForIndex:index];
    if (!label) {
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:17.0];
        [label setText:[self weekName:index]];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor blackColor];
    }
    return label;
}

- (NSString *)weekName:(NSInteger)index {
    switch (index) {
        case 0: return @"Sun";
        case 1: return @"Mon";
        case 2: return @"Tue";
        case 3: return @"Wed";
        case 4: return @"Thu";
        case 5: return @"Fri";
        case 6:
        default:
            return @"Sat";
    }
}


@end
