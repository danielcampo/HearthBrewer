//
//  CardListTableViewCell.h
//  hearthBrewer
//
//  Created by Daniel Campo on 8/14/14.
//  Copyright (c) 2014 Daniel Campo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardListTableViewCell : UITableViewCell
{
    // Card labels
    IBOutlet UILabel *cardCost, *cardName, *cardClass, *cardAttack, *cardHealth, *cardQuantityInDeck, *cardDesc;
    // Card's artwork
    IBOutlet UIImageView *cardImageView;
}

// Refresh Card cell with data about a given Card Class object
-(void)refreshCellWithInfo:(NSInteger)cardCostNumber cardNameString:(NSString*)cardNameString cardClassString:(NSString*)cardClassString cardAttackNumber:(NSInteger)cardAttackNumber cardHealthNumber:(NSInteger)cardHealthNumber cardQuantityInDeck:(int)cardQuantityInDeck cardDescString:(NSString*)cardDescString cardImage:(UIImage*)cardImage;

@end
