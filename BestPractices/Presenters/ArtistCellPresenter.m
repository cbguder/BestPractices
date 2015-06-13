#import "ArtistCellPresenter.h"
#import "Artist.h"


@interface ArtistCellPresenter ()
@property (nonatomic, readwrite) Artist *artist;
@end


@implementation ArtistCellPresenter

+ (void)registerInTableView:(UITableView *)tableView {
    return [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ArtistCell"];
}

- (instancetype)initWithArtist:(Artist *)artist {
    self = [super init];
    if (self) {
        self.artist = artist;
    }
    return self;
}

- (void)presentInCell:(UITableViewCell *)cell {
    cell.textLabel.text = self.artist.name;
}

- (NSString *)cellIdentifier {
    return @"ArtistCell";
}

@end
