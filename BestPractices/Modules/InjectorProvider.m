#import "InjectorProvider.h"
#import "BSInjector.h"
#import "FoundationModule.h"
#import "NetworkModule.h"
#import "UIModule.h"
#import "DomainModule.h"


@implementation InjectorProvider

+ (id <BSInjector>)injector {
    NSArray *modules = @[
        [[FoundationModule alloc] init],
        [[NetworkModule alloc] init],
        [[UIModule alloc] init],
        [[DomainModule alloc] init]
    ];

    return [Blindside injectorWithModules:modules];
}

@end
