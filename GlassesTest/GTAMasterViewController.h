//
//  GTAMasterViewController.h
//  GlassesTest
//
//  Created by Ben omer on 11/28/14.
//  Copyright (c) 2014 DBBO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GTADetailViewController;
@class GTAFlickrAPICall;

#import <CoreData/CoreData.h>
#import "SearchViewController.h"
#import "GTAFlickrAPICall.h"

@interface GTAMasterViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, NSFetchedResultsControllerDelegate, UINavigationControllerDelegate>
{
    SearchViewController *searchTable;
    
}

@property (strong, nonatomic) GTADetailViewController *detailViewController;
@property (strong, nonatomic) GTAFlickrAPICall *flickrCall;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) UIActivityIndicatorView *av;
@property (strong, nonatomic) NSMutableArray *sectionChanges;
@property (strong, nonatomic) NSMutableArray *objectChanges;
@property (strong, nonatomic) NSString *queryText;
@property (strong, nonatomic) NSString *reloadSwitch;

- (void) deleteAllEntitiesForName:(NSString*)entityName;

@end
