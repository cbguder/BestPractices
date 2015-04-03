#import "APIClient.h"
#import "KSDeferred.h"
#import "Artist.h"


@implementation APIClient

- (KSPromise *)getArtists {
    Artist *artist1 = [[Artist alloc] initWithId:@"1" name:@"Ayreon"];
    Artist *artist2 = [[Artist alloc] initWithId:@"2" name:@"Rodrigo y Gabriela"];
    Artist *artist3 = [[Artist alloc] initWithId:@"3" name:@"Týr"];

    NSArray *artists = @[artist1, artist2, artist3];
    
    KSDeferred *deferred = [KSDeferred defer];
    [deferred resolveWithValue:artists];
    return deferred.promise;
}

@end
