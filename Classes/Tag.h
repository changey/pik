//
//  Tag.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 1/11/13.
//
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Tag : NSObject{
    
	NSInteger tagID;
    
    NSInteger coffeeID;
	NSString *coffeeName;
	NSDecimalNumber *price;
	UIImage *coffeeImage;
    
    NSString *title;
    NSString *content;
	
	//Intrnal variables to keep track of the state of the object.
	BOOL isDirty;
	BOOL isDetailViewHydrated;
}

@property (nonatomic, readonly) NSInteger tagID;

@property (nonatomic, readonly) NSInteger coffeeID;
@property (nonatomic, copy) NSString *coffeeName;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSDecimalNumber *price;
@property (nonatomic, retain) UIImage *coffeeImage;

@property (nonatomic, readwrite) BOOL isDirty;
@property (nonatomic, readwrite) BOOL isDetailViewHydrated;

//Static methods.
+ (void) getInitialDataToDisplay:(NSString *)dbPath;
+ (void) finalizeStatements;

//Instance methods.
- (id) initWithPrimaryKey:(NSInteger)pk;
- (void) deleteCoffee;
- (void) addCoffee;
- (void) hydrateDetailViewData;
- (void) saveAllData;

@end
