#import "Cedar.h"
#import "SpecHelper+BestPractices.h"
#import "UIModule.h"
#import "InjectorKeys.h"
#import "ViewController.h"


using namespace Cedar::Matchers;
using namespace Cedar::Doubles;


SPEC_BEGIN(UIModuleSpec)

describe(@"UIModule", ^{
    __block id<BSBinder,BSInjector> injector;

    beforeEach(^{
        injector = [SpecHelper injector];
    });

    it(@"should create the root view controller", ^{
        UINavigationController *rootViewController = [injector getInstance:InjectorKeyRootViewController];

        rootViewController should be_instance_of([UINavigationController class]);
        rootViewController.topViewController should be_instance_of([ViewController class]);
    });
});

SPEC_END
