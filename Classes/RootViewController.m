//
//  RootViewController.m
//  SQL
//
//  Created by iPhone SDK Articles on 10/26/08.
//  Copyright 2008 www.iPhoneSDKArticles.com.
//

#import "RootViewController.h"
#import "Coffee.h";
#import "AddViewController.h"
#import "DetailViewController.h"
#import "CustomCell.h"
#import "User.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "TabBarNavBarDemoAppDelegate.h"
#import "Group.h"
#define myAppDelegate (TabBarNavBarDemoAppDelegate *) [[UIApplication sharedApplication] delegate]

//#import "ProtocolBuffers.h"

@implementation RootViewController

@synthesize  dvController, viewContact, label, viewAdd, addNavigationController, viewGroup, groups;

//search
@synthesize filteredTableData;
@synthesize searchBar;
@synthesize isFiltered;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self.navigationController setToolbarHidden:YES animated:NO];
    
    User *user=[User sharedUser];
    
    NSString *url = [NSString stringWithFormat:@"%@/groups.php?user=%@", user.url, user.user];  // server name does not match
    
    NSURL *URL = [NSURL URLWithString:url];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
    
    [request startSynchronous];
    NSError *error = [request error];
    NSString *returnString;
    if (!error) {
        returnString = [request responseString];
        //NSLog(@"%@",returnString);
    }
    
    // NSString *calibrated = [returnString stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
    // NSLog(@"the return string: %@", calibrated);
    
    NSArray *json = [returnString JSONValue];
    
    ids = [[NSMutableArray alloc] init];
    names = [[NSMutableArray alloc] init];
    self.groups = [[NSMutableArray alloc] init];
//    
    int length = [json count];
//    
    NSString *ide;
    NSString *name;
    NSString *tagString;
    NSString *isAdmin;
    NSString *isMember;
//    NSString *time;
//    NSString *caption;
//    
    for (int i=0; i<length;i++){
        ide = [[json objectAtIndex:i] objectForKey:@"id"];
        name = [[json objectAtIndex:i] objectForKey:@"name"];
        tagString = [[json objectAtIndex:i] objectForKey:@"tagString"];
        isAdmin = [[json objectAtIndex:i] objectForKey:@"isAdmin"];
        isMember = [[json objectAtIndex:i] objectForKey:@"isMember"];
        
        Group *group = [[Group alloc] init];
        group.name = name;
        group.tagString = tagString;
        group.isAdmin = [isAdmin intValue];
        group.isMember = [isMember intValue];
        //group.isAd
        //group.tagString

        [ids addObject:ide];
        [names addObject:name];
        [self.groups addObject:group];
        //NSLog(@"%@", sender);
        
    }
//    
    [self.tableView reloadData];
    
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [appDelegate.coffeeArray count];
    int rowCount;
    if(self.isFiltered) {
        rowCount = self.filteredTableData.count;
    }
    else {
        rowCount = [self.groups count];
    }
    return rowCount;
    //return [names count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   /* static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }*/
    
    static NSString *CellIdentifier = @"CustomCell";
	
    CustomCell *cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
		
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (CustomCell *) currentObject;
				break;
			}
		}
	}
    
  //  cell.bor = [[UIColor blackColor]CGColor];
   // cell.layer.borderWidth = 10.0f;
	
	//Get the object from the array.
//	Coffee *coffeeObj = [appDelegate.coffeeArray objectAtIndex:indexPath.row];
//	
//	//Set the coffename.
//	cell.mer_name.text = coffeeObj.coffeeName;
//    cell.mer_address.text= coffeeObj.tags;
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Group *group = nil;
    group = (Group *)[self.groups objectAtIndex:indexPath.row];
    
    if(isFiltered) {
        group = (Group *)[self.filteredTableData objectAtIndex:indexPath.row];
    }
    else {
        group = (Group *)[self.groups objectAtIndex:indexPath.row];
    }
    
    cell.name.text = group.name;
    cell.tagString.text = group.tagString;
    
	
	//Set the accessory type.
	//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
   /* if (indexPath.row==1){
        cell.mer_name.text= @"Title";
        cell.mer_address.text= @"content";
    }*/
    
    // Set up the cell
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    User *user=[User sharedUser];
    user.groupId=[ids objectAtIndex:indexPath.row];
    Group *group = [self.groups objectAtIndex:indexPath.row];
    NSLog(@"isAdmin: %@", [NSString stringWithFormat:@"%d", group.isAdmin]);
    NSLog(@"isMember: %d", group.isMember);
    user.isAdmin = [NSString stringWithFormat:@"%d", group.isAdmin];
    user.isMember = group.isMember;
    
    //if(self.viewGroup == nil) {
    GroupDetailViewController *secondxib =
    [[GroupDetailViewController alloc] initWithNibName:@"GroupDetailViewController" bundle:[NSBundle mainBundle]];
    self.viewGroup = secondxib;
    [secondxib release];
    //}
    
    [self.navigationController pushViewController:self.viewGroup animated:YES];
    
//    Coffee *coffeeObj = [appDelegate.coffeeArray objectAtIndex:indexPath.row];
//    
//    User *user=[User sharedUser];
//    user.ids=coffeeObj.coffeeName;
//    user.detailID=coffeeObj.tags;
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New favorite selected"
//                                                    message:@""
//                                                   delegate:self
//                                          cancelButtonTitle:nil
//                                          otherButtonTitles:@"OK", nil];
//    [alert show];
//    [alert release];
    
    // Navigation logic -- create and push a new view controller
	
	/*if(dvController == nil)
		dvController = [[DetailViewController alloc] initWithNibName:@"DetailView" bundle:nil];
	
	Coffee *coffeeObj = [appDelegate.coffeeArray objectAtIndex:indexPath.row];
	
	//Get the detail view data if it does not exists.
	//We only load the data we initially want and keep on loading as we need.
	[coffeeObj hydrateDetailViewData];
	
	dvController.coffeeObj = coffeeObj;*/
	
    
    
	//[self.navigationController pushViewController:dvController animated:YES];
	
}

#pragma mark - Table view delegate

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

        for (Group* group in self.groups)
        {
            NSRange nameRange = [group.name rangeOfString:text options:NSCaseInsensitiveSearch];
            NSRange tagStringRange = [group.tagString rangeOfString:text options:NSCaseInsensitiveSearch];
            NSLog(@"tagString: %@", group.tagString);
            if(nameRange.location != NSNotFound || tagStringRange.location != NSNotFound)
            //if(nameRange.location != NSNotFound)
            {
                [self.filteredTableData addObject:group];
            }
        }
        NSLog(@"filterLength: %d", [self.filteredTableData count]);
//        for (Food* food in allTableData)
//        {
//            NSRange nameRange = [food.name rangeOfString:text options:NSCaseInsensitiveSearch];
//            NSRange descriptionRange = [food.description rangeOfString:text options:NSCaseInsensitiveSearch];
//            if(nameRange.location != NSNotFound || descriptionRange.location != NSNotFound)
//            {
//                [filteredTableData addObject:food];
//            }
//        }
    }
    
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"Groups";

    self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] 
											 initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
											 target:self action:@selector(add_Clicked:)];
    [self setSearchBar:nil];
}


- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if(editingStyle == UITableViewCellEditingStyleDelete) {
		
		//Get the object to delete from the array.
		Coffee *coffeeObj = [appDelegate.coffeeArray objectAtIndex:indexPath.row];
		[appDelegate removeCoffee:coffeeObj];
		
		//Delete the object from the table.
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	
	[super setEditing:editing animated:animated];
    [tableView setEditing:editing animated:YES];
	
	//Do not let the user add if the app is in edit mode.
	if(editing)
		self.navigationItem.leftBarButtonItem.enabled = NO;
	else
		self.navigationItem.leftBarButtonItem.enabled = YES;
}	

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void) add_Clicked:(id)sender {
    
    Add2ViewController *modalController = [[Add2ViewController alloc] initWithNibName:@"Add2ViewController" bundle:nil];
	
	if(avController == nil)
		avController = [[AddViewController alloc] initWithNibName:@"AddView" bundle:nil];
    
    if(av2Controller == nil)
		av2Controller = [[Add2ViewController alloc] initWithNibName:@"Add2ViewController" bundle:nil];
    
	
	//if(addNavigationController == nil)
    addNavigationController = [[UINavigationController alloc] initWithRootViewController:av2Controller];
    
    [myAppDelegate presentModal:addNavigationController];
//    
//    [modalController release];
    //[navigationController release];
	
	//[self.navigationController presentModalViewController:addNavigationController animated:YES];
    //[self.navigationController presentModalViewController:addNavigationController animated:YES];
}


- (void)dealloc {
	[dvController release];
	[addNavigationController release];
	[avController release];
    [super dealloc];
}


@end

