@class WECheckDose;

@interface AKCalendarCell : UIButton {
    BOOL _inCurrentMonth;
}

@property(nonatomic) NSDate *date;

- (void)update:(NSDate *)date inCurrentMonth:(BOOL)month;
+ (AKCalendarCell *)create;
@end