//
//  Member.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/23/14.
//
//

#import <Foundation/Foundation.h>

@interface Member : NSObject {
    NSInteger ide;
    NSString *name;
    NSString *email;
    NSString *tel;
    NSString *thumbnail;
    NSString *job;
    NSString *university;
    NSString *gender;
}

@property NSInteger ide;
@property (nonatomic, retain) NSString *university;
@property (nonatomic, retain) NSString *job;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *tel;
@property (nonatomic, retain) NSString *thumbnail;


@end
