#import "ArtistViewController.h"
#import "Artist.h"


@interface ArtistViewController ()

@property (nonatomic) Artist *artist;

@end


@implementation ArtistViewController

- (void)setupWithArtist:(Artist *)artist {
    self.artist = artist;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.artist.name;

    self.view.backgroundColor = [UIColor whiteColor];
}

@end
