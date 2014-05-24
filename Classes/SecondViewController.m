//
//  SecondViewController.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 1/29/13.
//
//

#import "SecondViewController.h"
#import "User.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

@synthesize titles, detail;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)open{
    User *user=[User sharedUser];
    NSLog(@"%@",titles.text);
   // [UIPasteboard generalPasteboard].string = user.detailID;
    if (i==0){
        [UIPasteboard generalPasteboard].string = @"#instagram #love #ground #blue #gorgeous";
    }
    else{
        [UIPasteboard generalPasteboard].string = user.detailID;
    }
   /* else{
      [UIPasteboard generalPasteboard].string = user.detailID;
    }*/
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://location?id=1"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        [[UIApplication sharedApplication] openURL:instagramURL];
    }
    [[UIApplication sharedApplication] openURL:instagramURL];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    User *user=[User sharedUser];
    
    titles.text=user.ids;
    detail.text=user.detailID;
    //NSLog(@"%@", titles.text);
    if (titles.text==NULL){
        i=0;
        titles.text=@"Best";
        detail.text=@"#instagram #love #ground #blue #gorgeous";
    }else{
        i=1;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    titles.text=@"lala";
    detail.text=@"lala";
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
