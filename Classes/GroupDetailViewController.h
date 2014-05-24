//
//  GroupDetailViewController.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 3/1/14.
//
//

#import <UIKit/UIKit.h>
#import "ContactViewController.h"

@class ContactViewController;

@interface GroupDetailViewController : UIViewController {
    IBOutlet UILabel *groupName;
    IBOutlet UITextView *groupIntro;
    IBOutlet UILabel *nonMemberLabel;
    IBOutlet UIButton *nonMemberButton;
    IBOutlet UIButton *memberButton;
    IBOutlet UIButton *updatePhoto;
    IBOutlet UITextField *groupNameField;
    
    ContactViewController *viewContact;
    
    IBOutlet UIImageView *imgv;
    BOOL editMode;
}

@property (strong, nonatomic) IBOutlet UILabel *nonMemberLabel;
@property (strong, nonatomic) IBOutlet UIButton *nonMemberButton;
@property (strong, nonatomic) IBOutlet UIButton *memberButton;

@property (strong, nonatomic) IBOutlet UIButton *updatePhoto;
@property (strong, nonatomic) IBOutlet UITextField *groupNameField;

@property (strong, nonatomic) ContactViewController *viewContact;

@property (strong, nonatomic) UILabel *groupName;
@property (strong, nonatomic) UITextView *groupIntro;
@property (strong, nonatomic) IBOutlet UIImageView *imgv;

-(IBAction) contacts;
-(IBAction) apply;

@end
