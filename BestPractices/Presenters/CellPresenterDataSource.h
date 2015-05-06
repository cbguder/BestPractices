#import <UIKit/UIKit.h>


@protocol CellPresenter;


@protocol CellPresenterDataSourceDelegate

- (void)cellPresenterDataSourceDidSelectCellPresenter:(id<CellPresenter>)cellPresenter;

@end


@interface CellPresenterDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<CellPresenterDataSourceDelegate> delegate;

- (void)displayCellPresenters:(NSArray *)cellPresenters inTableView:(UITableView *)tableView;

@end
