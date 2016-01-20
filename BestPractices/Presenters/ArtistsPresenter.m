#import "ArtistsPresenter.h"
#import "Blindside.h"
#import "Artist.h"
#import "ArtistCellPresenter.h"


@interface ArtistsPresenter ()

@property (nonatomic) CellPresenterDataSource *cellPresenterDataSource;

@property (nonatomic, weak) id<BSInjector> injector;

@end


@implementation ArtistsPresenter

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initWithCellPresenterDataSource:)
                                  argumentKeys:[CellPresenterDataSource class], nil];
}

- (instancetype)initWithCellPresenterDataSource:(CellPresenterDataSource *)cellPresenterDataSource {
    self = [super init];
    if (self) {
        self.cellPresenterDataSource = cellPresenterDataSource;
        self.cellPresenterDataSource.delegate = self;
    }
    return self;
}

- (void)presentArtists:(NSArray *)artists inTableView:(UITableView *)tableView {
    [ArtistCellPresenter registerInTableView:tableView];

    NSMutableArray *cellPresenters = [NSMutableArray arrayWithCapacity:artists.count];
    
    for (Artist *artist in artists) {
        ArtistCellPresenter *cellPresenter = [self.injector getInstance:[ArtistCellPresenter class]];
        cellPresenter.artist = artist;
        [cellPresenters addObject:cellPresenter];
    }
    
    [self.cellPresenterDataSource displayCellPresenters:cellPresenters inTableView:tableView];
}

#pragma mark - <CellPresenterDataSourceDelegate>

- (void)cellPresenterDataSourceDidSelectCellPresenter:(ArtistCellPresenter *)artistCellPresenter {
    [self.delegate artistsPresenterDidSelectArtist:artistCellPresenter.artist];
}

@end
