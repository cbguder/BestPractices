#import <UIKit/UIKit.h>
#import "CellPresenterDataSource.h"


@class Artist;


@protocol ArtistsPresenterDelegate

- (void)artistsPresenterDidSelectArtist:(Artist *)artist;

@end


@interface ArtistsPresenter : NSObject <CellPresenterDataSourceDelegate>

@property (nonatomic, weak) id<ArtistsPresenterDelegate> delegate;

- (void)presentArtists:(NSArray *)artists inTableView:(UITableView *)tableView;

@end
