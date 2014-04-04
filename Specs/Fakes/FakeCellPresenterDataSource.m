#import "FakeCellPresenterDataSource.h"


@interface FakeCellPresenterDataSource ()

@property (nonatomic) NSArray *cellPresenters;
@property (nonatomic) UITableView *tableView;

@end


@implementation FakeCellPresenterDataSource

- (void)displayCellPresenters:(NSArray *)cellPresenters inTableView:(UITableView *)tableView {
    self.cellPresenters = cellPresenters;
    self.tableView = tableView;
}

@end
