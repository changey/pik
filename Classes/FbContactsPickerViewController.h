//
//  FbContactsPickerViewController.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 3/1/14.
//
//

#import <UIKit/UIKit.h>
#import "FbGraph.h"

@interface FbContactsPickerViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
      FbGraph *fbGraph;

@private
    NSUInteger _selectedCount;
    NSMutableArray *contacts;
}

@property (nonatomic, retain) NSMutableArray *contacts;

@property (nonatomic, retain) FbGraph *fbGraph;

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
