#import "FoundationModule.h"


@implementation FoundationModule

- (void)configure:(id <BSBinder>)binder {
    [binder bind:[NSOperationQueue class] toInstance:[NSOperationQueue mainQueue]];
}

@end
