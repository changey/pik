//
//  IsAdmin.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 3/5/14.
//
//

#import "IsAdmin.h"
#import "User.h"
#import "ASIHTTPRequest.h"

@implementation IsAdmin

- (void) isAdmin:(NSString*)groupId userId:(NSString*)userId {

    User *user = [User sharedUser];
    
    NSString *url = [NSString stringWithFormat:@"%@/isAdmin.php?groupId=%@&userId=%@", user.url, groupId, userId];  // server name does not match
    
    NSURL *URL = [NSURL URLWithString:url];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
    
    [request startSynchronous];
    NSError *error = [request error];
    NSString *returnString;
    if (!error) {
        // NSData* data = [request responseData];
        // returnString =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        returnString = [request responseString];
        NSLog(@"%@", returnString);
        //NSLog(@"%@",returnString);
    }
}

@end
