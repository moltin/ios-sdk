//
//  CollectionViewCell.m
//  MoltinSDK iOS Example
//
//  Created by Moltin on 15/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "CollectionListCell.h"

@interface CollectionListCell()

@property (strong, nonatomic) NSString *collectionId;
@property (strong, nonatomic) NSString *collectionTitle;

@end

@implementation CollectionListCell

- (void)awakeFromNib {
    // Initialization code
    self.lbTitle.font = [UIFont fontWithName:kMoltinFontBold size:30];
    self.lbTitle.shadowColor = RGB(0, 0, 0);
    self.lbTitle.shadowOffset = CGSizeMake(1, 1);
    self.lbTitle.textColor = RGB(254, 254, 254);
    
    self.lbInfo.font = [UIFont fontWithName:kMoltinFontItalic size:16];
    self.lbInfo.shadowColor = RGB(0, 0, 0);//RGB(78, 78, 78);
    self.lbInfo.shadowOffset = CGSizeMake(1, 1);
    self.lbInfo.textColor =RGB(254, 254, 254);
}

- (void)configureWithCollectionDict:(NSDictionary *) dictionary {
    if (dictionary) {
        self.collectionId = [dictionary valueForKey:@"id"];
        self.collectionTitle = [[dictionary valueForKey:@"title"] uppercaseString];
        self.lbTitle.text = self.collectionTitle;
        self.lbInfo.text = [dictionary valueForKey:@"description"];
        [self.lbInfo sizeToFit];
        
        
        NSString *imageUrl = @"";
        NSArray *images = [dictionary objectForKey:@"images"];
        
        if (images && images.count > 0) {
            imageUrl = [[images objectAtIndex:0] valueForKeyPath:@"url.https"];
        }
        
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    }
    else{
        self.lbTitle.text = @"COLLECTION DATA IS NOT SET";
    }
}

- (IBAction)btnViewCollectionTap:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectCollectionWithId:andTitle:)]) {
        [self.delegate didSelectCollectionWithId:self.collectionId andTitle:self.collectionTitle];
    }
}

@end
