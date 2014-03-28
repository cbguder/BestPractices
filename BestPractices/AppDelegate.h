#import <UIKit/UIKit.h>


@protocol BSInjector;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, readonly) id<BSInjector> injector;
@property (nonatomic) UIWindow *window;

@end
