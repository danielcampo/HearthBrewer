//
//  DeckListTableViewCell.h
//  hearthBrewer
//
//  Created by Daniel Campo on 8/14/14.
//  Copyright (c) 2014 Daniel Campo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeckListTableViewCell : UITableViewCell
{
    // LABEL : Deck Name & Deck Class
    IBOutlet UILabel *deckNameLabel, *deckClassLabel;
}

// Refresh Deck cell in View Deck view with a given deck's data
-(void)refreshCellWithInfo:(NSString*)deckNameString deckClassString:(NSString*)deckClassString;

@end
