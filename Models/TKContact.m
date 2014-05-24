//
//  TKContact.h
//  TKContactsMultiPicker
//
//  Created by Jongtae Ahn on 12. 8. 31..
//  Copyright (c) 2012년 TABKO Inc. All rights reserved.
//

#import "TKContact.h"

@implementation TKContact
@synthesize name, gender, email, tel, thumbnail, recordID, sectionNumber, rowSelected, lastName, firstName, ide, job, university, favorites, tagString;

- (id)init {
    if ((self = [super init])) {
        name = @"";
        gender = @"";
        email = @"";
        tel = @"";
        thumbnail = @"";
        job = @"";
        university = @"";
        tagString = @"";
    }
    
    return self;
}

- (void)dealloc
{
    [university release];
    [job release];
    [ide release];
    [name release];
    [email release];
    [tel release];
    [thumbnail release];
    [lastName release];
    [firstName release];
    [tagString release];
    
    [super dealloc];
}

- (NSString*)sorterFirstName {
    if (nil != firstName && ![firstName isEqualToString:@""]) {
        return firstName;
    }
    if (nil != lastName && ![lastName isEqualToString:@""]) {
        return lastName;
    }
    if (nil != name && ![name isEqualToString:@""]) {
        return name;
    }
    return nil;
}

- (NSString*)sorterLastName {
    if (nil != lastName && ![lastName isEqualToString:@""]) {
        return lastName;
    }
    if (nil != firstName && ![firstName isEqualToString:@""]) {
        return firstName;
    }
    if (nil != name && ![name isEqualToString:@""]) {
        return name;
    }
    return nil;
}

@end
