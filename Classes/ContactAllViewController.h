//
//  ContactAllViewController.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/20/14.
//
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ContactAllViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    
    NSMutableArray *contacts;
    
    IBOutlet UITableView *tableView;
}

@property (retain, nonatomic) NSMutableArray *contacts;
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
