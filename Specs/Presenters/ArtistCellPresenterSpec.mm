#import "Cedar.h"
#import "SpecHelper+BestPractices.h"
#import "ArtistCellPresenter.h"
#import "Artist.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ArtistCellPresenterSpec)

describe(@"ArtistCellPresenter", ^{
    __block ArtistCellPresenter *subject;
    __block id<BSBinder,BSInjector> injector;
    __block UITableViewCell *cell;

    beforeEach(^{
        injector = [SpecHelper injector];
        
        subject = [injector getInstance:[ArtistCellPresenter class]];
        
        subject.artist = [[Artist alloc] initWithId:@"1" name:@"Pink Floyd"];
        
        cell = [[UITableViewCell alloc] init];
        [subject presentInCell:cell];
    });
    
    it(@"should display the artist name", ^{
        cell.textLabel.text should equal(@"Pink Floyd");
    });
});

SPEC_END
