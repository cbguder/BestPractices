#import "ViewController.h"
#import "Blindside.h"
#import "ArtistsService.h"
#import "ArtistsPresenter.h"
#import "KSPromise.h"


@interface ViewController ()

@property (nonatomic) ArtistsPresenter *artistsPresenter;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) ArtistsService *apiClient;

@end


@implementation ViewController

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initWithArtistsPresenter:
                                                         apiClient:)
                                  argumentKeys:
            [ArtistsPresenter class],
            [ArtistsService class],
            nil];
}

- (id)initWithArtistsPresenter:(ArtistsPresenter *)artistsPresenter
                     apiClient:(ArtistsService *)apiClient {
    self = [super init];
    if (self) {
        self.artistsPresenter = artistsPresenter;
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

@end
