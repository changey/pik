//
//  VerificationViewController.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/20/14.
//
//

#import "VerificationViewController.h"

@interface VerificationViewController ()

@end

@implementation VerificationViewController

@synthesize viewPass;

- (IBAction)verify {
    if(self.viewPass == nil) {
        PasswordViewController *secondxib =
        [[PasswordViewController alloc] initWithNibName:@"PasswordViewController" bundle:[NSBundle mainBundle]];
        self.viewPass = secondxib;
        [secondxib release];
    }
    
    [self.navigationController pushViewController:self.viewPass animated:YES];
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
    self.title = @"Verification";
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
