//
//  GroupSortViewController.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/21/14.
//
//

#import <UIKit/UIKit.h>
#import "GroupDetailViewController.h"

@interface GroupSortViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *groups;
    
    IBOutlet UITableView *tableView;
    
    GroupDetailViewController *viewGroup;
}

@property (strong, nonatomic) GroupDetailViewController *viewGroup;

@property (strong, nonatomic) NSMutableArray *groups;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
