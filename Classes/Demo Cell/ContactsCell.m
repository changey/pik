//
//  ContactsCell.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 2/19/14.
//
//

#import "ContactsCell.h"

@implementation ContactsCell

@synthesize name, imgv, tagString, email, tel, university, job;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
