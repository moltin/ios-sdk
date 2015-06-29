//
//  CollectionViewCell.h
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 15/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CollectionListCellDelegate <NSObject>

- (void)didSelectCollectionWithId:(NSString *) collectionId;

@end

@interface CollectionListCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbInfo;

@property (nonatomic, weak) id <CollectionListCellDelegate> delegate;

- (void)configureWithCollectionDict:(NSDictionary *) dictionary;
- (IBAction)btnViewCollectionTap:(id)sender;

@end
