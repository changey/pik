//
//  ContactViewController.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 2/9/14.
//
//

#import <UIKit/UIKit.h>
#import "TKPeoplePickerController.h"
#import "TKContact.h"
#import "Add2ViewController.h"
#import "ContactsPickerViewController.h"
#import "ContactDetailViewController.h"
#import <MessageUI/MessageUI.h>

@class Add2ViewController;
@class ContactsPickerViewController;
@class ContactDetailViewController;

@interface ContactViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, TKPeoplePickerControllerDelegate, TKContactsMultiPickerControllerDelegate, MFMailComposeViewControllerDelegate>{
    
    NSMutableArray *ids;
    NSMutableArray *names;
    NSMutableArray *thumbnails;
    NSMutableArray *contacts;
    
    IBOutlet UITableView *tableView;
    
    int deleteMode;
    
    Add2ViewController *av2Controller;
    ContactsPickerViewController *viewContact;
    ContactDetailViewController *viewDetail;
    
    UINavigationController *addNavigationController;
    
    NSMutableArray *favorites;
}

//search
@property (strong, nonatomic) NSMutableArray* filteredTableData;
@property (retain, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, assign) bool isFiltered;

@property (retain, nonatomic) NSMutableArray *favorites;

@property (retain, nonatomic) ContactDetailViewController *viewDetail;
@property (retain, nonatomic) ContactsPickerViewController *viewContact;
@property (retain, nonatomic) Add2ViewController *av2Controller;

@property (retain, nonatomic)UINavigationController *addNavigationController;

@property (nonatomic, assign) ABAddressBookRef addressBook;
@property (nonatomic, retain) TKContactsMultiPickerController *contactController;

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) NSMutableArray *ids;
@property (retain, nonatomic) NSMutableArray *names;
@property (retain, nonatomic) NSMutableArray *thumbnails;
@property (retain, nonatomic) NSMutableArray *contacts;

-(void)retrieve_table;
-(void)contact_insert;

- (IBAction) clickAddButton;

@end
