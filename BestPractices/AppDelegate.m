#import "AppDelegate.h"
#import "Blindside.h"
#import "UIModule.h"
#import "InjectorKeys.h"


@interface AppDelegate ()

@property (nonatomic) id<BSInjector> injector;

@end


@implementation AppDelegate

- (id)init {
    self = [super init];
    if (self) {
        UIModule *uiModule = [[UIModule alloc] init];
        self.injector = [Blindside injectorWithModule:uiModule];
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
