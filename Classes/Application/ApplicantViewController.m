//
//  ApplicantViewController.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/23/14.
//
//

#import "ApplicantViewController.h"
#import "User.h"
#import "ASIHTTPRequest.h"
#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface ApplicantViewController ()

@end

@implementation ApplicantViewController

@synthesize name, gender, job, university, email, tel, imgv;

- (IBAction)approve {
    User *user = [User sharedUser];
    
    NSString *applicationIdString = [NSString stringWithFormat:@"%d", user.application.ide];
    NSString *groupIdString = [NSString stringWithFormat:@"%d", user.application.groupId];
    
    NSString *url = [NSString stringWithFormat:@"%@/approve.php?applicationId=%@&groupId=%@&applicant=%@", user.url, applicationIdString, groupIdString, user.member.tel];  // server name does not match
    
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

- (IBAction)decline {
    User *user = [User sharedUser];
    
    NSString *applicationIdString = [NSString stringWithFormat:@"%d", user.application.ide];
    
    NSString *url = [NSString stringWithFormat:@"%@/decline.php?applicationId=%@", user.url, applicationIdString];  // server name does not match
    
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    User *user = [User sharedUser];
    Member *member = user.member;
    name.text = member.name;
    gender.text = member.gender;
    job.text = member.job;
    university.text = member.university;
    email.text = member.email;
    tel.text = member.tel;
    
    name.textColor = Rgb2UIColor(47, 184, 149);
    gender.textColor = Rgb2UIColor(47, 184, 149);
    job.textColor = Rgb2UIColor(47, 184, 149);
    university.textColor = Rgb2UIColor(47, 184, 149);
    email.textColor = Rgb2UIColor(47, 184, 149);
    tel.textColor = Rgb2UIColor(47, 184, 149);
    
    NSURL * imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", user.url, member.thumbnail]];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    
    imgv.image = image;
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
