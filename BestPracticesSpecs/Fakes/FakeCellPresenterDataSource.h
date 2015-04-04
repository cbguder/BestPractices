#import "CellPresenterDataSource.h"


@interface FakeCellPresenterDataSource : CellPresenterDataSource

@property (nonatomic, readonly) NSArray *cellPresenters;
@property (nonatomic, readonly) UITableView *tableView;

@end
