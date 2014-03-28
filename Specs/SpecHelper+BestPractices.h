#import <Foundation/Foundation.h>
#import "Blindside.h"

@interface SpecHelper (BestPractices)

+ (id<BSBinder,BSInjector>)injector;

@end
