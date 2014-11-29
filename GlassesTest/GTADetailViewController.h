//
//  GTADetailViewController.h
//  GlassesTest
//
//  Created by Ben omer on 11/28/14.
//  Copyright (c) 2014 DBBO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTADetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UIImageView *imageDetail;

@end
