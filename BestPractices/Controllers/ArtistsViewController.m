#import "ArtistsViewController.h"
#import "Blindside.h"
#import "ArtistsService.h"
#import "KSPromise.h"
#import "ArtistViewController.h"


@interface ArtistsViewController ()

@property (nonatomic) ArtistsPresenter *artistsPresenter;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) ArtistsService *apiClient;
@property (nonatomic, weak) id<BSInjector> injector;

@end


@implementation ArtistsViewController

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initWithArtistsPresenter:
                                                         apiClient:)
                                  argumentKeys:
            [ArtistsPresenter class],
            [ArtistsService class],
            nil];
}

- (instancetype)initWithArtistsPresenter:(ArtistsPresenter *)artistsPresenter
                               apiClient:(ArtistsService *)apiClient {
    self = [super init];
    if (self) {
        self.artistsPresenter = artistsPresenter;
        self.artistsPresenter.delegate = self;
        self.apiClient = apiClient;
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

    KSPromise *promise = [self.apiClient getArtists];

    __weak typeof(self) weakSelf = self;
    [promise then:^id(NSArray *artists) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        [strongSelf.artistsPresenter presentArtists:artists inTableView:strongSelf.tableView];

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
