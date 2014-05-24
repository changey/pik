//
//  LoginViewController.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 2/19/14.
//
//

#import <UIKit/UIKit.h>
#import "Signup2ViewController.h"
#import "FbGraph.h"

@class Signup2ViewController;
@class TPKeyboardAvoidingScrollView;

@interface LoginViewController : UIViewController{
    Signup2ViewController *viewsign;
    
    IBOutlet UITextField *user;
    IBOutlet UITextField *pass;
    IBOutlet UISegmentedControl *countryToggle;
    
    FbGraph *fbGraph;
}

@property (nonatomic, retain) FbGraph *fbGraph;

@property (nonatomic, retain) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

@property(nonatomic, retain) Signup2ViewController *viewsign;

@property (nonatomic, retain) IBOutlet UITextField *user;
@property (nonatomic, retain) IBOutlet UITextField *pass;

@property (nonatomic, retain) IBOutlet UISegmentedControl *countryToggle;

-(IBAction)signup;
-(IBAction)signin;

-(IBAction)fbconnect;

-(IBAction)hide;

@end
