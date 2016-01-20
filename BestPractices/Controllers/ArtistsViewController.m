#import "ArtistsViewController.h"
#import "Blindside.h"
#import "ArtistsService.h"
#import "KSPromise.h"
#import "ArtistViewController.h"


@interface ArtistsViewController ()

@property (nonatomic) ArtistsPresenter *artistsPresenter;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) ArtistsService *artistsService;

@property (nonatomic, weak) id<BSInjector> injector;

@end


@implementation ArtistsViewController

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initWithArtistsPresenter:
                                                         artistsService:)
                                  argumentKeys:
            [ArtistsPresenter class],
            [ArtistsService class],
            nil];
}

- (instancetype)initWithArtistsPresenter:(ArtistsPresenter *)artistsPresenter
                          artistsService:(ArtistsService *)artistsService {
    self = [super init];
    if (self) {
        self.artistsPresenter = artistsPresenter;
        self.artistsPresenter.delegate = self;
        self.artistsService = artistsService;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Artists";

    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.tableView.frame = self.view.bounds;

    KSPromise *promise = [self.artistsService getArtists];
    [promise then:^id(NSArray *artists) {
        [self.artistsPresenter presentArtists:artists inTableView:self.tableView];
        return nil;
    } error:nil];
}

#pragma mark - <ArtistsPresenterDelegate>

- (void)artistsPresenterDidSelectArtist:(Artist *)artist {
    ArtistViewController *artistViewController = [self.injector getInstance:[ArtistViewController class]];
    [artistViewController setupWithArtist:artist];

    [self.navigationController pushViewController:artistViewController animated:YES];
}

@end
