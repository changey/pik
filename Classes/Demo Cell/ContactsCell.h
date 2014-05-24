//
//  ContactsCell.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 2/19/14.
//
//

#import <UIKit/UIKit.h>

@interface ContactsCell : UITableViewCell{
    IBOutlet UILabel *name;
    IBOutlet UIImageView *imgv;
    IBOutlet UILabel *tagString;
    IBOutlet UIButton *email;
    IBOutlet UIButton *tel;
    IBOutlet UILabel *job;
    IBOutlet UILabel *university;
}

@property (nonatomic,retain) IBOutlet UILabel *name;
@property (nonatomic,retain) IBOutlet UIImageView *imgv;
@property (nonatomic,retain) IBOutlet UILabel *tagString;
@property (nonatomic,retain) IBOutlet UIButton *email;
@property (nonatomic,retain) IBOutlet UIButton *tel;
@property (nonatomic,retain) IBOutlet UILabel *job;
@property (nonatomic,retain) IBOutlet UILabel *university;

@end
