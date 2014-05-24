//
//  ProfileViewController.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/21/14.
//
//

#import "ProfileViewController.h"
#import "ASIHTTPRequest.h"
#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize name, gender, job, university, email, tel, imgv;

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    name.textColor = Rgb2UIColor(47, 184, 149);
    gender.textColor = Rgb2UIColor(47, 184, 149);
    job.textColor = Rgb2UIColor(47, 184, 149);
    university.textColor = Rgb2UIColor(47, 184, 149);
    email.textColor = Rgb2UIColor(47, 184, 149);
    tel.textColor = Rgb2UIColor(47, 184, 149);
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
    
    self.title = @"Profile";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
