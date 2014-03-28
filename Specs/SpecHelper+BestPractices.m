#import "SpecHelper+BestPractices.h"
#import "Blindside.h"
#import "UIModule.h"

@implementation SpecHelper (BestPractices)

+ (id<BSBinder,BSInjector>)injector {
    UIModule *uiModule = [[UIModule alloc] init];
    return (id)[Blindside injectorWithModule:uiModule];
}

@end
