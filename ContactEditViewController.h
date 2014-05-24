//
//  ContactEditViewController.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/14/14.
//
//

#import <UIKit/UIKit.h>

@class ContactEditViewController;

@interface ContactEditViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    ContactEditViewController *viewEdit;
    
    IBOutlet UITextField *name;
    IBOutlet UITextField *gender;
    IBOutlet UITextField *job;
    IBOutlet UITextField *university;
    IBOutlet UITextField *email;
    IBOutlet UITextField *tel;
    IBOutlet UIImageView *imgv;
    
    //autocomlete
    IBOutlet UITextField *tagsField;
    NSMutableArray *pastUrls;
    NSMutableArray *autocompleteUrls;
    UITableView *autocompleteTableView;
    
    NSString *identifiedTagsString;
    NSMutableArray *tags;
    NSMutableArray *ranges;
    int currentTagsRange;
    BOOL deleteMode;
}

//autocomplete
@property (nonatomic, retain) UITextField *tagsField;
@property (nonatomic, retain) NSMutableArray *pastUrls;
@property (nonatomic, retain) NSMutableArray *autocompleteUrls;
@property (nonatomic, retain) UITableView *autocompleteTableView;

@property (nonatomic, retain) NSString *identifiedTagsString;
@property (nonatomic, retain) NSMutableArray *tags;
@property (nonatomic, retain) NSMutableArray *ranges;

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring;

@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet UITextField *gender;
@property (nonatomic, retain) IBOutlet UITextField *job;
@property (nonatomic, retain) IBOutlet UITextField *university;
@property (nonatomic, retain) IBOutlet UITextField *email;
@property (nonatomic, retain) IBOutlet UITextField *tel;
@property (nonatomic, retain) IBOutlet UIImageView *imgv;

@property (nonatomic, retain) ContactEditViewController *viewEdit;

-(IBAction)submit;

@end
