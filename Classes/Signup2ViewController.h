//
//  Signup2ViewController.h
//  NB_list
//
//  Created by Shiyang Liu on 10/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerificationViewController.h"

@class TPKeyboardAvoidingScrollView;
@class VerificationViewController;

@interface Signup2ViewController : UIViewController<UITextFieldDelegate>{
    
    VerificationViewController *viewVerify;
    
    IBOutlet UITextField *user;
    IBOutlet UITextField *pass;
    IBOutlet UITextField *passcon;
    IBOutlet UISegmentedControl *countryToggle;
    
    NSMutableCharacterSet *_phoneChars;
    UITextField *_textField;
    
    NSString *country;
    
}

@property (nonatomic, retain) NSString *country;

@property (nonatomic, retain) VerificationViewController *viewVerify;

@property (nonatomic, retain) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UITextField *user;
@property (nonatomic, retain) IBOutlet UITextField *pass;
@property (nonatomic, retain) IBOutlet UITextField *passcon;

@property (nonatomic, retain) IBOutlet UISegmentedControl *countryToggle;

-(IBAction)connect;

@end
