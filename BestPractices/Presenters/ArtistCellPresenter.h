#import <Foundation/Foundation.h>
#import "CellPresenter.h"


@class Artist;


@interface ArtistCellPresenter : NSObject <CellPresenter>

@property (nonatomic, readonly) Artist *artist;

- (instancetype)initWithArtist:(Artist *)artist;

@end
