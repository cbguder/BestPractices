#import "Cedar.h"
#import "RequestProvider.h"
#import "InjectorProvider.h"
#import "Blindside.h"


using namespace Cedar::Matchers;
using namespace Cedar::Doubles;


SPEC_BEGIN(RequestProviderSpec)

describe(@"RequestProvider", ^{
    __block RequestProvider *subject;
    __block id<BSBinder, BSInjector> injector;

    beforeEach(^{
        injector = (id)[InjectorProvider injector];
        
        subject = [injector getInstance:[RequestProvider class]];
    });

    it(@"generates a request to get all artists", ^{
        NSURLRequest *request = [subject requestToGetArtists];

        request.URL should equal([NSURL URLWithString:@"https://raw.githubusercontent.com/cbguder/BestPractices/master/BestPracticesSpecs/Fixtures/artists.json"]);
    });
});

SPEC_END
