#import <Foundation/Foundation.h>


@class KSPromise;


@interface JSONClient : NSObject

- (KSPromise *)sendRequest:(NSURLRequest *)request;

@end
