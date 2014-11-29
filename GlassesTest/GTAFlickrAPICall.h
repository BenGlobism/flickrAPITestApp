//
//  GTAFlickrAPICall.h
//  GlassesTest
//
//  Created by Ben omer on 11/28/14.
//  Copyright (c) 2014 DBBO. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface GTAFlickrAPICall : NSObject

@property(strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property(nonatomic) long long photoID;
@property(nonatomic) NSInteger farm;
@property(nonatomic) NSInteger server;
@property(nonatomic,strong) NSString *secret;

- (void)searchFlickerWithTerm:(NSString *)queryText;




@end
