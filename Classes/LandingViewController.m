//
//  LandingViewController.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/14/14.
//
//

#import "LandingViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "User.h"

@interface LandingViewController ()

@end

@implementation LandingViewController

@synthesize viewsignup, viewlogin;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)signup{
    if(self.viewsignup == nil) {
        Signup2ViewController *secondxib =
        [[Signup2ViewController alloc] initWithNibName:@"Signup2ViewController" bundle:[NSBundle mainBundle]];
        self.viewsignup = secondxib;
        [secondxib release];
    }
    
    [self.navigationController pushViewController:self.viewsignup animated:YES];
    
}

-(IBAction)login {
    if(self.viewlogin == nil) {
        LoginViewController *secondxib =
        [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
        self.viewlogin = secondxib;
        [secondxib release];
    }
    
    [self.navigationController pushViewController:self.viewlogin animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad
{
    User *user = [User sharedUser];
    user.url=@"http://54.200.250.29/pik";
    //user.url=@"http://54.200.250.29/startup";
    //user.url=@"http://localhost/address_backend";
    //user.url=@"http://192.168.1.173/address_backend";
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
