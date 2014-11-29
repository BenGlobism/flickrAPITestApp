//
//  SearchViewController.h
//  Globism
//
//  Created by Ben omer on 3/26/14.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "UINavigationController+GZDrawer.h"

@class GTAMasterViewController;


@interface SearchViewController : UITableViewController <UINavigationControllerDelegate>
{
    NSIndexPath *lastIndexPath;
    
}

@property (strong, nonatomic) GTAMasterViewController *vc;
@property (strong, nonatomic) IBOutlet UITextField *searchText;
@property (strong, nonatomic) UITapGestureRecognizer *gestureRecognizer;




@end
