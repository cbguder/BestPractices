#import "Cedar.h"
#import "SpecHelper+BestPractices.h"
#import "ArtistsPresenter.h"
#import "FakeCellPresenterDataSource.h"
#import "Artist.h"
#import "ArtistCellPresenter.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ArtistsPresenterSpec)

describe(@"ArtistsPresenter", ^{
    __block ArtistsPresenter *subject;
    __block id<BSBinder,BSInjector> injector;
    __block FakeCellPresenterDataSource *cellPresenterDataSource;
    __block UITableView *tableView;

    beforeEach(^{
        injector = [SpecHelper injector];

        cellPresenterDataSource = [[FakeCellPresenterDataSource alloc] init];
        [injector bind:[CellPresenterDataSource class] toInstance:cellPresenterDataSource];
        
        tableView = [[UITableView alloc] init];

        subject = [injector getInstance:[ArtistsPresenter class]];
    });
    
    it(@"should generate artist cell presenters and hand them over to the cell presenter data source", ^{
        NSArray *artists = @[
            fake_for([Artist class]),
            fake_for([Artist class]),
            fake_for([Artist class])
        ];

        [subject presentArtists:artists inTableView:tableView];
        
        cellPresenterDataSource.tableView should be_same_instance_as(tableView);

        [cellPresenterDataSource.cellPresenters count] should equal(3);

        for (int i = 0; i < 3; i++) {
            ArtistCellPresenter *cellPresenter = cellPresenterDataSource.cellPresenters[i];
            cellPresenter should be_instance_of([ArtistCellPresenter class]);
            cellPresenter.artist should be_same_instance_as(artists[i]);
        }
    });

    it(@"should register the cell types on the table view", ^{
        NSArray *artists = @[fake_for([Artist class])];
        
        [subject presentArtists:artists inTableView:tableView];
        
        ArtistCellPresenter *cellPresenter = [cellPresenterDataSource.cellPresenters firstObject];
        
        [tableView dequeueReusableCellWithIdentifier:cellPresenter.cellIdentifier] should_not be_nil;
    });
});

SPEC_END
