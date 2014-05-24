//
//  ContactEditViewController.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/14/14.
//
//

#import "ContactEditViewController.h"
#import "User.h"
#import "TKContact.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "ASIHTTPRequest.h"

@interface ContactEditViewController ()

@end

@implementation ContactEditViewController

@synthesize viewEdit, name, gender, job, university, email, tel, imgv, identifiedTagsString, tags, ranges;

//autocomplete
@synthesize tagsField = tagsField;
@synthesize pastUrls;
@synthesize autocompleteUrls;
@synthesize autocompleteTableView;

- (void) submitAll {
    User *user = [User sharedUser];
    //TODO-remove this
    //user.url = @"http://192.168.1.173/address_backend";
    //user.groupId = @"8";
    
    NSLog(@"%@", user.groupId);
    NSMutableDictionary *mutData = [[NSMutableDictionary alloc] init];
    [mutData setObject:user.groupId forKey:@"groupId"];
    [mutData setObject:user.user forKey:@"user"];
    NSMutableArray *contactMutArray = [NSMutableArray array];
    for (TKContact *contact in user.selected) {
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
    NSArray *contacts = [NSArray arrayWithArray:contactMutArray];
    [mutData setObject:contacts forKey:@"contacts"];
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
    [self submitAll];
}

- (void) updateContactInfo {
    User *user = [User sharedUser];
    int currentContactNumber = [user.currentContactNumber intValue];
    
    TKContact *updatedContact = [user.selected objectAtIndex:currentContactNumber];
    updatedContact.name = name.text;
    updatedContact.gender = gender.text;
    updatedContact.tagString = tagsField.text;
    updatedContact.university = university.text;
    updatedContact.job = job.text;
    updatedContact.email = email.text;
    updatedContact.tel = tel.text;
    
    [user.selected replaceObjectAtIndex:currentContactNumber withObject:updatedContact];
}

- (IBAction)nextAction:(id)sender
{
    User *user = [User sharedUser];
    int currentContactNumber = [user.currentContactNumber intValue];
    
    [self updateContactInfo];
    
    if (currentContactNumber < [user.totalContactsAdded intValue] - 1) {
        user.currentContactNumber = [NSString stringWithFormat:@"%d", currentContactNumber +1];
        ContactEditViewController *secondxib =
        [[ContactEditViewController alloc] initWithNibName:@"ContactEditViewController" bundle:[NSBundle mainBundle]];
        self.viewEdit = secondxib;
        [secondxib release];
        
        [self.navigationController pushViewController:self.viewEdit animated:YES];
    } else {
        [self submitAll];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    User *user = [User sharedUser];
    
    
    if ([user.currentContactNumber intValue] == [user.totalContactsAdded intValue] - 1) {
        [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(nextAction:)] autorelease]];
    } else {
        [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(nextAction:)] autorelease]];
    }
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //autocomplete
    self.pastUrls = [[NSMutableArray alloc] initWithObjects:@"MIT", @"startup", @"ninja", @"P&G", @"opensource", @"finance", @"Intel", @"Morgan Stanley",nil];
    
    //    NSString *url = [NSString stringWithFormat:@"http://54.200.250.29/pik_admin/tag_names.php"];  // server name does not match
    //
    //    NSURL *URL = [NSURL URLWithString:url];
    //
    //    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
    //
    //    [request startSynchronous];
    //    NSError *error = [request error];
    //    NSString *returnString;
    //    if (!error) {
    //        returnString = [request responseString];
    //        NSLog(@"%@",returnString);
    //    }
    //
    //    NSArray *json = [returnString JSONValue];
    //    NSMutableArray *tags = [[NSMutableArray alloc] init];
    //    int length = [json count];
    //    for (int i=0;i < length;i ++) {
    //        [tags addObject:[json objectAtIndex:i]];
    //    }
    //
    //    self.pastUrls = tags;
    
    self.autocompleteUrls = [[NSMutableArray alloc] init];
    self.tags = [[NSMutableArray alloc] init];
    self.ranges = [[NSMutableArray alloc] init];
    currentTagsRange = 0;
    
    user.autocompleteTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 157, 320, 120) style:UITableViewStylePlain];
    user.autocompleteTableView.delegate = self;
    user.autocompleteTableView.dataSource = self;
    user.autocompleteTableView.scrollEnabled = YES;
    user.autocompleteTableView.hidden = YES;
    [self.view addSubview:user.autocompleteTableView];
    //autocomplete ended
    
    TKContact *contact = [user.selected objectAtIndex:[user.currentContactNumber intValue]];
    name.text = contact.name;
    email.text = contact.email;
    NSString *rawPhoneNumber = contact.tel;
    NSString *outputPhoneNumber =@"";
    if ([rawPhoneNumber length] == 11) {
        NSString *phoneNoSpace = [contact.tel stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSLog(@"%@", phoneNoSpace);
        outputPhoneNumber = [self formatPhoneNumber:phoneNoSpace];
    } else {
        outputPhoneNumber = rawPhoneNumber;
    }
    
    tel.text = outputPhoneNumber;
    
    [self updateContactInfo];
    
}

//autocomplete
- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    [self.autocompleteUrls removeAllObjects];
    for(NSString *curString in self.pastUrls) {
        NSRange substringRange = [curString rangeOfString:substring];
        if (substringRange.location == 0) {
            [self.autocompleteUrls addObject:curString];
        }
    }
    User *user = [User sharedUser];
    [user.autocompleteTableView reloadData];
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //user is a singleton instance
    User *user = [User sharedUser];
    
    user.autocompleteTableView.hidden = NO;
    
    int identifiedTagsStringLength = [self.identifiedTagsString length];
    
    int cursorLocation = range.location;
    
    //insert characters
    if (range.location >= identifiedTagsStringLength) {
        
        NSString *newSearch =@"";
        NSRange newRange;
        if(identifiedTagsStringLength != 0) {
            newSearch = [tagsField.text substringFromIndex:identifiedTagsStringLength];
            newRange = NSMakeRange(range.location - identifiedTagsStringLength, 0);
        }
        else {
            newSearch = textField.text;
            newRange = range;
        }
        
        NSString *substring = [NSString stringWithString:newSearch];
        substring = [substring stringByReplacingCharactersInRange:newRange withString:string];
        [self searchAutocompleteEntriesWithSubstring:substring];
        
        if (cursorLocation > currentTagsRange) {
            currentTagsRange = cursorLocation;
        }
    }
    //delete tags
    else {
        if ([self.ranges count] != 0 && cursorLocation < currentTagsRange) {
            int rangeLength = [self.ranges count];
            int toBeRemovedIndex = 0;
            for (int i = 0; i< rangeLength; i++) {
                if (cursorLocation >= [[self.ranges objectAtIndex:i][0] intValue]
                    && cursorLocation <= [[self.ranges objectAtIndex:i][1] intValue]) {
                    toBeRemovedIndex = i;
                }
            }
            [self.tags removeObjectAtIndex:toBeRemovedIndex];
            [self updateRanges];
            NSString *outputString = @"";
            
            for (NSString *tag in self.tags) {
                outputString = [NSString stringWithFormat:@"%@#%@ ", outputString,
                                tag];
            }
            tagsField.text = outputString;
            self.identifiedTagsString = tagsField.text;
            currentTagsRange = [outputString length] - 1;
        }
    }
    
    return YES;
}

- (void)updateRanges {
    self.ranges = [[NSMutableArray alloc] init];
    int startIndex = 0;
    
    for (NSString *tag in self.tags) {
        startIndex = [self.ranges count] == 0 ? 0 : [[self.ranges lastObject][1] intValue] + 1;
        
        int tagLength = [tag length];
        NSArray  *range = [NSArray arrayWithObjects:[NSNumber numberWithInt:startIndex], [NSNumber numberWithInt:startIndex + tagLength + 1], nil];
        [self.ranges addObject: range];
    }
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return self.autocompleteUrls.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier] autorelease];
    }
    
    cell.textLabel.text = [self.autocompleteUrls objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (self.identifiedTagsString == NULL) {
        self.identifiedTagsString = @"";
    }
    [self.tags addObject: selectedCell.textLabel.text];
    
    [self updateRanges];
    
    NSString *output = @"";
    for (NSString *tag in self.tags) {
        output = [NSString stringWithFormat:@"%@#%@ ", output, tag];
    }
    
    tagsField.text = output;
    User *user = [User sharedUser];
    user.autocompleteTableView.hidden = YES;
    
    self.identifiedTagsString = tagsField.text;
    currentTagsRange = [tagsField.text length];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString *)formatPhoneNumber:(NSString *)unformattedNumber {
    NSMutableString *stringts = [NSMutableString stringWithString:unformattedNumber];
    [stringts insertString:@"(" atIndex:0];
    [stringts insertString:@")" atIndex:4];
    [stringts insertString:@"-" atIndex:8];
    NSString *output = stringts;
    return output;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
