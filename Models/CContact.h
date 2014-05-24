//
//  CContact.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 2/27/14.
//
//

#import <Foundation/Foundation.h>

@interface CContact : NSObject

@property (nonatomic,strong) NSString * firstName;
@property (nonatomic,strong) NSString * lastName;
@property (nonatomic,strong) NSString * compositeName;
@property (nonatomic,strong) UIImage * image;
@property (nonatomic,strong) NSMutableDictionary * phoneInfo;
@property (nonatomic,strong) NSMutableDictionary * emailInfo;
@property (nonatomic,assign) int recordID;
@property (nonatomic,assign) int sectionNumber;


//-(NSString *)getFirstName;
//-(NSString *)getLastName;
-(NSString *)getFisrtLetterForCompositeName;

@end
