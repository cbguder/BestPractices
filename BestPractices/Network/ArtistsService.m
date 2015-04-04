#import "ArtistsService.h"
#import "Blindside.h"
#import "KSDeferred.h"
#import "Artist.h"
#import "RequestProvider.h"
#import "KSNetworkClient.h"
#import "JSONClient.h"


@interface ArtistsService ()

@property(nonatomic) RequestProvider *requestProvider;
@property(nonatomic) JSONClient *jsonClient;

@end


@implementation ArtistsService

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initWithRequestProvider:jsonClient:)
                                  argumentKeys:
            [RequestProvider class],
            [JSONClient class],
            nil];
}

- (instancetype)initWithRequestProvider:(RequestProvider *)requestProvider
                             jsonClient:(JSONClient *)jsonClient {
    self = [super init];
    if (self) {
        self.requestProvider = requestProvider;
        self.jsonClient = jsonClient;
    }
    return self;
}

- (KSPromise *)getArtists {
    NSURLRequest *request = [self.requestProvider requestToGetArtists];

    KSPromise *jsonPromise = [self.jsonClient sendRequest:request];

    KSPromise *promise = [jsonPromise then:^id(NSArray *artistsJSON) {
        NSMutableArray *artists = [NSMutableArray arrayWithCapacity:[artistsJSON count]];

        for (NSDictionary *artistJSON in artistsJSON) {
            Artist *artist = [[Artist alloc] initWithId:artistJSON[@"id"]
                                                   name:artistJSON[@"name"]];

            [artists addObject:artist];
        }

        return artists;
    } error:nil];

    return promise;
}

@end
