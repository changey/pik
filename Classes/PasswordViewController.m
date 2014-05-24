//
//  PasswordViewController.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/20/14.
//
//

#import "PasswordViewController.h"
#import "User.h"
#import "TKContact.h"
#import "NSString+TKUtilities.h"

@interface PasswordViewController ()

@end

@implementation PasswordViewController

@synthesize pass, contacts;

- (void) importPhoneBook {
    NSLog(@"lala");
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
                        NSString *rawPhone = [(NSString*)value telephoneWithReformat];
                        NSString *cutDots = [rawPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
                        contact.tel = [(NSString*)cutDots telephoneWithReformat];
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
    [self submitAll];
}

- (void) submitAll {
    User *user = [User sharedUser];
    //TODO-remove this
    //user.url = @"http://192.168.1.173/address_backend";
    //user.groupId = @"8";
    
    //NSLog(@"%@", user.groupId);
    user.groupId = @"0";
    NSMutableDictionary *mutData = [[NSMutableDictionary alloc] init];
    [mutData setObject:user.groupId forKey:@"groupId"];
    [mutData setObject:user.user forKey:@"user"];
    NSMutableArray *contactMutArray = [NSMutableArray array];
    for (TKContact *contact in self.contacts) {
        NSMutableDictionary *contactMutDict = [[NSMutableDictionary alloc] init];
        [contactMutDict setObject:contact.name  forKey:@"name"];
        [contactMutDict setObject:contact.gender  forKey:@"gender"];
        [contactMutDict setObject:contact.tagString forKey:@"tags"];
        [contactMutDict setObject:contact.university forKey:@"university"];
        [contactMutDict setObject:contact.job forKey:@"job"];
        [contactMutDict setObject:contact.email forKey:@"email"];
        [contactMutDict setObject:contact.tel forKey:@"tel"];
        NSDictionary *contactDict = [NSDictionary dictionaryWithDictionary:contactMutDict];
        [contactMutArray addObject:contactDict];
    }
    NSArray *contactArray = [NSArray arrayWithArray:contactMutArray];
    [mutData setObject:contactArray forKey:@"contacts"];
    NSDictionary *data = [NSDictionary dictionaryWithDictionary:mutData];
    
    NSError* error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    NSString *contactsJson = [[NSString alloc] initWithData:jsonData
                                                   encoding:NSUTF8StringEncoding];
    NSLog(@"%@", contactsJson);
    //user.selected
    //    NSString *contactsJson
    //    for (TKContact *contact in user.selected) {
    //        NSLog(@"contact name: %@", contact.name);
    //    }
    
    //contactsJson = @"[{\"name\":\"Pikachu\",\"groupId\":1}]";
    
    NSString *urlString = [NSString stringWithFormat:@"%@/contact_mult_info_insert.php", user.url];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    //NSString *groupNameStr = groupName.text;
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"contactsJson\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[contactsJson dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // now lets make the connection to the web
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", returnString);
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (IBAction)submit {
    
    [self importPhoneBook];
    User *user3=[User sharedUser];
    
    NSString *pass2=pass.text;
    NSString *user2 = user3.user;
    
    NSString *urlString = [NSString stringWithFormat:@"%@/post_signup.php?user=%@&pass=%@", user3.url, user2,pass2];
    NSString * replace = [urlString stringByReplacingOccurrencesOfString: @ " " withString: @ "%20"];
    NSLog(@"%@", replace);
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString: replace]];
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"the return string: %@", returnString);
    
    
    user3.user=user2;
    user3.pass=pass2;
    
    
    /*
    if([returnString isEqualToString:@"0"]){
        //    if([user2 isEqualToString:@"Wei.God"]){
        
        UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Error" message:@"That phone number already exists"
                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertsuccess show];
        [alertsuccess release];
    }
    else if([returnString isEqualToString:@"1"]){
        user3.user=user2;
        [self.navigationController dismissModalViewControllerAnimated:YES];
        // [[UAUser defaultUser] setAlias:@"changey"];
        //[[UAPush shared] setAlias:user2];
        
        //        if(self.mainVC == nil) {
        //            MainViewController *secondxib =
        //            [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:[NSBundle mainBundle]];
        //            self.mainVC = secondxib;
        //            [secondxib release];
        //        }
        //
        //        [self.navigationController pushViewController:self.mainVC animated:YES];
        
    }
    else{
        UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Error" message:@"That phone number already exists"
                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertsuccess show];
        [alertsuccess release];
    }*/

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.title = @"Setting Password";
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
