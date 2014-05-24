//
//  SettingsViewController.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/21/14.
//
//

#import "SettingsViewController.h"
#import "LandingViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize profileVC, navigationController;

- (IBAction)logout {
    LandingViewController *landingViewController = [[LandingViewController alloc] init];
    navigationController = [[UINavigationController alloc] initWithRootViewController:landingViewController];
    
    [self presentModalViewController:navigationController animated:YES];
}

- (IBAction)viewProfile {
    NSLog(@"lala");
    ProfileViewController *secondxib =
    [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:[NSBundle mainBundle]];
    self.profileVC = secondxib;
    [secondxib release];
    
    [self.navigationController pushViewController:self.profileVC animated:YES];
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
    
    self.title = @"Settings";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
