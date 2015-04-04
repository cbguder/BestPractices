#import <Foundation/Foundation.h>


@protocol BSInjector;


@interface InjectorProvider : NSObject

+ (id<BSInjector>)injector;

@end
