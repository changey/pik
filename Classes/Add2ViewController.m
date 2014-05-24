//
//  LoginViewController.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 2/19/14.
//
//

#import "Add2ViewController.h"
#import "User.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"

#import "TPKeyboardAvoidingScrollView.h"

@interface Add2ViewController ()

@end

@implementation Add2ViewController
//autocomplete
@synthesize urlField = urlField;
@synthesize pastUrls;
@synthesize autocompleteUrls;
@synthesize autocompleteTableView;

@synthesize imgv, groupName, groupIntro, viewContact, viewFb, identifiedTagsString, tags, ranges;

//autocomplete
- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    [autocompleteUrls removeAllObjects];
    for(NSString *curString in pastUrls) {
        NSRange substringRange = [curString rangeOfString:substring];
        if (substringRange.location == 0) {
            [autocompleteUrls addObject:curString];
        }
    }
    User *user = [User sharedUser];
    [user.autocompleteTableView reloadData];
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //user is a singleton instance
    User *user = [User sharedUser];
    
    user.autocompleteTableView.hidden = NO;
    
    int identifiedTagsStringLength = [self.identifiedTagsString length];

    int cursorLocation = range.location;
    
    //insert characters
    if (range.location >= identifiedTagsStringLength) {

        NSString *newSearch =@"";
        NSRange newRange;
        if(identifiedTagsStringLength != 0) {
            newSearch = [urlField.text substringFromIndex:identifiedTagsStringLength];
            newRange = NSMakeRange(range.location - identifiedTagsStringLength, 0);
        }
        else {
            newSearch = textField.text;
            newRange = range;
        }
        
        NSString *substring = [NSString stringWithString:newSearch];
        substring = [substring stringByReplacingCharactersInRange:newRange withString:string];
        [self searchAutocompleteEntriesWithSubstring:substring];
        
        if (cursorLocation > currentTagsRange) {
            currentTagsRange = cursorLocation;
        }
    }
    //delete tags
    else {
        if ([self.ranges count] != 0 && cursorLocation < currentTagsRange) {
            int rangeLength = [self.ranges count];
            int toBeRemovedIndex = 0;
            for (int i = 0; i< rangeLength; i++) {
                if (cursorLocation >= [[self.ranges objectAtIndex:i][0] intValue]
                    && cursorLocation <= [[self.ranges objectAtIndex:i][1] intValue]) {
                    toBeRemovedIndex = i;
                }
            }
            [self.tags removeObjectAtIndex:toBeRemovedIndex];
            [self updateRanges];
            NSString *outputString = @"";
            
            for (NSString *tag in self.tags) {
                outputString = [NSString stringWithFormat:@"%@#%@ ", outputString,
                tag];
            }
            urlField.text = outputString;
            self.identifiedTagsString = urlField.text;
            currentTagsRange = [outputString length] - 1;
        }
    }
    
    return YES;
}

- (void)updateRanges {
    self.ranges = [[NSMutableArray alloc] init];
    int startIndex = 0;

    for (NSString *tag in self.tags) {
        startIndex = [self.ranges count] == 0 ? 0 : [[self.ranges lastObject][1] intValue] + 1;

        int tagLength = [tag length];
        NSArray  *range = [NSArray arrayWithObjects:[NSNumber numberWithInt:startIndex], [NSNumber numberWithInt:startIndex + tagLength + 1], nil];
        [self.ranges addObject: range];
    }
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return autocompleteUrls.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier] autorelease];
    }
    
    cell.textLabel.text = [autocompleteUrls objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (self.identifiedTagsString == NULL) {
        self.identifiedTagsString = @"";
    }
    [self.tags addObject: selectedCell.textLabel.text];
    
    [self updateRanges];
    
    NSString *output = @"";
    for (NSString *tag in self.tags) {
        output = [NSString stringWithFormat:@"%@#%@ ", output, tag];
    }
    
    urlField.text = output;
    User *user = [User sharedUser];
    user.autocompleteTableView.hidden = YES;
    
    self.identifiedTagsString = urlField.text;
    currentTagsRange = [urlField.text length];
    
}

-(IBAction)choosePhoto{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select group picture"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Camera", @"Select from Library", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    actionSheet.tag = 0;
    
    [actionSheet showInView:self.view];
}

- (void) save_Clicked:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select a contact source"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Select from Address Book", @"Select from Facebook friends", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    actionSheet.tag = 1;
    
    [actionSheet showInView:self.view];
    
}

#pragma mark -
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //switch (actionSheet.tag) {
        if (actionSheet.tag == 0)
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
        else if (actionSheet.tag == 1)
        {
            int i = buttonIndex;
            switch(i)
            {
                case 0:
                {
                    [self uploadInfo];
                    [self chooseFromPhoneBook];
                }
                    break;
                case 1:
                {
                    [self uploadInfo];
                    [self chooseFromFB];
                }
                default:
                    // Do Nothing.........
                    break;
            }

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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //[[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    self.title = @"Add Group";
    
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
											  initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                              target:self action:@selector(cancel_Clicked:)] autorelease];
	
    UIBarButtonItem *addButton=[[UIBarButtonItem alloc] initWithTitle:@"Add contacts" style:UIBarButtonItemStylePlain target:self action:@selector(save_Clicked:)];

    self.navigationItem.rightBarButtonItem = addButton;
	
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view setUserInteractionEnabled:YES];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [groupName becomeFirstResponder];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //autocomplete
    self.pastUrls = [[NSMutableArray alloc] initWithObjects:@"MIT", @"startup", @"ninja", @"P&G", @"opensource", @"finance", @"Intel", @"Morgan Stanley",nil];

//    
//    NSURL *URL = [NSURL URLWithString:url];
//    
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
//    
//    [request startSynchronous];
//    NSError *error = [request error];
//    NSString *returnString;
//    if (!error) {
//        returnString = [request responseString];
//        
//    }
//    
//    NSArray *json = [returnString JSONValue];
//    NSMutableArray *tags = [[NSMutableArray alloc] init];
//    int length = [json count];
//    for (int i=0;i < length;i ++) {
//        [tags addObject:[json objectAtIndex:i]];
//    }
//    
//    self.pastUrls = tags;

    self.autocompleteUrls = [[NSMutableArray alloc] init];
    self.tags = [[NSMutableArray alloc] init];
    self.ranges = [[NSMutableArray alloc] init];
    currentTagsRange = 0;
    
    User *user = [User sharedUser];
    
    user.autocompleteTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 157, 320, 120) style:UITableViewStylePlain];
    user.autocompleteTableView.delegate = self;
    user.autocompleteTableView.dataSource = self;
    user.autocompleteTableView.scrollEnabled = YES;
    user.autocompleteTableView.hidden = YES;
    [self.view addSubview:user.autocompleteTableView];
    //autocomplete ended
    
    //[self.navigationController setNavigationBarHidden:YES];
    // [self.tabBarController s]
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) chooseFromPhoneBook {
    if(self.viewContact == nil) {
        //_addressBook = ABAddressBookCreate();
        ContactsPickerViewController *secondxib =
        [[ContactsPickerViewController alloc] initWithNibName:@"ContactsPickerViewController" bundle:[NSBundle mainBundle]];
        self.viewContact = secondxib;
        [secondxib release];
    }
    
    [self.navigationController pushViewController:self.viewContact animated:YES];
}

-(void) chooseFromFB {
    if(self.viewFb == nil) {
        //_addressBook = ABAddressBookCreate();
        FbContactsPickerViewController *secondxib =
        [[FbContactsPickerViewController alloc] initWithNibName:@"FbContactsPickerViewController" bundle:[NSBundle mainBundle]];
        self.viewFb = secondxib;
        [secondxib release];
    }
    
    [self.navigationController pushViewController:self.viewFb animated:YES];
}

-(void) uploadInfo{
    User *user =[User sharedUser];
    
    NSData *imageData = UIImageJPEGRepresentation(self.imgv.image, 0.1);
    
    NSString *urlString = [NSString stringWithFormat:@"%@/group_insert.php", user.url];
    
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
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // now lets make the connection to the web
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    user.groupId = returnString;
}

- (void) cancel_Clicked:(id)sender {
	
	//Dismiss the controller.
	[self.navigationController dismissModalViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	
	[theTextField resignFirstResponder];
	return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
//	[txtCoffeeName release];
//	[txtCoffeeName release];
    User *user = [User sharedUser];
    [urlField dealloc];
    [pastUrls dealloc];
    [autocompleteUrls dealloc];
    [user.autocompleteTableView dealloc];
    [super dealloc];
}

@end
