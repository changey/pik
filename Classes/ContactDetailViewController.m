//
//  ContactDetailViewController.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 3/11/14.
//
//

#import "ContactDetailViewController.h"
#import "User.h"
#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface ContactDetailViewController ()

@end

@implementation ContactDetailViewController

@synthesize name, gender, job, university, email, tel, imgv, promote;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    User *user = [User sharedUser];
    
    NSLog(@"isAdmin: %@", user.isAdmin);
    if ([user.isAdmin isEqualToString:@"1"]) {
        promote.hidden = NO;
    } else {
        promote.hidden = YES;
    }
    
    TKContact *contact = user.contact;
    name.text = contact.name;
    gender.text = contact.gender;
    job.text = contact.job;
    university.text = contact.university;
    email.text = contact.email;
    tel.text = contact.tel;
    
    name.textColor = Rgb2UIColor(47, 184, 149);
    gender.textColor = Rgb2UIColor(47, 184, 149);
    job.textColor = Rgb2UIColor(47, 184, 149);
    university.textColor = Rgb2UIColor(47, 184, 149);
    email.textColor = Rgb2UIColor(47, 184, 149);
    tel.textColor = Rgb2UIColor(47, 184, 149);
    
    NSURL * imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", user.url, contact.thumbnail]];
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
