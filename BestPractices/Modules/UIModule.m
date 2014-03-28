#import "UIModule.h"
#import "InjectorKeys.h"
#import "ViewController.h"

@implementation UIModule

- (void)configure:(id<BSBinder>)binder {
    [binder bind:[UIScreen class] toBlock:^id(NSArray *args, id<BSInjector> injector) {
        return [UIScreen mainScreen];
    }];

    [binder bind:[UIWindow class] toBlock:^id(NSArray *args, id<BSInjector> injector) {
        UIScreen *screen = [injector getInstance:[UIScreen class]];
        return [[UIWindow alloc] initWithFrame:screen.bounds];
    }];

    [binder bind:InjectorKeyRootViewController toBlock:^id(NSArray *args, id<BSInjector> injector) {
        ViewController *viewController = [injector getInstance:[ViewController class]];
        return [[UINavigationController alloc] initWithRootViewController:viewController];
    }];
}

@end
