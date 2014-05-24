//
//  FbContactsPickerViewController.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 3/1/14.
//
//

#import "FbContactsPickerViewController.h"
#import "JSON.h"
#import "FbGraphFile.h"
#import "TKContact.h"
#import "User.h"

@interface FbContactsPickerViewController ()

@end

@implementation FbContactsPickerViewController

@synthesize fbGraph, contacts;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.contacts = [NSMutableArray new];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setLeftBarButtonItem:nil];
    [self.navigationItem setTitle:NSLocalizedString(@"Contacts", nil)];
    [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissAction:)] autorelease]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self fbconnect];
}

-(void) fbconnect {
    
    /*Facebook Application ID*/
	NSString *client_id = @"222388091297891";
	
	//alloc and initalize our FbGraph instance
	self.fbGraph = [[FbGraph alloc] initWithFbClientID:client_id];
	
	//begin the authentication process.....
    [fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(fbGraphCallback:)
						 andExtendedPermissions:@""];
	
	/**
	 * OR you may wish to 'anchor' the login UIWebView to a window not at the root of your application...
	 * for example you may wish it to render/display inside a UITabBar view....
	 *
	 * Feel free to try both methods here, simply (un)comment out the appropriate one.....
	 **/
	//	[fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(fbGraphCallback:) andExtendedPermissions:@"user_photos,user_videos,publish_stream,offline_access" andSuperView:self.view];
}

#pragma mark -
#pragma mark FbGraph Callback Function
/**
 * This function is called by FbGraph after it's finished the authentication process
 **/
- (void)fbGraphCallback:(id)sender {
	
	if ( (fbGraph.accessToken == nil) || ([fbGraph.accessToken length] == 0) ) {
		
		NSLog(@"You pressed the 'cancel' or 'Dont Allow' button, you are NOT logged into Facebook...I require you to be logged in & approve access before you can do anything useful....");
		
		//restart the authentication process.....
        [fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(fbGraphCallback:)
							 andExtendedPermissions:@""];
		
	} else {

        FbGraphResponse *fb_graph_response = [fbGraph doGraphGet:@"me/friends" withGetVars:nil];
        NSLog(@"getMeFriendsButtonPressed:  %@", fb_graph_response.htmlResponse);
        
        NSDictionary *json = [fb_graph_response.htmlResponse JSONValue];
        
        NSArray *data=[json objectForKey:@"data"];
        
        int length = [data count];
        NSString *name;
        
        for (int i=0; i< length; i++) {
            name = [[data objectAtIndex:i] objectForKey:@"name"];
            TKContact *contact = [[TKContact alloc] init];
            contact.name = name;
            [self.contacts addObject: contact];
        }
        
        [self.tableView reloadData];
        
        //[self dismissModalViewControllerAnimated:YES];
		
	}
	
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    //return [self.contacts count];
    //return 1;
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
            NSLog(@"%@", contact.name);
        }
    }

    [self dismissModalViewControllerAnimated:YES];
    
	[objects release];
}

- (IBAction)dismissAction:(id)sender
{
    //Dismiss the controller.
	[self.navigationController dismissModalViewControllerAnimated:YES];
    
}

@end
