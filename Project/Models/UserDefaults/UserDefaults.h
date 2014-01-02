
#import <Foundation/Foundation.h>


@interface UserDefaults : NSObject

+ (instancetype)sharedManager;
- (void)registerDefaults:(NSDictionary *)dict;

@end
