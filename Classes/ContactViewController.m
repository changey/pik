//
//  ContactViewController.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 2/9/14.
//
//

#import "ContactViewController.h"
#import "ContactsCell.h"
#import "User.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
//#import "IsAdmin.h"
#import "TabBarNavBarDemoAppDelegate.h"
#define myAppDelegate (TabBarNavBarDemoAppDelegate *) [[UIApplication sharedApplication] delegate]


@interface ContactViewController ()

@end

@implementation ContactViewController

@synthesize ids, av2Controller, addNavigationController, viewContact, viewDetail, contacts, favorites;

//search
@synthesize filteredTableData;
@synthesize searchBar;
@synthesize isFiltered;

#pragma mark - Table view delegate

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    User *user = [User sharedUser];
    
    //NSLog(@"%@", user.isAdmin);
    if ([user.isAdmin isEqualToString:@"1"]) {
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
    
    //IsAdmin *isAdminInstance =[[IsAdmin alloc] init];
    
    //[isAdminInstance isAdmin:@"1" userId:@"a"];
    
    //[self contact_insert];
    
    [self retrieve_table];
    
    [self.tableView reloadData];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
    //											 initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
    //											 target:self action:@selector(add_Clicked:)];
    [self.navigationController setToolbarHidden:YES animated:NO];
    
    self.favorites = [[NSMutableArray alloc] init];
    
}

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    if(text.length == 0)
    {
        isFiltered = FALSE;
    }
    else
    {
        isFiltered = true;
        self.filteredTableData = [[NSMutableArray alloc] init];
        
//        for (Group* group in self.groups)
//        {
//            NSRange nameRange = [group.name rangeOfString:text options:NSCaseInsensitiveSearch];
//            NSRange tagStringRange = [group.tagString rangeOfString:text options:NSCaseInsensitiveSearch];
//            NSLog(@"tagString: %@", group.tagString);
//            if(nameRange.location != NSNotFound || tagStringRange.location != NSNotFound)
//                //if(nameRange.location != NSNotFound)
//            {
//                [self.filteredTableData addObject:group];
//            }
//        }
//        NSLog(@"filterLength: %d", [self.filteredTableData count]);
        
    }
    
    [self.tableView reloadData];
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
    [super viewDidLoad];
    
    
//	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]						initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
//											 target:self action:@selector(add_Clicked:)];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction) clickAddButton {
//- (void) add_Clicked:(id)sender {
    
    if(av2Controller == nil) {
		av2Controller = [[Add2ViewController alloc] initWithNibName:@"Add2ViewController" bundle:nil];
    }
    
    if (viewContact == nil) {
        viewContact = [[ContactsPickerViewController alloc] initWithNibName:@"ContactViewController" bundle:nil];
    }
    
	
	//if(addNavigationController == nil)
    addNavigationController = [[UINavigationController alloc] initWithRootViewController:viewContact];
    
    [myAppDelegate presentModal:addNavigationController];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.editing ;
    //return YES;
}

- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if(editingStyle == UITableViewCellEditingStyleDelete) {
		//Get the object to delete from the array.
//		Coffee *coffeeObj = [appDelegate.coffeeArray objectAtIndex:indexPath.row];
//		[appDelegate removeCoffee:coffeeObj];
		
		//Delete the object from the table.
		//[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
       // [self deleteContact:[ids objectAtIndex:indexPath.row]];
        TKContact *contact = [self.contacts objectAtIndex:indexPath.row];
        [self deleteContact:contact.ide];

        [self.contacts removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
	}
}

- (void) deleteContact:(NSString *)userId {
    
    User *user = [User sharedUser];
    
    NSString *url = [NSString stringWithFormat:@"%@/contact_delete.php?userId=%@", user.url, userId];
   // NSString * replace = [url stringByReplacingOccurrencesOfString: @ " " withString: @ "%20"];
    
    NSURL *URL = [NSURL URLWithString:url];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
    
    [request startSynchronous];
    NSError *error = [request error];
    NSString *returnString;
    if (!error) {
        returnString = [request responseString];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
    //[tableView setEditing:NO animated:YES];
	
	//Do not let the user add if the app is in edit mode.
	if(editing) {
		self.navigationItem.leftBarButtonItem.enabled = NO;
    }
	else {
		self.navigationItem.leftBarButtonItem.enabled = YES;
    }
}

-(void) contact_insert {
    
    User *user=[User sharedUser];
    
    if([user.select_mode isEqualToString:@"1"]){
        
        int length = [user.selected count];
        
        for (int i=0; i<length;i++){
            
            TKContact *contact= [user.selected objectAtIndex:i];
            
            NSString *url = [NSString stringWithFormat:@"%@/contact_insert.php?name=%@", user.url, contact.name];
            NSString * replace = [url stringByReplacingOccurrencesOfString: @ " " withString: @ "%20"];
            
            NSURL *URL = [NSURL URLWithString:replace];
            
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
            
            [request startSynchronous];
            NSError *error = [request error];
            NSString *returnString;
            if (!error) {
                returnString = [request responseString];
                //NSLog(@"%@",returnString);
            }
        }
        user.select_mode=@"0";
    }
}

-(void) retrieve_table {
    
    User *user=[User sharedUser];
    
    NSString *url = [NSString stringWithFormat:@"%@/contacts.php?groupId=%@&user=%@", user.url, user.groupId, user.user];  // server name does not match
    
    NSURL *URL = [NSURL URLWithString:url];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
    
    [request startSynchronous];
    NSError *error = [request error];
    NSString *returnString;
    if (!error) {
        // NSData* data = [request responseData];
        // returnString =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        returnString = [request responseString];
        NSLog(@"%@", returnString);
    }
    
    NSLog(@"%@", url);
    
    NSArray *json = [returnString JSONValue];
    
    self.contacts = [[NSMutableArray alloc] init];

    int length = [json count];

    for (int i=0; i<length;i++){
        TKContact *contact = [[TKContact alloc] init];
        contact.ide = [[json objectAtIndex:i] objectForKey:@"id"];
        contact.name = [[json objectAtIndex:i] objectForKey:@"name"];
        contact.gender = [[json objectAtIndex:i] objectForKey:@"gender"];
        contact.job = [[json objectAtIndex:i] objectForKey:@"job"];
        contact.university = [[json objectAtIndex:i] objectForKey:@"university"];
        contact.email = [[json objectAtIndex:i] objectForKey:@"email"];
        contact.tel = [[json objectAtIndex:i] objectForKey:@"tel"];
        contact.thumbnail = [[json objectAtIndex:i] objectForKey:@"thumbnail"];
        contact.rowSelected = [[[json objectAtIndex:i] objectForKey:@"favorites"] boolValue];
        contact.tagString = [[json objectAtIndex:i] objectForKey:@"tagString"];
        
        [self.contacts addObject:contact];
        //NSLog(@"%@", contact.tagString);
        
    }
    //
    [self.tableView reloadData];
}

- (void) back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contacts count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

void UIImageFromURL( NSURL * URL, void (^imageBlock)(UIImage * image), void (^errorBlock)(void) )
{
    dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^(void)
                   {
                       NSData * data = [[[NSData alloc] initWithContentsOfURL:URL] autorelease];
                       UIImage * image = [[[UIImage alloc] initWithData:data] autorelease];
                       dispatch_async( dispatch_get_main_queue(), ^(void){
                           if( image != nil )
                           {
                               imageBlock( image );
                           } else {
                               errorBlock();
                           }
                       });
                   });
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CustomCell";
	
    ContactsCell *cell = (ContactsCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ContactsCell" owner:self options:nil];
		
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (ContactsCell *) currentObject;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
				break;
			}
		}
	}

    User *user = [User sharedUser];
    
//    arrFloorNames = [arrFloorNames sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
//    NSLog(@"%@",arrFloorNames);
    TKContact *contact = [self.contacts objectAtIndex:indexPath.row];
    cell.name.text = contact.name;
    cell.tagString.text = contact.tagString;
    cell.job.text = contact.job;
    cell.university.text =contact.university;
    
    UIImage * image;
    NSString *thumbnailStr = contact.thumbnail;

    if (![thumbnailStr isEqualToString:@""]) {
        NSURL * imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", user.url, thumbnailStr]];
        NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
        image = [UIImage imageWithData:imageData];
    } else {
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"default-profile" ofType:@"png"];
        image = [UIImage imageWithContentsOfFile:imagePath];
    }
    
    cell.imgv.image=image;
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//	[button setFrame:CGRectMake(30.0, 0.0, 28, 28)];
//	[button setBackgroundImage:[UIImage imageNamed:@"star_unfilled.png"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"star_filled.png"] forState:UIControlStateSelected];
//	[button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
//    [button setSelected:contact.rowSelected];
    [cell.tel addTarget:self action:@selector(telButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.tel setSelected:contact.rowSelected];
    [cell.email addTarget:self action:@selector(emailButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.email setSelected:contact.rowSelected];
    
	cell.accessoryView = cell.tel;
    
    
//    cell.imgv.image=[UIImage imageNamed:@"logo57.png"];
//    cell.name.text=[senders objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)emailButtonTapped:(id)sender event:(id)event
{
	NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.tableView];
	NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    TKContact *contact = [self.contacts objectAtIndex:indexPath.row];
    NSString *email = contact.email;

    //recipient(s)
    NSArray * recipients = [NSArray arrayWithObjects:email, nil];
    
    //create the MFMailComposeViewController
    MFMailComposeViewController * composer = [[MFMailComposeViewController alloc] init];
    composer.mailComposeDelegate = self;
    [composer setToRecipients:recipients];
    
    //present it on the screen
    [self presentViewController:composer animated:YES completion:NULL];
}

#pragma mark - MFMailComposeViewControllerDelegate methods
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)telButtonTapped:(id)sender event:(id)event
{
	NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.tableView];
	NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    TKContact *contact = [self.contacts objectAtIndex:indexPath.row];
    NSString *tel = [NSString stringWithFormat:@"tel:%@", contact.tel];
    NSString *cutOpenedParen = [tel stringByReplacingOccurrencesOfString:@"(" withString:@""];
    NSString *cutClosedParen = [cutOpenedParen stringByReplacingOccurrencesOfString:@")" withString:@""];
    NSString *cutDash = [cutClosedParen stringByReplacingOccurrencesOfString:@"-" withString:@""];

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:cutDash]];
}

- (void)checkButtonTapped:(id)sender event:(id)event
{
	NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.tableView];
	NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
   // NSLog(@"%d", indexPath.row);
	
	if (indexPath != nil)
	{
		[self tableView:self.tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
	}
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
    User *user = [User sharedUser];
    
    //user.url =@"http://18.111.4.222";
    
    if (checked == YES) {
//        NSString *url = [NSString stringWithFormat:@"%@/address_backend/favorite_insert.php?contactId=%@&groupId=%@&user=%@", user.url, contact.ide, user.groupId, user.user];
        NSString *url = [NSString stringWithFormat:@"%@/favorite_insert.php?contactId=%@&groupId=%@&user=%@", user.url, contact.ide, user.groupId, user.user];
        
        NSURL *URL = [NSURL URLWithString:url];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
        [request startSynchronous];
        NSError *error = [request error];
        NSString *returnString;
        if (!error) {
            returnString = [request responseString];
           // NSLog(@"%@",returnString);
        }
    }
    else {
//        NSString *url = [NSString stringWithFormat:@"%@/address_backend/favorite_delete.php?contactId=%@&groupId=%@&user=%@", user.url, contact.ide, user.groupId, user.user];
        NSString *url = [NSString stringWithFormat:@"%@/favorite_delete.php?contactId=%@&groupId=%@&user=%@", user.url, contact.ide, user.groupId, user.user];
        
        NSURL *URL = [NSURL URLWithString:url];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
        [request startSynchronous];
        NSError *error = [request error];
        NSString *returnString;
        if (!error) {
            returnString = [request responseString];
            NSLog(@"%@",returnString);
        }
    }
    
    // Enabled rightButtonItem
//    if (checked) _selectedCount++;
//    else _selectedCount--;
//    if (_selectedCount > 0) {
//        [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)] autorelease]];
//        
//    }
//    else {
//        [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissAction:)] autorelease]];
//    }
    
    UITableViewCell *cell =[self.tableView cellForRowAtIndexPath:indexPath];
    UIButton *button = (UIButton *)cell.accessoryView;
    [button setSelected:checked];
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        [self.searchDisplayController.searchResultsTableView reloadData];
    }
}

//-(void) viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:YES];
//    
//    User *user = [User sharedUser];
//    
//    NSString *returnFavorites = @"";
//    int length=[self.favorites count];
//    TKContact *contact;
//    for (int i=0; i<length; i++){
//        NSString *favorite = [self.favorites objectAtIndex:i];
//        //add a favorite
//        returnFavorites = [NSString stringWithFormat:@"%@%@", returnFavorites, favorite];
//        //add comma
//        if (i!=length-1) {
//            returnFavorites = [NSString stringWithFormat:@"%@,", returnFavorites];
//        }
//    }
//    //NSLog(@"%@", returnContacts);
//    
//    //NSString *JsonMsg = [NSString stringWithFormat:@"\"user\": \"%@\", \"groupId\": \"%@\", \"contacts\":[%@]", user.user, user.groupId, returnFavorites];
//    
//    //NSLog(@"%@", JsonMsg);
//    
//    //user.url = @"http://192.168.1.173";
//}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    User *user = [User sharedUser];
    user.contact = [self.contacts objectAtIndex:indexPath.row];
    
    if(self.viewDetail == nil) {
        ContactDetailViewController *secondxib =
        [[ContactDetailViewController alloc] initWithNibName:@"ContactDetailViewController" bundle:[NSBundle mainBundle]];
        self.viewDetail = secondxib;
        [secondxib release];
    }
    
    [self.navigationController pushViewController:self.viewDetail animated:YES];

    
}

@end
