//
//  GroupDetailViewController.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 3/1/14.
//
//

#import "GroupDetailViewController.h"
#import "ASIHTTPRequest.h"
#import "User.h"
#import "JSON.h"
#import "TPKeyboardAvoidingScrollView.h"
#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface GroupDetailViewController ()

@end

@implementation GroupDetailViewController

@synthesize groupName, groupIntro, imgv, viewContact, nonMemberButton, nonMemberLabel
, memberButton, updatePhoto, groupNameField;

- (void)edit_Clicked :(id)sender {
    if (editMode == NO) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                  initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self action:@selector(edit_Clicked:)];
        editMode = YES;
        
        updatePhoto.hidden = NO;
        groupNameField.hidden = NO;
        groupName.hidden = YES;
        
    } else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                  initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                  target:self action:@selector(edit_Clicked:)];
        editMode = NO;
        
        groupName.text = groupNameField.text;
        
        updatePhoto.hidden = YES;
        groupNameField.hidden = YES;
        groupName.hidden = NO;
        [self updateGroupInfo];
    }
}

- (void) updateGroupInfo {
    User *user=[User sharedUser];
    
    NSString *url = [NSString stringWithFormat:@"%@/group_update.php?groupId=%@&groupName=%@&groupIntro=%@", user.url, user.groupId, groupNameField.text, groupIntro.text];  // server name does not match
    
    NSString *formattedURL = [url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSURL *URL = [NSURL URLWithString:formattedURL];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
    
    [request startSynchronous];
    NSError *error = [request error];
    NSString *returnString;
    if (!error) {
        returnString = [request responseString];
        NSLog(@"%@",returnString);
    }

}

-(IBAction) apply {
    User *user = [User sharedUser];
    
    NSString *url = [NSString stringWithFormat:@"%@/application_insert.php?groupId=%@&applicant=%@", user.url, user.groupId, user.user];  // server name does not match
    
    NSURL *URL = [NSURL URLWithString:url];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
    
    [request startSynchronous];
    NSError *error = [request error];
    NSString *returnString;
    if (!error) {
        returnString = [request responseString];
        //NSLog(@"%@",returnString);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction) contacts {
    if(self.viewContact == nil) {
        ContactViewController *secondxib =
        [[ContactViewController alloc] initWithNibName:@"ContactViewController" bundle:[NSBundle mainBundle]];
        self.viewContact = secondxib;
        [secondxib release];
    }
    
    [self.navigationController pushViewController:self.viewContact animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    User *user=[User sharedUser];
    
    if (user.isMember == 0) {
        memberButton.hidden = YES;
    } else {
        nonMemberLabel.hidden = YES;
        nonMemberButton.hidden = YES;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/group_detail.php?groupId=%@", user.url, user.groupId];  // server name does not match
    
    NSURL *URL = [NSURL URLWithString:url];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
    
    [request startSynchronous];
    NSError *error = [request error];
    NSString *returnString;
    if (!error) {
        returnString = [request responseString];
    }
    
    // NSString *calibrated = [returnString stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
    NSArray *json = [returnString JSONValue];
    NSDictionary *data = [json objectAtIndex:0];
    
    NSString *name = [data objectForKey:@"name"];
    NSString *intro = [data objectForKey:@"intro"];
    NSString *thumbnail = [data objectForKey:@"thumbnail"];
    
    groupName.text = name;
    groupIntro.text = intro;
    groupNameField.text = name;
    
    NSURL * imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", user.url, thumbnail]];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    
    imgv.image = image;
//    
//    ids = [[NSMutableArray alloc] init];
//    names = [[NSMutableArray alloc] init];
//    //    times = [[NSMutableArray alloc] init];
//    //    captions = [[NSMutableArray alloc] init];
//    //
//    int length = [json count];
//    //
//    NSString *ide;
//    NSString *name;
//    //    NSString *time;
//    //    NSString *caption;
//    //
//    for (int i=0; i<length;i++){
//        ide=[[json objectAtIndex:i] objectForKey:@"id"];
//        name=[[json objectAtIndex:i] objectForKey:@"name"];
//        //        time=[[json objectAtIndex:i] objectForKey:@"time"];
//        //        caption=[[json objectAtIndex:i] objectForKey:@"captions"];
//        [ids addObject:ide];
//        [names addObject:name];
//        //NSLog(@"%@", sender);
//        
//    }
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
    editMode = NO;
    updatePhoto.hidden = YES;
    groupNameField.hidden = YES;
    
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
											 initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
											 target:self action:@selector(edit_Clicked:)];
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
