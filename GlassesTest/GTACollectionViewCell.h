//
//  GTA.h
//  GlassesTest
//
//  Created by Ben omer on 11/28/14.
//  Copyright (c) 2014 DBBO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTACollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *cellimg;

@property (weak, nonatomic) NSURL *imageUrl;
@property (weak, nonatomic) NSData *imageData;
@property (weak, nonatomic) IBOutlet UILabel *labelText;


-(void)setImageFromData:(NSData *)data andLabelFromTitle:(NSString *)textString;

@end
