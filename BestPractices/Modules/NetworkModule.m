#import "NetworkModule.h"
#import "KSNetworkClient.h"
#import "KSURLSessionClient.h"


@implementation NetworkModule

- (void)configure:(id <BSBinder>)binder {
    [binder bind:@protocol(KSNetworkClient) toClass:[KSURLSessionClient class]];
}

@end
