//
//  AddViewController.m
//  SQL
//
//  Created by iPhone SDK Articles on 10/26/08.
//  Copyright 2008 www.iPhoneSDKArticles.com.
//

#import "AddViewController.h"
#import "Coffee.h"
#import "TabBarNavBarDemoAppDelegate.h"

#import "TPKeyboardAvoidingScrollView.h"
#import "User.h"

@implementation AddViewController

@synthesize imgv, groupName, groupIntro, viewContact;

// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Add Group";
 
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] 
											  initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
											   target:self action:@selector(cancel_Clicked:)] autorelease];
	
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] 
											   initWithBarButtonSystemItem:UIBarButtonSystemItemSave 
											   target:self action:@selector(save_Clicked:)] autorelease];
	
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
 }

-(IBAction)choosePhoto{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select group picture"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Camera", @"Select from Library", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showInView:self.view];
}

#pragma mark -
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    int i = buttonIndex;
    switch(i)
    {
        case 0:
        {
            UIImagePickerController * picker = [[[UIImagePickerController alloc] init] autorelease];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:^{}];
        }
            break;
        case 1:
        {
            UIImagePickerController * picker = [[[UIImagePickerController alloc] init] autorelease];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:^{}];
        }
        default:
            // Do Nothing.........
            break;
    }
}

#pragma mark -
#pragma - mark Selecting Image from Camera and Library
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Picking Image from Camera/ Library
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *chosenImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    if (!chosenImage)
    {
        return;
    }
    
    // Adjusting Image Orientation
    NSData *data = UIImagePNGRepresentation(chosenImage);
    UIImage *tmp = [UIImage imageWithData:data];
    UIImage *fixed = [UIImage imageWithCGImage:tmp.CGImage
                                         scale:chosenImage.scale
                                   orientation:chosenImage.imageOrientation];
    chosenImage = fixed;
    self.imgv.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	//Set the textboxes to empty string.
	txtCoffeeName.text = @"";
	txtPrice.text = @"";
	
	//Make the coffe name textfield to be the first responder.
	[txtCoffeeName becomeFirstResponder];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void) save_Clicked:(id)sender {
	
	TabBarNavBarDemoAppDelegate *appDelegate = (TabBarNavBarDemoAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	//Create a Coffee Object.
	Coffee *coffeeObj = [[Coffee alloc] initWithPrimaryKey:0];
	coffeeObj.coffeeName = txtCoffeeName.text;
    coffeeObj.tags = txtPrice.text;
	NSDecimalNumber *temp = [[NSDecimalNumber alloc] initWithString:txtPrice.text];
	coffeeObj.price = temp;
    
   // coffeeObj.title
    
	[temp release];
	coffeeObj.isDirty = NO;
	coffeeObj.isDetailViewHydrated = YES;
	
	//Add the object
	[appDelegate addCoffee:coffeeObj];
    
    [self uploadInfo];
    
//    if(self.viewContact == nil) {
//        ContactViewController *secondxib =
//        [[ContactViewController alloc] initWithNibName:@"ContactViewController" bundle:[NSBundle mainBundle]];
//        self.viewContact = secondxib;
//        [secondxib release];
//    }
//    
//    [self.navigationController pushViewController:self.viewContact animated:YES];
    
//    _addressBook = ABAddressBookCreate();
//	TKContactsMultiPickerController *contactMultiController = [[TKContactsMultiPickerController alloc] initWithGroup:nil];
//    contactMultiController.delegate = self;
//    self.contactController = contactMultiController;
    
    
//    TKPeoplePickerController *controller = [[[TKPeoplePickerController alloc] initPeoplePicker] autorelease];
//    controller.actionDelegate = self;
//    controller.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:controller animated:YES completion:nil];
    if(self.viewContact == nil) {
        //_addressBook = ABAddressBookCreate();
        ContactsPickerViewController *secondxib =
        [[ContactsPickerViewController alloc] initWithNibName:@"ContactsPickerViewController" bundle:[NSBundle mainBundle]];
        self.viewContact = secondxib;
        [secondxib release];
    }
    
    [self.navigationController pushViewController:self.viewContact animated:YES];
    
//    ABPeoplePickerNavigationController *picker =
//    [[ABPeoplePickerNavigationController alloc] init];
//    picker.peoplePickerDelegate = self;
//    
//    [self.navigationController presentModalViewController:picker animated:YES];
	//Dismiss the controller.
//	[self.navigationController dismissModalViewControllerAnimated:YES];
    
    
}

-(IBAction)foo {
    if(self.viewContact == nil) {
        
    }
    NSLog(@"lala");
    
//    //_addressBook = ABAddressBookCreate();
    ContactsPickerViewController *secondxib =
    [[ContactsPickerViewController alloc] initWithNibName:@"ContactsPickerViewController" bundle:[NSBundle mainBundle]];
    self.viewContact = secondxib;
    [secondxib release];
    
//    UINavigationController *navigationController= [[UINavigationController alloc] initWithRootViewController:self.viewContact];
    
//
//    NSLog(self);
    TabBarNavBarDemoAppDelegate *del = (TabBarNavBarDemoAppDelegate *)[UIApplication sharedApplication].delegate;
    //[self.view.window.]
  //  [del.navigationController pushViewController:self.viewContact animated:YES];
    
    //[self.navigationController pushViewController:self.viewContact animated:YES];
}


-(void) uploadInfo{
    User *user =[User sharedUser];
    
    //user.url=@"http://192.168.1.173";
 
    NSData *imageData = UIImageJPEGRepresentation(self.imgv.image, 0.1);
    
    NSString *urlString = [NSString stringWithFormat:@"%@/upload.php", user.url];
    
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"image\"; filename=\"dr3.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *groupNameStr = groupName.text;
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"groupName\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[groupNameStr dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *groupIntroStr = groupIntro.text;
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"groupIntro\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[groupIntroStr dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //NSLog(@"%@", jsonString);
   // NSLog(@"%@", user.receiver_number);
    
//    NSString *receiver_number_s=[NSString stringWithFormat:@"%@", user.receiver_number];
//    NSString *receiver_number_s2 = [receiver_number_s stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSLog(@"%@", receiver_number_s2);
//    
//    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"receiver_number\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[receiver_number_s2 dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // now lets make the connection to the web
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", returnString);

    
}

- (void) cancel_Clicked:(id)sender {
	
	//Dismiss the controller.
	[self.navigationController dismissModalViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	
	[theTextField resignFirstResponder];
	return YES;
}

- (void)dealloc {
	[txtCoffeeName release];
	[txtCoffeeName release];
    [super dealloc];
}


@end
