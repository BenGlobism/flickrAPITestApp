//
//  GTAFlickrAPICall.m
//  GlassesTest
//
//  Created by Ben omer on 11/28/14.
//  Copyright (c) 2014 DBBO. All rights reserved.
//

#import "GTAFlickrAPICall.h"
#import "GTAAppDelegate.h"
#import "GTAMasterViewController.h"
#define kFlickrAPIKey @"bfd0323646750e48c00bffa65340ab3e"

@implementation GTAFlickrAPICall
@synthesize managedObjectContext;

- (void)searchFlickerWithTerm:(NSString *)queryText {
    if (queryText) {
    @try {
        NSLog(@"starting request");
        NSString *finalString = [queryText stringByReplacingOccurrencesOfString:@" " withString: @"_"];
        
        queryText = finalString;
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=%@&per_page=25&format=json&nojsoncallback=1",kFlickrAPIKey,queryText]]];
        
        
        
        __block NSInteger resp_code = 0;
        
        [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [urlRequest setHTTPMethod:@"GET"];
                
        [NSURLConnection sendAsynchronousRequest:urlRequest
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                                   resp_code = httpResponse.statusCode;
                                   
                                   if ([data length] > 0 && error == nil){
                                       
                                       NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                       
                                       
                                       if(resp_code == 200 ) {
                                           [self parseJsonWithDict:jsonObjects];
                                       }
                                        
                                       
                                       
                                   } else if (error != nil){
                                       NSLog(@"Error = %@", error);
                                   }
                               }];
        
    }@catch (NSException *ex) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Email Validation Error" message:[ex reason] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [myAlert show];
    }
    }
}

-(void)parseJsonWithDict:(NSDictionary*)resultsDictionary {
    
    NSError *error = nil;
    
    NSArray *objPhotos = resultsDictionary[@"photos"][@"photo"];
    
    for(NSMutableDictionary *objPhoto in objPhotos)
    {
                _farm = [objPhoto[@"farm"] intValue];
                _server = [objPhoto[@"server"] intValue];
                _secret = objPhoto[@"secret"];
                _photoID = [objPhoto[@"id"] longLongValue];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            NSString *imageURL = [self flickrFarm:_farm flickrServer:_server flickrPhotoID:_photoID flickrSecret:_secret size:@"m"];
            NSString *lImageURL = [self flickrFarm:_farm flickrServer:_server flickrPhotoID:_photoID flickrSecret:_secret size:@"b"];
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]
                                                      options:0
                                                        error:&error];
            [objPhoto setObject:imageData forKey:@"imageData"];
            [objPhoto setObject:lImageURL forKey:@"largeURL"];
        } else {
            NSString *imageURL = [self flickrFarm:_farm flickrServer:_server flickrPhotoID:_photoID flickrSecret:_secret size:@"q"];
            NSString *lImageURL = [self flickrFarm:_farm flickrServer:_server flickrPhotoID:_photoID flickrSecret:_secret size:@"c"];
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]
                                                      options:0
                                                        error:&error];
            [objPhoto setObject:imageData forKey:@"imageData"];
            [objPhoto setObject:lImageURL forKey:@"largeURL"];
        }
        
        
        
        [self cdObjectFromDictionary:objPhoto];
        
    }
    
}

- (NSManagedObject *)cdObjectFromDictionary:(NSDictionary *)dict {

if (managedObjectContext == nil) {
	managedObjectContext = [(GTAAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
}

NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:@"ImageSearchModel" inManagedObjectContext:managedObjectContext];

NSDictionary *attributes = [[NSEntityDescription entityForName:@"ImageSearchModel" inManagedObjectContext:managedObjectContext] attributesByName];

for (NSString *attr in attributes) {
    [object setValue:[dict valueForKey:attr] forKey:attr];
}

return object;

}

- (NSString *)flickrFarm:(int )farm flickrServer:(int )server flickrPhotoID:(int long long )photoID flickrSecret:(NSString *)secret size:(NSString *)size
{
    
    return [NSString stringWithFormat:@"http://farm%d.staticflickr.com/%d/%lld_%@_%@.jpg",farm,server,photoID,secret,size];
}




@end
