//
//  Application.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/23/14.
//
//

#import <Foundation/Foundation.h>

@interface Application : NSObject {
    NSInteger ide;
    NSInteger groupId;
    NSString *applicant;
    NSString *groupName;
}

@property NSInteger ide;
@property NSInteger groupId;
@property (nonatomic, retain) NSString *applicant;
@property (nonatomic, retain) NSString *groupName;

@end
