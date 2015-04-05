#import "Cedar.h"
#import "ArtistsViewController.h"
#import "InjectorProvider.h"
#import "Blindside.h"
#import "ArtistsPresenter.h"
#import "ArtistsService.h"
#import "KSDeferred.h"


using namespace Cedar::Matchers;
using namespace Cedar::Doubles;


SPEC_BEGIN(ArtistsViewControllerSpec)

describe(@"ArtistsViewController", ^{
    __block ArtistsViewController *subject;
    __block id<BSBinder, BSInjector> injector;
    __block ArtistsPresenter *artistsPresenter;
    __block ArtistsService *apiClient;

    __block void (^makeViewAppear)() = ^{
        [subject viewWillAppear:NO];
        [subject viewDidAppear:NO];
    };

    beforeEach(^{
        injector = (id)[InjectorProvider injector];

        artistsPresenter = nice_fake_for([ArtistsPresenter class]);
        [injector bind:[ArtistsPresenter class] toInstance:artistsPresenter];

        apiClient = nice_fake_for([ArtistsService class]);
        [injector bind:[ArtistsService class] toInstance:apiClient];

        subject = [injector getInstance:[ArtistsViewController class]];
        subject.view should_not be_nil;
    });

    describe(@"displaying artists", ^{
        __block KSDeferred *deferred;

        beforeEach(^{
            deferred = [KSDeferred defer];

            apiClient stub_method(@selector(getArtists)).and_return(deferred.promise);

            makeViewAppear();
        });

        it(@"should display the artists in the table view when they are fetched successfully", ^{
            NSArray *artists = fake_for([NSArray class]);

            [deferred resolveWithValue:artists];

            artistsPresenter should have_received(@selector(presentArtists:inTableView:)).with(artists, subject.tableView);
        });
    });
});

SPEC_END
