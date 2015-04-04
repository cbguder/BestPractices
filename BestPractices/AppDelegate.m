#import "AppDelegate.h"
#import "InjectorProvider.h"
#import "Blindside.h"
#import "InjectorKeys.h"


@interface AppDelegate ()

@property (nonatomic) id<BSInjector> injector;

@end


@implementation AppDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        self.injector = [InjectorProvider injector];
    }
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIViewController *rootViewController = [self.injector getInstance:InjectorKeyRootViewController];

    self.window = [self.injector getInstance:[UIWindow class]];
    self.window.rootViewController = rootViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    return YES;
}

@end
