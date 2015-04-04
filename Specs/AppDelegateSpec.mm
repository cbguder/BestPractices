#import "Cedar.h"
#import "AppDelegate.h"
#import "ViewController.h"


using namespace Cedar::Matchers;
using namespace Cedar::Doubles;


SPEC_BEGIN(AppDelegateSpec)

describe(@"AppDelegate", ^{
    __block AppDelegate *subject;

    beforeEach(^{
        subject = [[AppDelegate alloc] init];

        [subject application:nil didFinishLaunchingWithOptions:nil];
    });

    it(@"should set the root view controller", ^{
        UINavigationController *navigationController = (id)subject.window.rootViewController;
        navigationController should be_instance_of([UINavigationController class]);
        navigationController.topViewController should be_instance_of([ViewController class]);
    });

    it(@"should display the window", ^{
        [subject.window isKeyWindow] should be_truthy;
    });
});

SPEC_END
