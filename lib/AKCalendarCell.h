@class WECheckDose;

@interface AKCalendarCell : UIButton {
    BOOL _inCurrentMonth;
}

@property(strong, nonatomic) NSDate *date;

- (void)update:(NSDate *)date inCurrentMonth:(BOOL)month;
+ (instancetype)create;
@end