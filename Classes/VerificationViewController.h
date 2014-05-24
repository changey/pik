//
//  VerificationViewController.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/20/14.
//
//

#import <UIKit/UIKit.h>
#import "PasswordViewController.h"

@class PasswordViewController;

@interface VerificationViewController : UIViewController{
    PasswordViewController *viewPass;
}

@property (nonatomic, retain) PasswordViewController *viewPass;

-(IBAction) verify;

@end
