#import "JSONClient.h"
#import "Blindside.h"
#import "HTTPClient.h"
#import "KSDeferred.h"


@interface JSONClient ()

@property(nonatomic) HTTPClient *httpClient;

@end


@implementation JSONClient

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initWithHTTPClient:)
                                  argumentKeys:[HTTPClient class], nil];
}

- (instancetype)initWithHTTPClient:(HTTPClient *)httpClient {
    self = [super init];
    if (self) {
        self.httpClient = httpClient;
    }
    return self;
}

- (KSPromise *)sendRequest:(NSURLRequest *)request {
    KSDeferred *deferred = [KSDeferred defer];

    KSPromise *httpPromise = [self.httpClient sendRequest:request];
    [httpPromise then:^id(NSData *data) {
        NSError *error = nil;

        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

        if (error) {
            [deferred rejectWithError:error];
        } else {
            [deferred resolveWithValue:jsonObject];
        }

        return nil;
    } error:^id(NSError *error) {
        [deferred rejectWithError:error];
        return nil;
    }];

    return deferred.promise;
}

@end
