//
//  PasswordViewController.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/20/14.
//
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface PasswordViewController : UIViewController {
    IBOutlet UITextField *pass;
    
@private
    NSUInteger _selectedCount;
    NSMutableArray *_listContent;
    NSMutableArray *_filteredListContent;
    NSMutableArray *contacts;
    
    ABAddressBookRef addressBook;
    
    CFArrayRef allPeople;
    CFIndex nPeople;
}

@property (nonatomic, retain) IBOutlet UITextField *pass;

//import Contact
@property (nonatomic, retain) NSMutableArray *contacts;

@property (nonatomic, assign) ABAddressBookRef addressBook;

- (IBAction)submit;

@end
