//
//  AddViewController.h
//  SQL
//
//  Created by iPhone SDK Articles on 10/26/08.
//  Copyright 2008 www.iPhoneSDKArticles.com.
//

#import <UIKit/UIKit.h>
#import "TKPeoplePickerController.h"
#import "TKContact.h"
#import "ContactsPickerViewController.h"

@class Coffee;
@class TPKeyboardAvoidingScrollView;
@class ContactsPickerViewController;

@interface AddViewController : UIViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate, TKPeoplePickerControllerDelegate, TKContactsMultiPickerControllerDelegate> {
    
    ContactsPickerViewController *viewContact;

	IBOutlet UITextField *txtCoffeeName;
	IBOutlet UITextField *txtPrice;
    
    IBOutlet UITextField *groupName;
    IBOutlet UITextView *groupIntro;
    
    IBOutlet UIImageView *imgv;
    
    NSMutableArray *_allContacts;
}

@property (nonatomic, assign) ContactsPickerViewController *viewContact;

@property (nonatomic, assign) ABAddressBookRef addressBook;

@property (nonatomic, retain) TKContactsMultiPickerController *contactController;

@property (strong, nonatomic) UITextField *groupName;
@property (strong, nonatomic) UITextView *groupIntro;
@property (strong, nonatomic) IBOutlet UIImageView *imgv;

-(void) uploadInfo;

-(IBAction)choosePhoto;
-(IBAction)foo;

@end
