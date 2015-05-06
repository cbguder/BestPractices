#import <UIKit/UIKit.h>
#import "ArtistsPresenter.h"


@interface ArtistsViewController : UIViewController <ArtistsPresenterDelegate>

@property (nonatomic, readonly) UITableView *tableView;

@end
