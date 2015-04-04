#import <Foundation/Foundation.h>


@class KSPromise;


@interface HTTPClient : NSObject

- (KSPromise *)sendRequest:(NSURLRequest *)request;

@end
