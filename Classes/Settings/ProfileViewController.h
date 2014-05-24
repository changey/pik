//
//  ProfileViewController.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/21/14.
//
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController {
    IBOutlet UILabel *name;
    IBOutlet UILabel *gender;
    IBOutlet UILabel *job;
    IBOutlet UILabel *university;
    IBOutlet UILabel *email;
    IBOutlet UILabel *tel;
    IBOutlet UIImageView *imgv;
    
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *jobLabel;
    IBOutlet UILabel *universityLabel;
    IBOutlet UILabel *emailLabel;
    IBOutlet UILabel *telLabel;
}

@property (retain, nonatomic) IBOutlet UILabel *name;
@property (retain, nonatomic) IBOutlet UILabel *gender;
@property (retain, nonatomic) IBOutlet UILabel *job;
@property (retain, nonatomic) IBOutlet UILabel *university;
@property (retain, nonatomic) IBOutlet UILabel *email;
@property (retain, nonatomic) IBOutlet UILabel *tel;
@property (retain, nonatomic) IBOutlet UIImageView *imgv;

@end
