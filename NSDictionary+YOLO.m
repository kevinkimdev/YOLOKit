#import "YOLO.h"


@implementation NSDictionary (YOLO)

- (id (^)(id))get {
    return ^(id key) {
        return [self objectForKey:key];
    };
}

@end