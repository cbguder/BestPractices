#import "Cedar.h"
#import "InjectorProvider.h"
#import "Blindside.h"
#import "CellPresenterDataSource.h"
#import "CellPresenter.h"


using namespace Cedar::Matchers;
using namespace Cedar::Doubles;


SPEC_BEGIN(CellPresenterDataSourceSpec)

describe(@"CellPresenterDataSource", ^{
    __block CellPresenterDataSource *subject;
    __block id<BSBinder, BSInjector> injector;

    beforeEach(^{
        injector = (id)[InjectorProvider injector];

        subject = [injector getInstance:[CellPresenterDataSource class]];
        subject.delegate = nice_fake_for(@protocol(CellPresenterDataSourceDelegate));
    });

    describe(@"displaying cell presenters in a table view", ^{
        __block UITableView *tableView;
        __block NSArray *cellPresenters;

        id (^createCellPresenter)() = ^id {
            id cellPresenter = nice_fake_for(@protocol(CellPresenter));
            cellPresenter stub_method(@selector(cellIdentifier)).and_return(@"My Cell Identifier");
            return cellPresenter;
        };

        beforeEach(^{
            tableView = nice_fake_for([UITableView class]);

            cellPresenters = @[
                createCellPresenter(),
                createCellPresenter(),
                createCellPresenter()
            ];

            [subject displayCellPresenters:cellPresenters inTableView:tableView];
        });

        it(@"should set itself as the data source and delegate on the table view", ^{
            tableView should have_received(@selector(setDataSource:)).with(subject);
            tableView should have_received(@selector(setDelegate:)).with(subject);
        });

        it(@"should reload the table view", ^{
            tableView should have_received(@selector(reloadData));
        });

        it(@"should return the correct number of rows", ^{
            [subject tableView:tableView numberOfRowsInSection:0] should equal(3);
        });

        it(@"should use the cell presenters to configure the cells", ^{
            UITableViewCell *tableViewCell = fake_for([UITableViewCell class]);

            tableView stub_method(@selector(dequeueReusableCellWithIdentifier:)).with(@"My Cell Identifier").and_return(tableViewCell);

            UITableViewCell *cell = [subject tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];

            cellPresenters[2] should have_received(@selector(presentInCell:)).with(cell);
            cell should be_same_instance_as(tableViewCell);
        });

        it(@"should inform its delegate when a cell is tapped", ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            [subject tableView:tableView didSelectRowAtIndexPath:indexPath];

            subject.delegate should have_received(@selector(cellPresenterDataSourceDidSelectCellPresenter:)).with(cellPresenters[1]);
        });
    });
});

SPEC_END
