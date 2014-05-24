//
//  User.h
//  NB_list
//
//  Created by mac on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKContact.h"
#import "Member.h"
#import "Application.h"

@interface User : NSObject {
    Member *member;
    Application *application;
    
    NSString *isAdmin;
    NSInteger *isMember;
    
	NSString *correct;
	NSString *total;
    
    NSString *instructions;
    
    NSString *ids;
    NSString *detailID;
    NSString *url;
    
    NSString *groupId;
    
    NSString *user;
    NSString *pass;
    
    NSMutableArray *ids2;
    NSMutableArray *titles;
    NSMutableArray *descriptions;
    NSMutableArray *contents;
    NSMutableArray *types;
    NSMutableArray *thumbs;
    
    NSMutableArray *selected;
    NSString *select_mode;
	
    NSMutableArray *ids3;
    NSMutableArray *titles3;
    NSMutableArray *thumbs3;
    
    NSString *totalContactsAdded;
    NSString *currentContactNumber;
    
    int menu;
    
    NSString *subtitle;
    
    TKContact *contact;
    
    UITableView *autocompleteTableView;
}

@property (nonatomic, retain) NSString *isAdmin;
@property NSInteger *isMember;

@property (nonatomic, retain) Member *member;
@property (nonatomic, retain) Application *application;

@property (nonatomic, retain) NSString *totalContactsAdded;
@property (nonatomic, retain) NSString *currentContactNumber;

@property (nonatomic, retain) UITableView *autocompleteTableView;

@property (nonatomic, retain) TKContact *contact;
@property (nonatomic, retain) NSString *select_mode;

@property (nonatomic, retain) NSString *user;
@property (nonatomic, retain) NSString *pass;

@property (nonatomic, retain) NSString *subtitle;

@property (nonatomic, retain) NSString *groupId;

@property (nonatomic, retain) NSMutableDictionary *keys;
@property (nonatomic,strong) NSString *correct;
@property (nonatomic,strong) NSString *total;

@property (nonatomic,strong) NSString *instructions;

@property (nonatomic,strong) NSString *ids;
@property (nonatomic,strong) NSString *detailID;
@property (nonatomic,strong) NSString *url;

@property (nonatomic, retain) NSMutableArray *ids2;
@property (nonatomic, retain) NSMutableArray *titles;
@property (nonatomic, retain) NSMutableArray *descriptions;
@property (nonatomic, retain) NSMutableArray *contents;
@property (nonatomic, retain) NSMutableArray *types;
@property (nonatomic, retain) NSMutableArray *thumbs;

@property (nonatomic, retain) NSMutableArray *selected;

@property (nonatomic, retain) NSMutableArray *ids3;
@property (nonatomic, retain) NSMutableArray *titles3;
@property (nonatomic, retain) NSMutableArray *thumbs3;

+ (User *)sharedUser;
@end
