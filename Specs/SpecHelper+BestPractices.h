#import <Foundation/Foundation.h>
#import "Blindside.h"
#import "Cedar.h"


@interface SpecHelper (BestPractices)

+ (id<BSBinder,BSInjector>)injector;

@end
