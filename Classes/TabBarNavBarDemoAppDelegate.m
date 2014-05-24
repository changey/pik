//
//  TabBarNavBarDemoAppDelegate.m
//  TabBarNavBarDemo
//
//  Created by James Lin on 19/07/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "TabBarNavBarDemoAppDelegate.h"
#import "RootViewController.h"
#import "Coffee.h"
#import "LoginViewController.h"
#import "LandingViewController.h"
#define myAppDelegate (TabBarNavBarDemoAppDelegate *) [[UIApplication sharedApplication] delegate]


@implementation TabBarNavBarDemoAppDelegate

@synthesize window;
@synthesize tabBarController;

@synthesize navigationController;
@synthesize coffeeArray, tagArray;


/*- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
}*/


/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	//Copy database to the user's phone if needed.
	[self copyDatabaseIfNeeded];
	
	//Initialize the coffee array.
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.coffeeArray = tempArray;
	[tempArray release];
    
    NSMutableArray *tempArray2 = [[NSMutableArray alloc] init];
	self.tagArray = tempArray2;
	[tempArray2 release];
	
	//Once the db is copied, get the initial data to display on the screen.
	[Coffee getInitialDataToDisplay:[self getDBPath]];
    
    //Once the db is copied, get the initial data to display on the screen.
	[Tag getInitialDataToDisplay:[self getDBPath]];
	
	// Configure and show the window
	//[window addSubview:[navigationController view]];
    window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"general_bg.png"]];
    
    
    [window addSubview:tabBarController.view];
    
    LandingViewController *landingViewController = [[LandingViewController alloc] init];
    navigationController = [[UINavigationController alloc] initWithRootViewController:landingViewController];
    
    [self presentModal:navigationController];
    
	[window makeKeyAndVisible];
}

- (void)presentModal:(UINavigationController *)navController {
    //LoginViewController *loginViewController = [[LoginViewController alloc] init];
    
    
    [self.tabBarController presentModalViewController:navController animated:YES];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
	
	//Save all the dirty coffee objects and free memory.
	[self.coffeeArray makeObjectsPerformSelector:@selector(saveAllData)];
	
	[Coffee finalizeStatements];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    
    //Save all the dirty coffee objects and free memory.
	[self.coffeeArray makeObjectsPerformSelector:@selector(saveAllData)];
}

- (void)dealloc {
    [tabBarController release];
    
	[coffeeArray release];
	[navigationController release];
	[window release];
	[super dealloc];
}

- (void) copyDatabaseIfNeeded {
	
	//Using NSFileManager we can perform many file system operations.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSString *dbPath = [self getDBPath];
	BOOL success = [fileManager fileExistsAtPath:dbPath];
	
	if(!success) {
		
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"SQL.sqlite"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if (!success)
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}
}

- (NSString *) getDBPath {
	
	//Search for standard documents using NSSearchPathForDirectoriesInDomains
	//First Param = Searching the documents directory
	//Second Param = Searching the Users directory and not the System
	//Expand any tildes and identify home directories.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"SQL.sqlite"];
}

- (void) removeCoffee:(Coffee *)coffeeObj {
	
	//Delete it from the database.
	[coffeeObj deleteCoffee];
	
	//Remove it from the array.
	[coffeeArray removeObject:coffeeObj];
}

- (void) addCoffee:(Coffee *)coffeeObj {
	
	//Add it to the database.
	[coffeeObj addCoffee];
	
	//Add it to the coffee array.
	[coffeeArray addObject:coffeeObj];
}


@end

