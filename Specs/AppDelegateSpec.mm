#import "Cedar.h"
#import "Blindside.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "InjectorKeys.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(AppDelegateSpec)

describe(@"AppDelegate", ^{
    __block AppDelegate *subject;
    __block id<BSBinder,BSInjector> injector;
    __block UIWindow *window;
    __block UIViewController *rootViewController;

    beforeEach(^{
        subject = [[AppDelegate alloc] init];
        injector = (id)subject.injector;

        window = nice_fake_for([UIWindow class]);
        [injector bind:[UIWindow class] toInstance:window];

        rootViewController = nice_fake_for([UIViewController class]);
        [injector bind:InjectorKeyRootViewController toInstance:rootViewController];

        [subject application:nil didFinishLaunchingWithOptions:nil];
    });

    it(@"should display the root view controller", ^{
        window should have_received(@selector(setRootViewController:)).with(rootViewController);
        window should have_received(@selector(makeKeyAndVisible));
    });
});

SPEC_END
