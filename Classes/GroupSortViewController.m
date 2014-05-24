//
//  GroupSortViewController.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/21/14.
//
//

#import "GroupSortViewController.h"
#import "CustomCell.h"
#import "User.h"
#import "JSON.h"
#import "Group.h"
#import "ASIHTTPRequest.h"

@interface GroupSortViewController ()

@end

@implementation GroupSortViewController

@synthesize groups, tableView, viewGroup;

- (void)retrieve_table {
    User *user=[User sharedUser];
    
    NSString *url = [NSString stringWithFormat:@"%@/groupsNew.php?user=%@", user.url, user.user];  // server name does not match
    
    NSURL *URL = [NSURL URLWithString:url];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
    
    [request startSynchronous];
    NSError *error = [request error];
    NSString *returnString;
    if (!error) {
        returnString = [request responseString];
        //NSLog(@"%@",returnString);
    }
    
    NSArray *json = [returnString JSONValue];
    
    self.groups = [[NSMutableArray alloc] init];

    int length = [json count];

    NSString *ide;
    NSString *name;
    NSString *tagString;
    NSString *isMember;

    for (int i=0; i<length;i++){
        ide = [[json objectAtIndex:i] objectForKey:@"id"];
        name = [[json objectAtIndex:i] objectForKey:@"name"];
        tagString = [[json objectAtIndex:i] objectForKey:@"tagString"];
        isMember = [[json objectAtIndex:i] objectForKey:@"isMember"];
        
        Group *group = [[Group alloc] init];
        group.ide = [ide intValue];
        group.name = name;
        group.tagString = tagString;
        group.isMember = [isMember intValue];

        [self.groups addObject:group];
    }

    [self.tableView reloadData];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self retrieve_table];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.groups count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
    
    Group *group = nil;
    group = (Group *)[self.groups objectAtIndex:indexPath.row];
    
    cell.name.text = group.name;
    cell.tagString.text = group.tagString;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    User *user=[User sharedUser];
    Group *group = [groups objectAtIndex:indexPath.row];
    user.groupId = [NSString stringWithFormat:@"%d", group.ide];
    user.isMember = group.isMember;
    
    GroupDetailViewController *secondxib =
    [[GroupDetailViewController alloc] initWithNibName:@"GroupDetailViewController" bundle:[NSBundle mainBundle]];
    self.viewGroup = secondxib;
    [secondxib release];
    
    [self.navigationController pushViewController:self.viewGroup animated:YES];
	
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
