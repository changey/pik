//
//  TKContact.h
//  TKContactsMultiPicker
//
//  Created by Jongtae Ahn on 12. 8. 31..
//  Copyright (c) 2012년 TABKO Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKContact : NSObject {
    NSInteger sectionNumber;
    NSInteger recordID;
    BOOL rowSelected;
    NSString *name;
    NSString *email;
    NSString *tel;
    NSString *thumbnail;
    NSString *ide;
    NSString *job;
    NSString *university;
    NSString *gender;
    NSString *favorites;
    NSString *tagString;
    
    // Add Steph-Fongo (Thanks!)
    // View: https://github.com/Steph-Fongo/TKContactsMultiPicker/commit/f138f7a56445b69b0fe085176580c6d53b916227
    NSString *lastName;
    NSString *firstName;
}

@property NSInteger sectionNumber;
@property NSInteger recordID;
@property BOOL rowSelected;

@property (nonatomic, retain) NSString *favorites;

@property (nonatomic, retain) NSString *university;
@property (nonatomic, retain) NSString *job;
@property (nonatomic, retain) NSString *ide;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *tel;
@property (nonatomic, retain) NSString *thumbnail;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *tagString;

- (NSString*)sorterFirstName;
- (NSString*)sorterLastName;

@end