#import "RequestProvider.h"


@implementation RequestProvider

- (NSURLRequest *)requestToGetArtists {
    NSURL *URL = [NSURL URLWithString:@"https://raw.githubusercontent.com/cbguder/BestPractices/master/Specs/Fixtures/artists.json"];
    return [NSURLRequest requestWithURL:URL];
}

@end
