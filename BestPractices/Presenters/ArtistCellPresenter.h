#import <Foundation/Foundation.h>
#import "CellPresenter.h"


@class Artist;


@interface ArtistCellPresenter : NSObject <CellPresenter>

@property (nonatomic) Artist *artist;

@end
