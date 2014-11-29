//
//  GTA.m
//  GlassesTest
//
//  Created by Ben omer on 11/28/14.
//  Copyright (c) 2014 DBBO. All rights reserved.
//

#import "GTACollectionViewCell.h"

@implementation GTACollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setImageFromData:(NSData *)data andLabelFromTitle:(NSString *)textString  {
    
    [self.cellimg setImage:[UIImage imageWithData:data]];
    self.labelText.text = textString;
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
