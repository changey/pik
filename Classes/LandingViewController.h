//
//  LandingViewController.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/14/14.
//
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "Signup2ViewController.h"

@class LoginViewController;
@class Signup2ViewController;

@interface LandingViewController : UIViewController {
    LoginViewController *viewlogin;
    Signup2ViewController *viewsignup;
}

@property (nonatomic, retain) LoginViewController *viewlogin;
@property (nonatomic, retain) Signup2ViewController *viewsignup;

-(IBAction)signup;
-(IBAction)login;

@end
