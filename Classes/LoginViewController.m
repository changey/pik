//
//  LoginViewController.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 2/19/14.
//
//

#import "LoginViewController.h"
#import "User.h"
#import "ASIHTTPRequest.h"

#import "TPKeyboardAvoidingScrollView.h"
#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize user, pass, fbGraph, countryToggle;

-(IBAction)fbconnect{
    
    /*Facebook Application ID*/
	NSString *client_id = @"222388091297891";
	
	//alloc and initalize our FbGraph instance
	self.fbGraph = [[FbGraph alloc] initWithFbClientID:client_id];
	
	//begin the authentication process.....
//	[fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(fbGraphCallback:)
//						 andExtendedPermissions:@"user_photos,user_videos,publish_stream,offline_access,user_checkins,friends_checkins"];
    [fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(fbGraphCallback:)
						 andExtendedPermissions:@""];
	
	/**
	 * OR you may wish to 'anchor' the login UIWebView to a window not at the root of your application...
	 * for example you may wish it to render/display inside a UITabBar view....
	 *
	 * Feel free to try both methods here, simply (un)comment out the appropriate one.....
	 **/
	//	[fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(fbGraphCallback:) andExtendedPermissions:@"user_photos,user_videos,publish_stream,offline_access" andSuperView:self.view];
}

#pragma mark -
#pragma mark FbGraph Callback Function
/**
 * This function is called by FbGraph after it's finished the authentication process
 **/
- (void)fbGraphCallback:(id)sender {
	
	if ( (fbGraph.accessToken == nil) || ([fbGraph.accessToken length] == 0) ) {
		
		NSLog(@"You pressed the 'cancel' or 'Dont Allow' button, you are NOT logged into Facebook...I require you to be logged in & approve access before you can do anything useful....");
		
		//restart the authentication process.....
//		[fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(fbGraphCallback:)
//							 andExtendedPermissions:@"user_photos,user_videos,publish_stream,offline_access,user_checkins,friends_checkins"];
        [fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(fbGraphCallback:)
							 andExtendedPermissions:@""];
		
	} else {
		//pop a message letting them know most of the info will be dumped in the log
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Note" message:@"For the simplest code, I've written all output to the 'Debugger Console'." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//         [alert show];
//         [alert release];
        
        
        
        User *user =[User sharedUser];
//        user.user=@"";
//        user.pass=@"";
//        user.pass=@"1";
        
        //user.url=@"http://54.200.250.29/pik";
        //user.url=@"http://54.200.250.29/startup";
        //user.url=@"http://192.168.1.173/address_backend";

//        FbGraphResponse *fb_graph_response = [fbGraph doGraphGet:@"me" withGetVars:nil];
//        NSLog(@"getMeButtonPressed:  %@", fb_graph_response.htmlResponse);
        
        [self dismissModalViewControllerAnimated:YES];
		
	}
	
}

-(IBAction)signup{
    if(self.viewsign == nil) {
        Signup2ViewController *secondxib =
        [[Signup2ViewController alloc] initWithNibName:@"Signup2ViewController" bundle:[NSBundle mainBundle]];
        self.viewsign = secondxib;
        [secondxib release];
    }
    
    [self.navigationController pushViewController:self.viewsign animated:YES];
    
    
}

-(IBAction)signin{
    NSString *user2=user.text;
    NSString *pass2=pass.text;
    
    User *user3=[User sharedUser];
    
    [pass resignFirstResponder];
    
    NSString *url = [NSString stringWithFormat:@"%@/rnlogin2.php?user=%@&pass=%@",user3.url,user2,pass2];
    
    NSLog(@"%@", url);
    
    NSURL *URL = [NSURL URLWithString:url];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
    [request startSynchronous];
    NSError *error = [request error];
    NSString *returnString;
    if (!error) {
        returnString = [request responseString];
        NSLog(@"%@",returnString);
    }
    
    if ([returnString isEqualToString:@"1"]){
        NSLog(@"%@", user2);
        user3.user=user2;
        
        [self dismissModalViewControllerAnimated:YES];
        
        // [[UAUser defaultUser] setAlias:@"changey"];
        //[[UAPush shared] setAlias:user2];
        
//        if(self.mainVC == nil) {
//            MainViewController *secondxib =
//            [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:[NSBundle mainBundle]];
//            self.mainVC = secondxib;
//            [secondxib release];
//        }
//        
//        [self.navigationController pushViewController:self.mainVC animated:YES];
    }
    else{
        UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Username/Password invalid"
                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertsuccess show];
        [alertsuccess release];
    }
    
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)hide{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    User *user2=[User sharedUser];
    
    user.text=@"(242)123-1231";
    pass.text=@"1";
    [self.navigationController setNavigationBarHidden:NO];
    pass.returnKeyType = UIReturnKeyGo;
    
    user.textColor = Rgb2UIColor(47, 184, 149);
    pass.textColor = Rgb2UIColor(47, 184, 149);
    
    [super viewDidLoad];
    
    self.title = @"Login";
    
    [countryToggle addTarget:self
                         action:@selector(picCountry:)
               forControlEvents:UIControlEventValueChanged];
    // Do any additional setup after loading the view from its nib.
}

//Action method executes when user touches the button
-(void)picCountry:(id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    NSString *country = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
    NSLog(@"%@", country);
    if ([country isEqualToString:@"US"]) {
        user.text = @"(242)123-1231";
    } else {
        user.text = @"15174662062";
    }
    //label.text = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
    /*[segmentedControl removeSegmentAtIndex:segmentedControl.selectedSegmentIndex
     animated:YES];*/
    //    [segmentedControl insertSegmentWithTitle:@"Four"
    //                                     atIndex:segmentedControl.numberOfSegments
    //                                    animated:YES];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self.navigationController setNavigationBarHidden:NO];
   // [self.tabBarController s]
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
