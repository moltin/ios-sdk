//
//  CollectionViewCell.m
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 15/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "CollectionListCell.h"

@interface CollectionListCell()

@property (strong, nonatomic) NSString *collectionId;

@end

@implementation CollectionListCell

- (void)awakeFromNib {
    // Initialization code
    self.lbTitle.font = [UIFont fontWithName:kMoltinFontBold size:30];
    self.lbTitle.shadowColor = RGB(0, 0, 0);
    self.lbTitle.shadowOffset = CGSizeMake(1, 1);
    self.lbTitle.textColor = RGB(254, 254, 254);
    
    self.lbInfo.font = [UIFont fontWithName:kMoltinFontItalic size:15];
    self.lbInfo.shadowColor = RGB(254, 254, 254);
    self.lbInfo.shadowOffset = CGSizeMake(0.5, 0.5);
    self.lbInfo.textColor = RGB(78, 78, 78);
}

- (void)configureWithCollectionDict:(NSDictionary *) dictionary
{
    if (dictionary) {
        self.collectionId = [dictionary valueForKey:@"id"];
        self.lbTitle.text = [[dictionary valueForKey:@"title"] uppercaseString];
        self.lbInfo.text = [dictionary valueForKey:@"description"];
        [self.lbInfo sizeToFit];
        
        NSString *imageUrl = @"";
        NSArray *images = [dictionary objectForKey:@"images"];
        
        if (images && images.count > 0) {
            imageUrl = [[[images objectAtIndex:0] objectForKey:@"url"] objectForKey:@"http"];
        }
        
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    }
    else{
        self.lbTitle.text = @"COLLECTION DATA IS NOT SET";
    }
}

- (IBAction)btnViewCollectionTap:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectCollectionWithId:)]) {
        [self.delegate didSelectCollectionWithId:self.collectionId];
    }
}

@end
