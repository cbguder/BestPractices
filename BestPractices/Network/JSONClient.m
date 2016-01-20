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
    KSPromise *httpPromise = [self.httpClient sendRequest:request];

    KSPromise *promise = [httpPromise then:^id(NSData *data) {
        NSError *error = nil;

        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

        if (error) {
            return error;
        } else {
            return jsonObject;
        }
    } error:^id(NSError *error) {
        return error;
    }];

    return promise;
}

@end
