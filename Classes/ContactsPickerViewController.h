//
//  ContactsPickerViewController.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 2/27/14.
//
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "ContactEditViewController.h"

@class ContactEditViewController;

@interface ContactsPickerViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
    ContactEditViewController *viewEdit;
    
@private
    NSUInteger _selectedCount;
    NSMutableArray *_listContent;
    NSMutableArray *_filteredListContent;
    NSMutableArray *contacts;
    
    ABAddressBookRef addressBook;
    
    CFArrayRef allPeople;
    CFIndex nPeople;
    
}

@property (nonatomic, retain) ContactEditViewController *viewEdit;

@property (nonatomic, retain) NSMutableArray *contacts;

@property (nonatomic, assign) ABAddressBookRef addressBook;

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
