//
//  ContactsPickerViewController.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 2/27/14.
//
//

#import "ContactsPickerViewController.h"
#import "CustomCell.h"
#import "TKContact.h"
#import "NSString+TKUtilities.h"
#import "User.h"

@interface ContactsPickerViewController ()

@end

@implementation ContactsPickerViewController
@synthesize contacts, viewEdit;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _listContent = [NSMutableArray new];
        _filteredListContent = [NSMutableArray new];
        self.contacts = [NSMutableArray new];
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    // Request authorization to Address Book
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            if (granted) {
                
                // First time access has been granted, add the contact
               // [self _addContactToAddressBook];
            } else {
                // User denied access
                // Display an alert telling user the contact could not be added
            }
        });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        // The user has previously given access, add the contact
       // [self _addContactToAddressBook];
    }
    else {
        // The user has previously denied access
        // Send an alert telling user to change privacy setting in settings app
    }
    
    NSMutableArray *contactsTemp = [NSMutableArray array];
    ABAddressBookRef addressBook = ABAddressBookCreate();
    
    allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    nPeople = ABAddressBookGetPersonCount(addressBook);
    
    NSMutableArray *masterList = [[NSMutableArray alloc] init];
    for (int i = 0; i < nPeople; i++) {
        ABRecordRef ref = CFArrayGetValueAtIndex(allPeople, i);
        CFStringRef abName = ABRecordCopyValue(ref, kABPersonFirstNameProperty);
        CFStringRef abLastName = ABRecordCopyValue(ref, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(ref);
        
        CFStringRef abEmail = ABRecordCopyValue(ref, kABPersonEmailProperty);
        
        TKContact *contact = [[TKContact alloc] init];
        
        NSString *fullNameString;
        NSString *firstString = (NSString *)abName;
        NSString *lastNameString = (NSString *)abLastName;
        
        NSString *emailString = (NSString *)abEmail;
        
        if ((id)abFullName != nil) {
            fullNameString = (NSString *)abFullName;
        } else {
            if ((id)abLastName != nil)
            {
                fullNameString = [NSString stringWithFormat:@"%@ %@", firstString, lastNameString];
            }
        }
        
        contact.name = fullNameString;
        contact.recordID = (int)ABRecordGetRecordID(ref);
        contact.rowSelected = NO;
        contact.lastName = (NSString*)abLastName;
        contact.firstName = (NSString*)abName;
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(ref, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFStringRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        contact.tel = [(NSString*)value telephoneWithReformat];
                        break;
                    }
                    case 1: {// Email
                        contact.email = (NSString*)value;
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        
        [contactsTemp addObject:contact];
        [contact release];
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
        
    }
    
    self.contacts = contactsTemp;
    
    if (allPeople) CFRelease(allPeople);
    
    // Sort data
    UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];
    
    // Thanks Steph-Fongo!
    SEL sorter = ABPersonGetSortOrdering() == kABPersonSortByFirstName ? NSSelectorFromString(@"sorterFirstName") : NSSelectorFromString(@"sorterLastName");
    
    for (TKContact *contact in contactsTemp) {
        NSInteger sect = [theCollation sectionForObject:contact
                                collationStringSelector:sorter];
        contact.sectionNumber = sect;
    }
    
    NSInteger highSection = [[theCollation sectionTitles] count];
    NSMutableArray *sectionArrays = [NSMutableArray arrayWithCapacity:highSection];
    for (int i=0; i<=highSection; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sectionArrays addObject:sectionArray];
    }
    
    for (TKContact *contact in contactsTemp) {
        [(NSMutableArray *)[sectionArrays objectAtIndex:contact.sectionNumber] addObject:contact];
    }
    
    for (NSMutableArray *sectionArray in sectionArrays) {
        NSArray *sortedSection = [theCollation sortedArrayFromArray:sectionArray collationStringSelector:sorter];
        [_listContent addObject:sortedSection];
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setLeftBarButtonItem:nil];
    [self.navigationItem setTitle:NSLocalizedString(@"Contacts", nil)];
    [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissAction:)] autorelease]];
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //   return [appDelegate.coffeeArray count];
    //return [names count];
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        return [_filteredListContent count];
//    } else {
//        NSLog(@"%d", [[_listContent objectAtIndex:section] count]);
//        return [[_listContent objectAtIndex:section] count];
//    }
    return [self.contacts count];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 80;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *kCustomCellID = @"TKPeoplePickerControllerCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomCellID];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	TKContact *contact = nil;
//	if (tableView == self.searchDisplayController.searchResultsTableView)
//        contact = (TKContact *)[_filteredListContent objectAtIndex:indexPath.row];
//	else
        contact = (TKContact *)[self.contacts objectAtIndex:indexPath.row];
    
    if ([[contact.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0) {
        cell.textLabel.text = contact.name;
    } else {
        cell.textLabel.font = [UIFont italicSystemFontOfSize:cell.textLabel.font.pointSize];
        cell.textLabel.text = @"No Name";
    }
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setFrame:CGRectMake(30.0, 0.0, 28, 28)];
	[button setBackgroundImage:[UIImage imageNamed:@"uncheckBox.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateSelected];
	[button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    [button setSelected:contact.rowSelected];
    
	cell.accessoryView = button;
	
	return cell;
    
    
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	TKContact *contact = nil;
    
//	if (tableView == self.searchDisplayController.searchResultsTableView)
//		contact = (TKContact*)[_filteredListContent objectAtIndex:indexPath.row];
//	else
//        contact = (TKContact*)[[_listContent objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    contact = [self.contacts objectAtIndex:indexPath.row];
    
    //NSLog(@"%@", contact.name);
//    
    BOOL checked = !contact.rowSelected;
    contact.rowSelected = checked;
    
    // Enabled rightButtonItem
    if (checked) _selectedCount++;
    else _selectedCount--;
    if (_selectedCount > 0) {
        [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)] autorelease]];
        
    }
    else {
        [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissAction:)] autorelease]];
    }
    
    UITableViewCell *cell =[self.tableView cellForRowAtIndexPath:indexPath];
    UIButton *button = (UIButton *)cell.accessoryView;
    [button setSelected:checked];
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        [self.searchDisplayController.searchResultsTableView reloadData];
    }
}

- (void)checkButtonTapped:(id)sender event:(id)event
{
	NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.tableView];
	NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
	
	if (indexPath != nil)
	{
		[self tableView:self.tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
	}
}

#pragma mark -
#pragma mark Save action

- (IBAction)doneAction:(id)sender
{
    User *user = [User sharedUser];
    
    user.selected = [NSMutableArray new];
    user.select_mode=@"1";
    
	NSMutableArray *objects = [NSMutableArray new];
    
    for (TKContact *contact in contacts) {
        if (contact.rowSelected){
            [user.selected addObject:contact];
            [objects addObject:contact];

            NSLog(@"%@", contact.tel);
        }
    }
    user.totalContactsAdded = [NSString stringWithFormat:@"%d", [user.selected count]];
    user.currentContactNumber = @"0";
    
    ContactEditViewController *secondxib =
    [[ContactEditViewController alloc] initWithNibName:@"ContactEditViewController" bundle:[NSBundle mainBundle]];
    self.viewEdit = secondxib;
    [secondxib release];
    
    [self.navigationController pushViewController:self.viewEdit animated:YES];
    
	[objects release];
}

- (IBAction)dismissAction:(id)sender
{
    //Dismiss the controller.
	[self.navigationController dismissModalViewControllerAnimated:YES];

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    User *user=[User sharedUser];
//    user.groupId=[ids objectAtIndex:indexPath.row];
//    
//    if(self.viewContact == nil) {
//        ContactViewController *secondxib =
//        [[ContactViewController alloc] initWithNibName:@"ContactViewController" bundle:[NSBundle mainBundle]];
//        self.viewContact = secondxib;
//        [secondxib release];
//    }
//    
//    [self.navigationController pushViewController:self.viewContact animated:YES];
	
}


@end
