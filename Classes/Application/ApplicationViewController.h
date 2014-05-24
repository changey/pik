//
//  ApplicationViewController.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/22/14.
//
//

#import <UIKit/UIKit.h>
#import "ApplicantViewController.h"

@class ApplicantViewController;

@interface ApplicationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *applications;
    NSMutableArray *applicants;
    
    IBOutlet UITableView *tableView;
    
    ApplicantViewController *viewApplicant;
    
    
}

@property (strong, nonatomic) ApplicantViewController *viewApplicant;
@property (strong, nonatomic) NSMutableArray *applications;
@property (strong, nonatomic) NSMutableArray *applicants;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
