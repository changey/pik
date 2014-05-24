//
//  ApplicationViewController.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/22/14.
//
//

#import "ApplicationViewController.h"
#import "ApplicationTableViewCell.h"
#import "User.h"
#import "JSON.h"
#import "ASIHTTPRequest.h"
#import "Application.h"
#import "Member.h"


@interface ApplicationViewController ()

@end

@implementation ApplicationViewController

@synthesize applications, tableView, viewApplicant, applicants;

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self retrieve_table];
}

- (void)retrieve_table {
    User *user=[User sharedUser];
    
    NSString *url = [NSString stringWithFormat:@"%@/applications.php?user=%@", user.url, user.user];  // server name does not match
    
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
    
    self.applications = [[NSMutableArray alloc] init];
    self.applicants = [[NSMutableArray alloc] init];
    
    int length = [json count];
    
    NSString *ide;
    NSString *applicant;
    NSString *groupName;
    NSString *name;
    NSString *email;
    NSString *tel;
    NSString *thumbnail;
    NSString *job;
    NSString *university;
    NSString *gender;
    NSInteger *groupId;
    
    for (int i=0; i<length;i++){
        ide = [[json objectAtIndex:i] objectForKey:@"id"];
        applicant = [[json objectAtIndex:i] objectForKey:@"applicantName"];
        groupName = [[json objectAtIndex:i] objectForKey:@"groupName"];
        name = [[json objectAtIndex:i] objectForKey:@"applicantName"];
        email = [[json objectAtIndex:i] objectForKey:@"applicantEmail"];
        tel = [[json objectAtIndex:i] objectForKey:@"applicantTel"];
        thumbnail = [[json objectAtIndex:i] objectForKey:@"applicantThumbnail"];
        job = [[json objectAtIndex:i] objectForKey:@"applicantJob"];
        university = [[json objectAtIndex:i] objectForKey:@"applicantUniversity"];
        gender = [[json objectAtIndex:i] objectForKey:@"applicantGender"];
        groupId = [[[json objectAtIndex:i] objectForKey:@"groupId"] intValue];
        
        Application *application = [[Application alloc] init];
        application.ide = [ide intValue];
        application.applicant = applicant;
        application.groupName = groupName;
        application.groupId = groupId;
        
        Member *member = [[Member alloc] init];
        member.name = name;
        member.email = email;
        member.tel = tel;
        member.thumbnail = thumbnail;
        member.job = job;
        member.university = university;
        member.gender = gender;
        
        [self.applications addObject:application];
        [self.applicants addObject:member];
    }
    
    [self.tableView reloadData];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.applications count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ApplicationTableViewCell";
	
    ApplicationTableViewCell *cell = (ApplicationTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ApplicationTableViewCell" owner:self options:nil];
		
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (ApplicationTableViewCell *) currentObject;
				break;
			}
		}
	}
    
    Application *application = nil;
    application = (Application *)[self.applications objectAtIndex:indexPath.row];
    
    cell.applicant.text = application.applicant;
    cell.groupName.text = application.groupName;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    User *user=[User sharedUser];
    user.member = [self.applicants objectAtIndex:indexPath.row];
    user.application = [self.applications objectAtIndex:indexPath.row];
    
    ApplicantViewController *secondxib =
    [[ApplicantViewController alloc] initWithNibName:@"ApplicantViewController" bundle:[NSBundle mainBundle]];
    self.viewApplicant = secondxib;
    [secondxib release];
    
    [self.navigationController pushViewController:self.viewApplicant animated:YES];
	
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
    self.title = @"Applications";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
