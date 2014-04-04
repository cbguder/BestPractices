#import <UIKit/UIKit.h>

@protocol CellPresenter <NSObject>

+ (void)registerInTableView:(UITableView *)tableView;

- (void)presentInCell:(UITableViewCell *)cell;

- (NSString *)cellIdentifier;

@end
