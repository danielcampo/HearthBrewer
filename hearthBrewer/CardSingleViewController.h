//
//  CardSingleViewController.h
//  hearthBrewer
//
//  Created by Daniel Campo on 8/14/14.
//  Copyright (c) 2014 Daniel Campo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeckClass.h"
#import "CardClass.h"

@interface CardSingleViewController : UIViewController
{
    IBOutlet UILabel *name, *type, *desc, *cost, *attack, *health;
    IBOutlet UIImageView *image;
}

// DeckClass object where card was viewed from, contains all information about the deck
@property (nonatomic,strong) DeckClass *currentDeck;

// CardClass object that is currently being viewed
@property (nonatomic,strong) CardClass *currentCard;

// Saved HearthStone cards list and User created decks
@property (nonatomic,strong) NSMutableArray *savedDecksList, *savedCardsList;

@end
