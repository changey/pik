//
//  ContactAllViewController.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/20/14.
//
//

#import "ContactAllViewController.h"
#import "ContactsCell.h"
#import "User.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"

@interface ContactAllViewController ()

@end

@implementation ContactAllViewController

@synthesize contacts ,tableView;


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self retrieve_table];
}

-(void) retrieve_table {
    
    User *user=[User sharedUser];
    
    NSString *url = [NSString stringWithFormat:@"%@/contacts.php?groupId=0&user=%@", user.url, user.user];  // server name does not match
    
    NSLog(@"%@", url);
    
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
    //    times = [[NSMutableArray alloc] init];
    //    captions = [[NSMutableArray alloc] init];
    //
    int length = [json count];
    //
    //    NSString *time;
    //    NSString *caption;
    //
    
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
        
        //        time=[[json objectAtIndex:i] objectForKey:@"time"];
        //        caption=[[json objectAtIndex:i] objectForKey:@"captions"];
        [self.contacts addObject:contact];
        //NSLog(@"%@", contact.tagString);
        
    }
    //
    [self.tableView reloadData];
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

//void UIImageFromURL( NSURL * URL, void (^imageBlock)(UIImage * image), void (^errorBlock)(void) )
//{
//    dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^(void)
//                   {
//                       NSData * data = [[[NSData alloc] initWithContentsOfURL:URL] autorelease];
//                       UIImage * image = [[[UIImage alloc] initWithData:data] autorelease];
//                       dispatch_async( dispatch_get_main_queue(), ^(void){
//                           if( image != nil )
//                           {
//                               imageBlock( image );
//                           } else {
//                               errorBlock();
//                           }
//                       });
//                   });
//}


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
    self.title = @"Contacts";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
