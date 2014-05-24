//
//  Group.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/6/14.
//
//

#import "Group.h"

@implementation Group
@synthesize ide, name, tagString, thumbnail, intro, location, isAdmin, isMember;

- (void)dealloc
{
    [name release];
    [tagString release];
    [thumbnail release];
    [intro release];
    [location release];
    [super dealloc];
}

@end
