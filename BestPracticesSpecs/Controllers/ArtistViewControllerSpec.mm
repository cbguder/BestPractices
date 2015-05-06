#import "Cedar.h"
#import "ArtistViewController.h"
#import "InjectorProvider.h"
#import "Blindside.h"
#import "Artist.h"


using namespace Cedar::Matchers;
using namespace Cedar::Doubles;


SPEC_BEGIN(ArtistViewControllerSpec)

describe(@"ArtistViewController", ^{
    __block ArtistViewController *subject;
    __block id<BSBinder, BSInjector> injector;
    __block Artist *artist;

    beforeEach(^{
        injector = (id)[InjectorProvider injector];

        artist = fake_for([Artist class]);
        artist stub_method(@selector(name)).and_return(@"My Special Artist");

        subject = [injector getInstance:[ArtistViewController class]];
        [subject setupWithArtist:artist];
        subject.view should_not be_nil;
    });

    it(@"should display the artist's name", ^{
        subject.title should equal(@"My Special Artist");
    });
});

SPEC_END
