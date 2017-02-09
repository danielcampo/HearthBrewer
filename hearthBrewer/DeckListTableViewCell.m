//
//  DeckListTableViewCell.m
//  hearthBrewer
//
//  Created by Daniel Campo on 8/14/14.
//  Copyright (c) 2014 Daniel Campo. All rights reserved.
//

#import "DeckListTableViewCell.h"

@implementation DeckListTableViewCell

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



// TABLEVIEW DATA : Deck List Table View Cell
-(void)refreshCellWithInfo:(NSString*)deckNameString deckClassString:(NSString*)deckClassString;
{
    // card name
    deckNameLabel.text = deckNameString;
    
    // card class
    NSString *deckClassName = [[NSString alloc] initWithFormat:@"Class : %@", deckClassString];
    deckClassLabel.text = deckClassName;
}

@end
