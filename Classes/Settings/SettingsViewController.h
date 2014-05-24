//
//  SettingsViewController.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/21/14.
//
//

#import <UIKit/UIKit.h>
#import "ProfileViewController.h"

@class ProfileViewController;

@interface SettingsViewController : UIViewController {
    ProfileViewController *profileVC;
    
    UINavigationController *navigationController;
}

@property (strong, nonatomic) ProfileViewController *profileVC;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

- (IBAction) viewProfile;
- (IBAction) logout;

@end
