    //
//  User.m
//  NB_list
//
//  Created by mac on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "User.h"
static User *sharedUser = nil;
@implementation User
@synthesize instructions, correct, total, ids, detailID, url, ids2, titles, descriptions, types, thumbs, contents, ids3, titles3, thumbs3, subtitle, groupId, user, pass, selected, select_mode, contact, autocompleteTableView, totalContactsAdded, currentContactNumber,
    isAdmin, isMember, member, application;


#pragma mark -
#pragma mark Singleton Methods
/*- (id)init
{
	if ( self = [super init] )
	{
		self.keys = [[NSMutableDictionary alloc] init];
	}
	return self;
	
}*/

+ (User *)sharedUser {
	if(sharedUser == nil){
		sharedUser = [[super allocWithZone:NULL] init];
	}
	return sharedUser;
}
@end