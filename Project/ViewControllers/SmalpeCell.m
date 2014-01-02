//
// Created by akuraru on 2014/01/01.
// Copyright (c) 2014 akuraru. All rights reserved.
//


#import "SampleCell.h"

@implementation SampleCell {
}

- (void)update:(NSDate *)date inCurrentMonth:(BOOL)month {
    [super update:date inCurrentMonth:month];
    if (month) {
        self.enabled = YES;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    } else {
        self.enabled = NO;
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];

    if (selected) {
        [self setBackgroundColor:[UIColor blueColor]];
    } else {
        if (_inCurrentMonth) {
            [self setBackgroundColor:[UIColor whiteColor]];
        } else {
            [self setBackgroundColor:[UIColor lightGrayColor]];
        }
    }
}
@end