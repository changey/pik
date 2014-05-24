//
//  Tag.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 1/11/13.
//
//

#import "Tag.h"
#import "TabBarNavBarDemoAppDelegate.h"

static sqlite3 *database = nil;
static sqlite3_stmt *deleteStmt = nil;
static sqlite3_stmt *addStmt = nil;
static sqlite3_stmt *detailStmt = nil;
static sqlite3_stmt *updateStmt = nil;

@implementation Tag

@synthesize tagID, title, isDetailViewHydrated;

+ (void) getInitialDataToDisplay:(NSString *)dbPath {
	
	TabBarNavBarDemoAppDelegate *appDelegate = (TabBarNavBarDemoAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "select tagID, title from tag";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
				Tag *tagObj = [[Tag alloc] initWithPrimaryKey:primaryKey];
				tagObj.title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				
				tagObj.isDirty = NO;
				
				[appDelegate.tagArray addObject:tagObj];
				[tagObj release];
			}
		}
	}
	else
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}

+ (void) finalizeStatements {
	
	if (database) sqlite3_close(database);
	if (deleteStmt) sqlite3_finalize(deleteStmt);
	if (addStmt) sqlite3_finalize(addStmt);
	if (detailStmt) sqlite3_finalize(detailStmt);
	if (updateStmt) sqlite3_finalize(updateStmt);
}

- (id) initWithPrimaryKey:(NSInteger) pk {
	
	[super init];
	tagID = pk;
	
	coffeeImage = [[UIImage alloc] init];
	isDetailViewHydrated = NO;
	
	return self;
}


- (void) dealloc {
	
	[coffeeImage release];
	[price release];
	[coffeeName release];
    [title release];
	[super dealloc];
}


@end
