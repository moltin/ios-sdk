//
//  CollectionViewCell.m
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 15/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "CollectionListCell.h"

@implementation CollectionListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configureWithCollectionDict:(NSDictionary *) dictionary
{
    self.lbTitle.text = [dictionary valueForKey:@"title"];
}

@end
