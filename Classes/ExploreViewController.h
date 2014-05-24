//
//  ExploreViewController.h
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 4/21/14.
//
//

#import <UIKit/UIKit.h>
#import "GroupSortViewController.h"

@class GroupSortViewController;

@interface ExploreViewController : UIViewController {
    GroupSortViewController *viewGroup;
}

@property (strong, nonatomic) GroupSortViewController *viewGroup;

- (IBAction) newGroup;

@end
