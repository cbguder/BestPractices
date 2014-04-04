#import "Artist.h"


@interface Artist ()

@property (nonatomic, copy) NSString *artistId;
@property (nonatomic, copy) NSString *name;

@end


@implementation Artist

- (id)initWithId:(NSString *)artistId name:(NSString *)name {
    self = [super init];
    if (self) {
        self.artistId = artistId;
        self.name = name;
    }
    return self;
}

@end
