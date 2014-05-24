//
//  RootViewController.h
//  SQL
//
//  Created by iPhone SDK Articles on 10/26/08.
//  Copyright 2008 www.iPhoneSDKArticles.com.
//

#import <UIKit/UIKit.h>
#import "TabBarNavBarDemoAppDelegate.h"
#import "DetailViewController.h"
#import "ContactViewController.h"
#import "Add2ViewController.h"
#import "GroupDetailViewController.h"

@class Coffee, AddViewController, DetailViewController, Add2ViewController;
@class ContactViewController;
@class GroupDetailViewController;

@interface RootViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>{
    
    GroupDetailViewController *viewGroup;
    
    ContactViewController *viewContact;
	
	TabBarNavBarDemoAppDelegate *appDelegate;
	AddViewController *avController;
    Add2ViewController *av2Controller;
	DetailViewController *dvController;
	UINavigationController *addNavigationController;
    
    Add2ViewController *viewAdd;
    
    NSMutableArray *ids;
    NSMutableArray *names;
    NSMutableArray *thumbnails;
    
    NSMutableArray *groups;
    
    IBOutlet UITableView *tableView;
    IBOutlet UILabel *label;
    
}

//search
@property (strong, nonatomic) NSMutableArray* filteredTableData;

@property (retain, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, assign) bool isFiltered;


@property (retain, nonatomic) GroupDetailViewController *viewGroup;

@property (retain, nonatomic)UINavigationController *addNavigationController;

@property (retain, nonatomic) Add2ViewController *viewAdd;

@property (retain, nonatomic) NSMutableArray *ids;
@property (retain, nonatomic) NSMutableArray *names;
@property (retain, nonatomic) NSMutableArray *thumbnails;

@property (retain, nonatomic) NSMutableArray *groups;

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, retain)IBOutlet UILabel *label;;

@property (nonatomic, retain) DetailViewController *dvController;

@property (nonatomic, retain) ContactViewController *viewContact;



@end
