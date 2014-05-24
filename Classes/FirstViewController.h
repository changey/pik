//
//  FirstViewController.h
//  TabBarNavBarDemo
//
//  Created by James Lin on 19/07/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarNavBarDemoAppDelegate.h"
#import "DetailViewController.h"
#import "ContactViewController.h"

@class Coffee, AddViewController, DetailViewController;
@class ContactViewController;

@interface FirstViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{

    ContactViewController *viewContact;
	
	TabBarNavBarDemoAppDelegate *appDelegate;
	AddViewController *avController;
	DetailViewController *dvController;
	UINavigationController *addNavigationController;
    
    NSMutableArray *ids;
    NSMutableArray *names;
    NSMutableArray *thumbnails;
    
    IBOutlet UITableView *tableView;
    IBOutlet UILabel *label;
}

@property (retain, nonatomic) NSMutableArray *ids;
@property (retain, nonatomic) NSMutableArray *names;
@property (retain, nonatomic) NSMutableArray *thumbnails;

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, retain)IBOutlet UILabel *label;;

@property (nonatomic, retain) DetailViewController *dvController;

@property (nonatomic, retain) ContactViewController *viewContact;

@end
