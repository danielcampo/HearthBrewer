//
//  ViewDeckViewController.h
//  hearthBrewer
//
//  Created by Daniel Campo on 8/14/14.
//  Copyright (c) 2014 Daniel Campo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeckClass.h"
#import <MessageUI/MessageUI.h> // For use with Share Deck feature


// NOTE: MFMailCompose is included in order to provide proper functionality for the Share Deck feature
@interface ViewDeckViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>
{
    IBOutlet UILabel *deckViewName, *deckViewClass;
    IBOutlet UITableView *cardsListTableView;
    IBOutlet UIImageView *deckViewClassImage;
    
    NSArray *cardTypes;
    
    NSMutableArray *cardsListFiltered, *cardsListOriginal;
}

@property (nonatomic,strong) NSMutableArray *savedCardsList; // Saved Cards List
@property (nonatomic,strong) NSMutableArray *savedDecksList; // Saved Decks List
@property (nonatomic,strong) DeckClass *currentDeck; // Current Deck Being Viewed

// Filter Actions
-(IBAction)filterByCost:(id)sender;
-(IBAction)filterByType:(id)sender;

// Share Deck Action
-(IBAction)shareDeck:(id)sender;

// Method used for building the HTML table used in "Share Deck Action"
-(NSString*)buildHTMLCardTable;

@end
