//
//  Member.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/23/14.
//
//

#import "Member.h"

@implementation Member
@synthesize name, gender, email, tel, thumbnail, ide, job, university;

- (id)init {
    if ((self = [super init])) {
        name = @"";
        gender = @"";
        email = @"";
        tel = @"";
        thumbnail = @"";
        job = @"";
        university = @"";
    }
    
    return self;
}

- (void)dealloc
{
    [university release];
    [job release];
    [name release];
    [email release];
    [tel release];
    [thumbnail release];
    
    [super dealloc];
}

@end
