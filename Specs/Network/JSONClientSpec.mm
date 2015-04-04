#import "Cedar.h"
#import "JSONClient.h"
#import "InjectorProvider.h"
#import "Blindside.h"
#import "Blindside.h"
#import "HTTPClient.h"
#import "KSDeferred.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(JSONClientSpec)

describe(@"JSONClient", ^{
    __block JSONClient *subject;
    __block id<BSBinder, BSInjector> injector;
    __block HTTPClient *httpClient;

    beforeEach(^{
        injector = (id)[InjectorProvider injector];

        httpClient = fake_for([HTTPClient class]);
        [injector bind:[HTTPClient class] toInstance:httpClient];

        subject = [injector getInstance:[JSONClient class]];
    });

    describe(@"sending a request", ^{
        __block NSURLRequest *request;
        __block KSDeferred *httpDeferred;
        __block KSPromise *promise;

        beforeEach(^{
            httpDeferred = [KSDeferred defer];
            httpClient stub_method(@selector(sendRequest:)).and_return(httpDeferred.promise);

            request = fake_for([NSURLRequest class]);

            promise = [subject sendRequest:request];
        });

        it(@"makes a request to the correct url", ^{
            httpClient should have_received(@selector(sendRequest:)).with(request);
        });

        it(@"resolves the promise with the parsed JSON", ^{
            NSString *jsonString = @"{\"foo\": [\"bar\"]}";
            NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

            [httpDeferred resolveWithValue:data];

            NSDictionary *expectedJSON = @{
                @"foo": @[@"bar"]
            };

            promise.value should equal(expectedJSON);
        });

        it(@"rejects the promise when loading fails", ^{
            NSError *error = fake_for([NSError class]);

            [httpDeferred rejectWithError:error];

            promise.error should be_same_instance_as(error);
        });

        it(@"rejects the promise when JSON parsing fails", ^{
            [httpDeferred resolveWithValue:[NSData data]];

            promise.error should be_instance_of([NSError class]);
        });
    });
});

SPEC_END
