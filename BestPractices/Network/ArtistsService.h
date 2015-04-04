#import <Foundation/Foundation.h>


@class KSPromise;


@interface ArtistsService : NSObject

- (KSPromise *)getArtists;

@end
