#import "CellPresenterDataSource.h"
#import "CellPresenter.h"


@interface CellPresenterDataSource ()

@property (nonatomic, copy) NSArray *cellPresenters;

@end


@implementation CellPresenterDataSource

- (void)displayCellPresenters:(NSArray *)cellPresenters inTableView:(UITableView *)tableView {
    self.cellPresenters = cellPresenters;

    tableView.dataSource = self;
    tableView.delegate = self;

    [tableView reloadData];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cellPresenters count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<CellPresenter> cellPresenter = self.cellPresenters[indexPath.row];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[cellPresenter cellIdentifier]];

    [cellPresenter presentInCell:cell];

    return cell;
}

@end
