#import <UIKit/UIKit.h>

@interface CellPresenterDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

- (void)displayCellPresenters:(NSArray *)cellPresenters inTableView:(UITableView *)tableView;

@end
