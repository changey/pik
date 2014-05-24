//
//  LoginViewController.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 2/19/14.
//
//

#import <UIKit/UIKit.h>
#import "Signup2ViewController.h"
#import "ContactsPickerViewController.h"
#import "FbGraph.h"
#import "TKContactsMultiPickerController.h"
#import "FbContactsPickerViewController.h"

@class Signup2ViewController;
@class TPKeyboardAvoidingScrollView;
@class ContactsPickerViewController;
@class TKContactsMultiPickerController;
@class FbContactsPickerViewController;

@interface Add2ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    
    //autocomlete
    IBOutlet UITextField *urlField;
    NSMutableArray *pastUrls;
    NSMutableArray *autocompleteUrls;
    UITableView *autocompleteTableView;
    
    NSString *identifiedTagsString;
    NSMutableArray *tags;
    NSMutableArray *ranges;
    int currentTagsRange;
    BOOL deleteMode;
    
    //autocomplete ended
    
    FbContactsPickerViewController *viewFb;
    
    ContactsPickerViewController *viewContact;
    TKContactsMultiPickerController *viewPicker;
    
	IBOutlet UITextField *txtCoffeeName;
	IBOutlet UITextField *txtPrice;
    
    IBOutlet UITextField *groupName;
    IBOutlet UITextView *groupIntro;
    
    IBOutlet UIImageView *imgv;
    
    NSMutableArray *_allContacts;
}

//autocomplete
@property (nonatomic, retain) UITextField *urlField;
@property (nonatomic, retain) NSMutableArray *pastUrls;
@property (nonatomic, retain) NSMutableArray *autocompleteUrls;
@property (nonatomic, retain) UITableView *autocompleteTableView;

@property (nonatomic, retain) NSString *identifiedTagsString;
@property (nonatomic, retain) NSMutableArray *tags;
@property (nonatomic, retain) NSMutableArray *ranges;

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring;


@property (nonatomic, assign) ABAddressBookRef addressBook;

@property (nonatomic, retain) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

@property(nonatomic, retain) TKContactsMultiPickerController *viewPicker;

@property(nonatomic, retain) ContactsPickerViewController *viewContact;

@property (nonatomic, retain) FbContactsPickerViewController *viewFb;

@property (nonatomic, retain) TKContactsMultiPickerController *contactController;

@property (strong, nonatomic) IBOutlet UITextField *groupName;
@property (strong, nonatomic) IBOutlet UITextView *groupIntro;
@property (strong, nonatomic) IBOutlet UIImageView *imgv;

-(void) uploadInfo;
-(void) chooseFromPhoneBook;

-(IBAction)choosePhoto;
-(IBAction)foo;


-(IBAction)signup;

@end
