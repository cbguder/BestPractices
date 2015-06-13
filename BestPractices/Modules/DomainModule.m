#import "DomainModule.h"
#import "ArtistCellPresenter.h"
#import "Artist.h"

@implementation DomainModule

- (void)configure:(id<BSBinder>)binder {
    [binder bind:[ArtistCellPresenter class] toBlock:^id(NSArray *args, id<BSInjector> injector) {
        Artist *artist = (Artist *)args.firstObject;
        return [[ArtistCellPresenter alloc] initWithArtist:artist];
    }];
}

@end
