//
//  ApplicationTableViewCell.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/22/14.
//
//

#import <UIKit/UIKit.h>

@interface ApplicationTableViewCell : UITableViewCell{
    IBOutlet UILabel *groupName;
    IBOutlet UILabel *applicant;
}

@property (nonatomic,retain) IBOutlet UILabel *groupName;
@property (nonatomic,retain) IBOutlet UILabel *applicant;

@end
