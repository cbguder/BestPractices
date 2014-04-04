#import <Foundation/Foundation.h>


@class KSPromise;


@interface APIClient : NSObject

- (KSPromise *)getArtists;

@end
