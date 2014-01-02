#import "UserDefaults.h"

@implementation UserDefaults {
    NSUserDefaults *defaults;
}

+ (instancetype)sharedManager {
    static UserDefaults *sharedManager_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager_ = UserDefaults.new;
    });

    return sharedManager_;
}

- (id)init {
    self = [super init];
    if (self != nil) {
        defaults = [NSUserDefaults standardUserDefaults];
    }

    return self;
}
- (void)registerDefaults:(NSDictionary *)dict {
    [defaults registerDefaults:dict];
}

@end
