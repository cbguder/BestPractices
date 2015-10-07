#import "Cedar.h"
#import "HTTPClient.h"
#import "InjectorProvider.h"
#import "Blindside.h"
#import "Blindside.h"
#import "KSNetworkClient.h"
#import "KSDeferred.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(HTTPClientSpec)

describe(@"HTTPClient", ^{
    __block HTTPClient *subject;
    __block id<BSBinder, BSInjector> injector;
    __block id<KSNetworkClient> networkClient;
    __block NSOperationQueue *operationQueue;

    beforeEach(^{
        injector = (id)[InjectorProvider injector];

        networkClient = fake_for(@protocol(KSNetworkClient));
        [injector bind:@protocol(KSNetworkClient) toInstance:networkClient];

        operationQueue = fake_for([NSOperationQueue class]);
        [injector bind:[NSOperationQueue class] toInstance:operationQueue];

        subject = [injector getInstance:[HTTPClient class]];
    });

    describe(@"sending a request", ^{
        __block NSURLRequest *request;
        __block KSDeferred *networkDeferred;
        __block KSPromise *promise;

        beforeEach(^{
            networkDeferred = [KSDeferred defer];
            networkClient stub_method(@selector(sendAsynchronousRequest:queue:)).and_return(networkDeferred.promise);

            request = fake_for([NSURLRequest class]);

            promise = [subject sendRequest:request];
        });

        it(@"makes a request to the correct url", ^{
            networkClient should have_received(@selector(sendAsynchronousRequest:queue:))
                .with(request, operationQueue);
        });

        it(@"resolves the promise with the returned data when the request succeeds", ^{
            NSData *data = fake_for([NSData class]);
            
            KSNetworkResponse *networkResponse = fake_for([KSNetworkResponse class]);
            networkResponse stub_method(@selector(data)).and_return(data);
            
            [networkDeferred resolveWithValue:networkResponse];
            
            promise.value should be_same_instance_as(data);
        });

        it(@"rejects the promise when the request fails", ^{
            NSError *error = fake_for([NSError class]);
            [networkDeferred rejectWithError:error];
            
            promise.error should be_same_instance_as(error);
        });
    });
});

SPEC_END
