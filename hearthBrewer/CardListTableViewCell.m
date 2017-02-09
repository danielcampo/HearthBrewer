//
//  CardListTableViewCell.m
//  hearthBrewer
//
//  Created by Daniel Campo on 8/14/14.
//  Copyright (c) 2014 Daniel Campo. All rights reserved.
//

#import "CardListTableViewCell.h"

@implementation CardListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


// Update Card cell with information about the card
-(void)refreshCellWithInfo:(NSInteger)cardCostNumber cardNameString:(NSString*)cardNameString cardClassString:(NSString*)cardClassString cardAttackNumber:(NSInteger)cardAttackNumber cardHealthNumber:(NSInteger)cardHealthNumber cardQuantityInDeck:(int)cardQuantityInDeck cardDescString:(NSString *)cardDescString cardImage:(UIImage *)cardImage
{
    // image
    cardImageView.image = cardImage;
    
    //cost
    NSString *cardCostValue = [[NSString alloc] initWithFormat:@"%d",(int)cardCostNumber];
    cardCost.text = cardCostValue;
    
    // name
    cardName.text = cardNameString;
    // class
    cardClass.text = cardClassString;
    // desc
    cardDesc.text = cardDescString;
    
    // attack
    NSString *cardAttackValue = [[NSString alloc] initWithFormat:@"%d",(int)cardAttackNumber];
    cardAttack.text = cardAttackValue;
    
    // health
    NSString *cardHealthValue = [[NSString alloc] initWithFormat:@"%d",(int)cardHealthNumber];
    cardHealth.text = cardHealthValue;
    
}

@end
