#import "Cedar.h"
#import "ArtistsService.h"
#import "InjectorProvider.h"
#import "Blindside.h"
#import "RequestProvider.h"
#import "JSONClient.h"
#import "KSDeferred.h"
#import "Artist.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ArtistsServiceSpec)

describe(@"ArtistsService", ^{
    __block ArtistsService *subject;
    __block id<BSBinder, BSInjector> injector;
    __block RequestProvider *requestProvider;
    __block JSONClient *jsonClient;
    
    beforeEach(^{
        injector = (id)[InjectorProvider injector];

        requestProvider = fake_for([RequestProvider class]);
        [injector bind:[RequestProvider class] toInstance:requestProvider];

        jsonClient = fake_for([JSONClient class]);
        [injector bind:[JSONClient class] toInstance:jsonClient];

        subject = [injector getInstance:[ArtistsService class]];
    });

    describe(@"getting all artists", ^{
        __block KSDeferred *jsonDeferred;
        __block NSURLRequest *request;
        __block KSPromise *promise;

        beforeEach(^{
            request = fake_for([NSURLRequest class]);
            requestProvider stub_method(@selector(requestToGetArtists)).and_return(request);

            jsonDeferred = [KSDeferred defer];
            jsonClient stub_method(@selector(sendRequest:)).and_return(jsonDeferred.promise);

            promise = [subject getArtists];
        });

        it(@"makes a request", ^{
            jsonClient should have_received(@selector(sendRequest:)).with(request);
        });

        it(@"resolves the promise with an array of artists when the request succeeds", ^{
            NSString *fixturePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"artists" ofType:@"json"];
            NSData *fixtureData = [NSData dataWithContentsOfFile:fixturePath];
            NSArray *jsonArtists = [NSJSONSerialization JSONObjectWithData:fixtureData options:0 error:nil];
            [jsonDeferred resolveWithValue:jsonArtists];

            NSArray *artists = promise.value;
            artists.count should equal(3);

            Artist *artist1 = artists[0];
            artist1.artistId should equal(@"hugh-laurie");
            artist1.name should equal(@"Hugh Laurie");

            Artist *artist2 = artists[1];
            artist2.artistId should equal(@"nightwish");
            artist2.name should equal(@"Nightwish");

            Artist *artist3 = artists[2];
            artist3.artistId should equal(@"opeth");
            artist3.name should equal(@"Opeth");
        });

        it(@"rejects the promise with an error when the request fails", ^{
            NSError *error = fake_for([NSError class]);
            [jsonDeferred rejectWithError:error];

            promise.error should be_same_instance_as(error);
        });
    });
});

SPEC_END
