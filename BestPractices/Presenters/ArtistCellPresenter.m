#import "ArtistCellPresenter.h"
#import "Artist.h"


@implementation ArtistCellPresenter

+ (void)registerInTableView:(UITableView *)tableView {
    return [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ArtistCell"];
}

- (void)presentInCell:(UITableViewCell *)cell {
    cell.textLabel.text = self.artist.name;
}

- (NSString *)cellIdentifier {
    return @"ArtistCell";
}

@end
