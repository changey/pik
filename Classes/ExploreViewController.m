//
//  ExploreViewController.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/21/14.
//
//

#import "ExploreViewController.h"

@interface ExploreViewController ()

@end

@implementation ExploreViewController

@synthesize viewGroup;

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self.navigationController setToolbarHidden:YES animated:NO];
}

- (IBAction)newGroup {
    GroupSortViewController *secondxib =
    [[GroupSortViewController alloc] initWithNibName:@"GroupSortViewController" bundle:[NSBundle mainBundle]];
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
    
    self.title = @"Explore";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
