//
//  SecondViewController.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 1/29/13.
//
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController{
    IBOutlet UILabel *titles;
    IBOutlet UITextView *detail;
    
    int i;
}
@property(retain,nonatomic) IBOutlet UILabel *titles;
@property(retain,nonatomic) IBOutlet UITextView *detail;

-(IBAction)open;

@end
