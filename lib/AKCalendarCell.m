#import <NSDate-Escort/NSDate+Escort.h>
#import "AKCalendarCell.h"

@implementation AKCalendarCell

+ (AKCalendarCell *)create {
    return [self buttonWithType:UIButtonTypeCustom];
}
+ (id)buttonWithType:(UIButtonType)buttonType {
    AKCalendarCell *button = (id)[super buttonWithType:buttonType];
    if (self) {
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return button;
}

- (void)update:(NSDate *)date_ inCurrentMonth:(BOOL)month {
    self.date = date_;
    _inCurrentMonth = month;
    [self setTitle:[@([date_ day]) stringValue] forState:UIControlStateNormal];
    if (_inCurrentMonth) {
        [self setBackgroundColor:[UIColor whiteColor]];
    } else {
        [self setBackgroundColor:[UIColor lightGrayColor]];
    }
}
@end
