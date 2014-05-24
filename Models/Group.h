//
//  Group.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/6/14.
//
//

#import <Foundation/Foundation.h>

@interface Group : NSObject {
    NSInteger ide;
    NSString *name;
    NSString *tagString;
    NSString *thumbnail;
    NSString *intro;
    NSString *location;
    NSInteger isAdmin;
    NSInteger isMember;
}

@property NSInteger ide;
@property NSInteger isAdmin;
@property NSInteger isMember;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *tagString;
@property (nonatomic, retain) NSString *thumbnail;
@property (nonatomic, retain) NSString *intro;
@property (nonatomic, retain)  NSString *location;

@end
