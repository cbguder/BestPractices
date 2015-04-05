#import <Foundation/Foundation.h>


@interface Artist : NSObject

@property (nonatomic, copy, readonly) NSString *artistId;
@property (nonatomic, copy, readonly) NSString *name;

- (instancetype)initWithId:(NSString *)artistId name:(NSString *)name;

@end
