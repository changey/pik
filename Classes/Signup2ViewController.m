//
//  Signup2ViewController.m
//  NB_list
//
//  Created by Shiyang Liu on 10/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Signup2ViewController.h"
#import "JSON.h"
#import "User.h"

@interface Signup2ViewController ()

@end

@implementation Signup2ViewController

@synthesize user, pass, passcon, viewVerify, countryToggle, country;

-(IBAction)connect
{
    User *user3 = [User sharedUser];
    user3.user = user.text;
    
    if(self.viewVerify == nil) {
        VerificationViewController *secondxib =
        [[VerificationViewController alloc] initWithNibName:@"VerificationViewController" bundle:[NSBundle mainBundle]];
        self.viewVerify = secondxib;
        [secondxib release];
    }
    
    [self.navigationController pushViewController:self.viewVerify animated:YES];
    
    NSString *user2=user.text;
//    NSString *pass2=pass.text;
//    
//    User *user3=[User sharedUser];
//    
//    NSString *urlString = [NSString stringWithFormat:@"%@/post_signup.php?user=%@&pass=%@", user3.url, user2,pass2];
//    NSString * replace = [urlString stringByReplacingOccurrencesOfString: @ " " withString: @ "%20"];
//    NSLog(@"%@", replace);
//    
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString: replace]];
//    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    
//    NSLog(@"the return string: %@", returnString);
//    
//    
//    user3.user=user2;
//    user3.pass=pass2;
//    
//    if([returnString isEqualToString:@"0"]){
//        //    if([user2 isEqualToString:@"Wei.God"]){
//        
//        UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Error" message:@"That phone number already exists"
//                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alertsuccess show];
//        [alertsuccess release];
//    }
//    else if([returnString isEqualToString:@"1"]){
//        user3.user=user2;
//        [self.navigationController dismissModalViewControllerAnimated:YES];
//        // [[UAUser defaultUser] setAlias:@"changey"];
//        //[[UAPush shared] setAlias:user2];
//        
////        if(self.mainVC == nil) {
////            MainViewController *secondxib =
////            [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:[NSBundle mainBundle]];
////            self.mainVC = secondxib;
////            [secondxib release];
////        }
////        
////        [self.navigationController pushViewController:self.mainVC animated:YES];
//        
//    }
//    else{
//        UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Error" message:@"That phone number already exists"
//                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alertsuccess show];
//        [alertsuccess release];
//    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [self.navigationController setNavigationBarHidden:NO];
    
    [super viewDidLoad];
    
    self.title = @"Sign up";
    
    //UITextField *tf = [[UITextField alloc] init];
    user.keyboardType = UIKeyboardTypePhonePad;
    user.backgroundColor = [UIColor whiteColor];
    user.clearButtonMode = UITextFieldViewModeWhileEditing;
    user.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    user.placeholder = @"Phone number";
    
    user.delegate=self;
    
    pass.secureTextEntry = YES;
    
    country = @"US";
    
//    [tel addTarget:self action:@selector(shouldChangeCharactersInRange:) forControlEvents:UIControlEventEditingChanged];
    
    _textField = user;
    
    [countryToggle addTarget:self
                      action:@selector(pickCountry:)
            forControlEvents:UIControlEventValueChanged];
}

//Action method executes when user touches the button
-(void)pickCountry:(id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    country = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
    
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([country isEqualToString:@"US"]) {
        int length = [self getLength:textField.text];
        //NSLog(@"Length  =  %d ",length);
        
        if(length == 10)
        {
            if(range.length == 0)
                return NO;
        }
        
        if(length == 3)
        {
            NSString *num = [self formatNumber:textField.text];
            textField.text = [NSString stringWithFormat:@"(%@) ",num];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
        }
        else if(length == 6)
        {
            NSString *num = [self formatNumber:textField.text];
            //NSLog(@"%@",[num  substringToIndex:3]);
            //NSLog(@"%@",[num substringFromIndex:3]);
            textField.text = [NSString stringWithFormat:@"(%@) %@-",[num  substringToIndex:3],[num substringFromIndex:3]];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"(%@) %@",[num substringToIndex:3],[num substringFromIndex:3]];
        }
        
        return YES;
    }
    
}

-(NSString*)formatNumber:(NSString*)mobileNumber
{
    
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    NSLog(@"%@", mobileNumber);
    
    int length = [mobileNumber length];
    if(length > 10)
    {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
        NSLog(@"%@", mobileNumber);
        
    }
    
    
    return mobileNumber;
}


-(int)getLength:(NSString*)mobileNumber
{
    
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    int length = [mobileNumber length];
    
    return length;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
