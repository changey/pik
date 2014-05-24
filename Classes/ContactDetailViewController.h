//
//  ContactDetailViewController.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 3/11/14.
//
//

#import <UIKit/UIKit.h>

@interface ContactDetailViewController : UIViewController {
    IBOutlet UILabel *name;
    IBOutlet UILabel *gender;
    IBOutlet UILabel *job;
    IBOutlet UILabel *university;
    IBOutlet UILabel *email;
    IBOutlet UILabel *tel;
    IBOutlet UIImageView *imgv;
    
    IBOutlet UIButton *promote;
}

@property (retain, nonatomic) IBOutlet UILabel *name;
@property (retain, nonatomic) IBOutlet UILabel *gender;
@property (retain, nonatomic) IBOutlet UILabel *job;
@property (retain, nonatomic) IBOutlet UILabel *university;
@property (retain, nonatomic) IBOutlet UILabel *email;
@property (retain, nonatomic) IBOutlet UILabel *tel;
@property (retain, nonatomic) IBOutlet UIImageView *imgv;

@property (retain, nonatomic) IBOutlet UIButton *promote;

@end
