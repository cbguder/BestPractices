#import "Cedar.h"
#import "SpecHelper+BestPractices.h"
#import "ViewController.h"
#import "Blindside.h"
#import "ArtistsPresenter.h"
#import "APIClient.h"
#import "KSDeferred.h"


using namespace Cedar::Matchers;
using namespace Cedar::Doubles;


SPEC_BEGIN(ViewControllerSpec)

describe(@"ViewController", ^{
    __block ViewController *subject;
    __block id<BSBinder,BSInjector> injector;
    __block ArtistsPresenter *artistsPresenter;
    __block APIClient *apiClient;

    __block void (^makeViewAppear)() = ^{
        [subject viewWillAppear:NO];
        [subject viewDidAppear:NO];
    };

    beforeEach(^{
        injector = [SpecHelper injector];

        artistsPresenter = nice_fake_for([ArtistsPresenter class]);
        [injector bind:[ArtistsPresenter class] toInstance:artistsPresenter];

        apiClient = nice_fake_for([APIClient class]);
        [injector bind:[APIClient class] toInstance:apiClient];

        subject = [injector getInstance:[ViewController class]];
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
