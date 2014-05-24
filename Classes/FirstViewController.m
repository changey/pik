//
//  FirstViewController.m
//  TabBarNavBarDemo
//
//  Created by James Lin on 19/07/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "FirstViewController.h"
#import "CustomCell.h"


@implementation FirstViewController


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
//
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
											 initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
											 target:self action:@selector(add_Clicked:)];
//
//	//appDelegate = (TabBarNavBarDemoAppDelegate *)[[UIApplication sharedApplication] delegate];
//	
//	self.title = @"";
    
    //tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"storyboard-bg.png"]];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//   return [appDelegate.coffeeArray count];
//return [names count];
    return 1;
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
    
    
        cell.name.text=[names objectAtIndex:indexPath.row];
    
	
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
    
    //    TKPeoplePickerController *controller = [[[TKPeoplePickerController alloc] initPeoplePicker] autorelease];
    //    controller.actionDelegate = self;
    //    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    //    [self presentViewController:controller animated:YES completion:nil];
    
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
     
     dvController.coffeeObj = coffeeObj;
     
     if(self.dvController == nil) {
     DetailViewController *practicexib =
     [[DetailViewController alloc] initWithNibName:@"DetailView" bundle:[NSBundle mainBundle]];
     self.dvController = practicexib;
     [practicexib release];
     }
     [self.navigationController pushViewController:self.dvController animated:YES];*/
	
	//[self.navigationController pushViewController:dvController animated:YES];
	
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
