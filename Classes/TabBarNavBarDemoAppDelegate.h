//
//  TabBarNavBarDemoAppDelegate.h
//  TabBarNavBarDemo
//
//  Created by James Lin on 19/07/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Coffee;
@class Tag;

@interface TabBarNavBarDemoAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;

    UINavigationController *navigationController;
	
	//To hold a list of Coffee objects
	NSMutableArray *coffeeArray;
    
    NSMutableArray *tagArray;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, retain) NSMutableArray *coffeeArray;

@property (nonatomic, retain) NSMutableArray *tagArray;

- (void)presentModal:(UINavigationController *)navController;
- (void)presentModal;

- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;

- (void) removeCoffee:(Coffee *)coffeeObj;
- (void) addCoffee:(Coffee *)coffeeObj;

@end

