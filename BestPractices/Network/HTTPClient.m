#import "HTTPClient.h"
#import "KSPromise.h"
#import "Blindside.h"
#import "KSNetworkClient.h"


@interface HTTPClient ()

@property(nonatomic) id <KSNetworkClient> networkClient;
@property(nonatomic) NSOperationQueue *operationQueue;

@end


@implementation HTTPClient

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initWithOperationQueue:networkClient:)
                                  argumentKeys:
            [NSOperationQueue class],
            @protocol(KSNetworkClient),
            nil];
}

- (instancetype)initWithOperationQueue:(NSOperationQueue *)operationQueue
                         networkClient:(id <KSNetworkClient>)networkClient {
    self = [super init];
    if (self) {
        self.operationQueue = operationQueue;
        self.networkClient = networkClient;
    }
    return self;
}

- (KSPromise *)sendRequest:(NSURLRequest *)request {
    KSPromise *networkPromise = [self.networkClient sendAsynchronousRequest:request queue:self.operationQueue];

    return [networkPromise then:^id(KSNetworkResponse *networkResponse) {
        return networkResponse.data;
    } error:^id(NSError *error) {
        return error;
    }];
}

@end
