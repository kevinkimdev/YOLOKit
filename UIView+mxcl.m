#import "UIView+mxcl.h"

@interface UIView (DumpTree)
- (NSString *)dumpTreeDescription;
@end
@implementation UIView (DumpTree)
- (NSString *)dumpTreeDescription {
    return NSStringFromCGRect(self.frame);
}
@end
@implementation UIScrollView (DumpTree)
- (NSString *)dumpTreeDescription {
    return [NSString stringWithFormat:@"%@, scrollsToTop: %@", [super dumpTreeDescription], self.scrollsToTop ? @"YES" : @"NO"];
}
@end


// http://stackoverflow.com/questions/751876
static void MBDumpViews(UIView* view, NSString *text, NSString *indent)
{
    Class class = [view class];
    NSMutableString *heirarchy = [NSMutableString stringWithString:[class description]];
    if (class != [UIView class])
        while ((class = [class superclass]) && class != [UIView class])
            [heirarchy appendFormat:@":%@", [class description]];

    id format = text.length ? @"%@ %@ %@" : @"%2$@ %3$@";
    NSLog(format, text, heirarchy, [view dumpTreeDescription]);

    unsigned ii = 0;
    for (UIView *subView in view.subviews) {
        NSString *newIndent = [NSString stringWithFormat:@"  %@", indent];
        NSString *msg = [NSString stringWithFormat:@"%@%d:", newIndent, ii++];
        MBDumpViews(subView, msg, newIndent);
    }
}

@implementation UIView (mxcl)
- (NSArray *)allSubviews {
    NSMutableArray *views = [NSMutableArray arrayWithArray:self.subviews];
    for (UIView *view in self.subviews)
        [views addObjectsFromArray:[view allSubviews]];
    return views;
}
- (void)dumpViewTree {
    MBDumpViews(self, @"", @"");
}
@end
