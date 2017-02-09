//
//  CreateDeckCardsViewController.h
//  hearthBrewer
//
//  Created by Daniel Campo on 8/14/14.
//  Copyright (c) 2014 Daniel Campo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardListTableViewCell.h"
#import "CardClass.h"
#import "DeckClass.h"

@interface CreateDeckCardsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    // LABEL : Deck Class
    IBOutlet UILabel *deckClassLabel;
    
    // TABLEVIEW : Cards Added & Cards Available
    IBOutlet UITableView *cardsAddedTableView, *cardsAvailableTableView;

    // List of Card Types for use in filtering
    NSArray *cardTypes;
    
    NSMutableArray *cardsListOriginal, *cardsListFiltered, *createdDeck, *createdDeckFiltered;
    
    // ALERT : Maximum Cards, Card Added & Card Removed
    // User feedback while building a deck– displays when a user selects a card
    UIAlertView *maximumCardsAlert, *cardAddedAlert, *cardRemovedAlert;
    
    // Name of deck in progress, passed from a UIAlert input field when saving deck
    NSString *savedDeckNameString;
    
}

@property (strong, nonatomic) NSMutableArray *savedCardsList, *savedDecksList, *createdDeckSaved;

// Current deck in progress
@property (strong, nonatomic) DeckClass *deckInProgress;

// Final, saved deck– created when user presses the "Save Deck" button
@property (strong, nonatomic) DeckClass *savedDeck;

// handle table row selection
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


// dismiss alerts
- (void)dismissAlert:(UIAlertView*)alert;

// Filter actions
-(IBAction)filterByCost:(id)sender;
-(IBAction)filterByType:(id)sender;


// save deck
-(IBAction)saveDeck;

@end
