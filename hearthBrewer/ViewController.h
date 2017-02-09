//
//  ViewController.h
//  hearthBrewer
//
//  Created by Daniel Campo on 8/14/14.
//  Copyright (c) 2014 Daniel Campo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardClass.h"
#import "DeckClass.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    // Paths to stored Cards and Decks data
    NSString *saveCardsToDiskFilename, *saveDecksToDiskFilename;
    
    NSMutableArray *deckList, *officialCardsList, *loadedCardsList;
    IBOutlet UITableView *deckListTableView;
}

@property (nonatomic,strong) NSMutableArray *savedCardsList; // Saved Cards List
@property (nonatomic,strong) NSMutableArray *savedDecksList; // Saved Decks List
@property (nonatomic,strong) DeckClass *savedDeck; // Newly Created Deck – Only Passes When a New Deck is Saved


-(NSMutableArray*)buildOfficialCardsArray; // Method to build official cards list
-(CardClass*)createCardFromDictionary:(NSDictionary*)cardsListDictionary; // Create individual card objects from above method
-(NSMutableArray*)preloadDeckListExamples; // Preload example decks - only called if there are no saved decks


@end

