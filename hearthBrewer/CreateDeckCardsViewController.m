//
//  CreateDeckCardsViewController.m
//  hearthBrewer
//
//  Created by Daniel Campo on 8/14/14.
//  Copyright (c) 2014 Daniel Campo. All rights reserved.
//

#import "CreateDeckCardsViewController.h"
#import "CreateDeckViewController.h"
#import "CardListTableViewCell.h"
#import "CardClass.h"
#import "DeckClass.h"
#import "ViewController.h"

@interface CreateDeckCardsViewController ()

@end

@implementation CreateDeckCardsViewController

@synthesize savedCardsList, savedDecksList, createdDeckSaved, deckInProgress, savedDeck;

- (void)viewDidLoad
{
    // Checks to see if there is already a deck creation in progress
    // If not, sets the deck class
    if (self.deckInProgress != nil)
    {
        deckClassLabel.text = self.deckInProgress.deckClass;
    }
    // If so, set Deck class to current deck class
    else
    {
        deckClassLabel.text = deckInProgress.deckClass;
    }

    // Initialize a new Deck to store final cards
    createdDeck = [[NSMutableArray alloc] init];
    
    // Create filter array from Saved Cards List to populate Table View
    cardsListFiltered = [[NSMutableArray alloc] initWithArray:self.savedCardsList];
    
    // Initialize arrays for saving the created deck and filtered deck
    // For use in segues
    createdDeckSaved = [[NSMutableArray alloc] init];
    createdDeckFiltered = [[NSMutableArray alloc] init];
    
    // define card types
    cardTypes = [[NSArray alloc] initWithObjects: @"All", @"Minion", @"Spell", @"Weapon", nil];
    

    // Alert feedbacks for modifying current deck in progress
    // ALERT : Shown when a user has reach the maximum number of cards to add to a deck
    maximumCardsAlert = [[UIAlertView alloc] initWithTitle:@"Unable to Add Card"
                                                    message:@"You have reached the maximum amount of cards. Please remove cards from deck and try again."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    // ALERT : Shown when a user adds a card
    cardAddedAlert = [[UIAlertView alloc] initWithTitle:@"Card Added"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil];
    
    // ALERT : Shown when a user removes a card from a deck
    cardRemovedAlert = [[UIAlertView alloc] initWithTitle:@"Card Removed"
                                                message:nil
                                               delegate:self
                                      cancelButtonTitle:nil
                                      otherButtonTitles:nil];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)viewDidAppear:(BOOL)animated
{

    // TAB : Cards Added
    // Pass data from the Available Cards List tab view over to the Cards Added tab view
    if ([self.restorationIdentifier isEqualToString:@"hb_create_deck_cards_added"])
    {
        CreateDeckCardsViewController *myVC = (CreateDeckCardsViewController*)[self.tabBarController.viewControllers objectAtIndex:0];
        
        // Current saved deck in progress
        createdDeckSaved = myVC.createdDeckSaved;
        
        // HearthStone saved cards list
        savedCardsList = myVC.savedCardsList;
        
        // User's saved decks
        deckInProgress = myVC.deckInProgress;
        
        // Cards list to populate cards list table view
        createdDeckFiltered = [[NSMutableArray alloc] initWithArray:createdDeckSaved];
        
        // LABEL : Deck Class
        deckClassLabel.text = deckInProgress.deckClass;        
        
        [cardsAddedTableView reloadData];
    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Cards List Table View Setup
// set the number of cells for cards list
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // TABLEVIEW : Cards Available
    if ([[tableView restorationIdentifier] isEqualToString:@"hb_create_available"])
    {
        // set number of cells equal to number of cards in list array
        return [cardsListFiltered count];
    }
    // TABLEVIEW : Cards Added
    else if ([[tableView restorationIdentifier] isEqualToString:@"hb_create_added"])
    {
        // set number of cells equal to number of cards in list array
        return [createdDeckFiltered count];
    }
    
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // reuse existing cells
    CardListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hb_deck_view_card"];
    
    if ([[tableView restorationIdentifier] isEqualToString:@"hb_create_available"])
    {
        if (cell != nil)
        {
            // identify card's current row in table
            CardClass *currentCard = [cardsListFiltered objectAtIndex:indexPath.row];
            
            // populate the cell with the card's basic information
            [cell refreshCellWithInfo:currentCard.cost cardNameString:currentCard.name cardClassString:currentCard.type cardAttackNumber:currentCard.attack cardHealthNumber:currentCard.health cardQuantityInDeck:1 cardDescString:currentCard.desc cardImage:currentCard.image];
            
        }
    }
    
    if ([[tableView restorationIdentifier] isEqualToString:@"hb_create_added"])
    {
        if (cell != nil)
        {
            // identify card's current row in table
            CardClass *currentCard = [createdDeckFiltered objectAtIndex:indexPath.row];
            
            // populate the cell with the card's basic information
            [cell refreshCellWithInfo:currentCard.cost cardNameString:currentCard.name cardClassString:currentCard.type cardAttackNumber:currentCard.attack cardHealthNumber:currentCard.health cardQuantityInDeck:1 cardDescString:currentCard.desc cardImage:currentCard.image];
        }
    }
    return cell;
}

// Handles card adding and removing functions
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TABLEVIEW : Cards Available
    // Cards selected in this tableview will be ADDED to the current deck in progress array
    if ([[tableView restorationIdentifier] isEqualToString:@"hb_create_available"])
    {
        CardClass *selectedCard = [self.savedCardsList objectAtIndex:indexPath.row];
        
        NSLog(@"Card Added: %@", selectedCard.name);
        
        if ([createdDeckSaved count] <= 30)
        {
            // ALERT : added card
            [cardAddedAlert show];
            
            // add card to current deck in progress array
            [createdDeckSaved addObject:selectedCard];
            
            // ensure alerts are synced with action
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSelector:@selector(dismissAlert:) withObject:cardAddedAlert];
            });
            
        }
        
        else {
            // ALERT : maximum cards added
            [maximumCardsAlert show];
        }
    }
    
    
    // TABLEVIEW : Cards Added
    // Cards selected in this tableview will be REMOVED from the current deck in progress array
    if ([[tableView restorationIdentifier] isEqualToString:@"hb_create_added"])
    {
        CardClass *selectedCard = [self.savedCardsList objectAtIndex:indexPath.row];
        NSLog(@"Card Removed: %@", selectedCard.name);
        
        // ALERT : removed card
        [cardRemovedAlert show];
        
        // remove card from array
        [createdDeckSaved removeObjectAtIndex:indexPath.row];

        dispatch_async(dispatch_get_main_queue(), ^{
            [cardsAddedTableView reloadData];
            [self performSelector:@selector(dismissAlert:) withObject:cardRemovedAlert];
        });
    }
    
    
}



// automatically dismiss alerts
- (void)dismissAlert:(UIAlertView*)alert
{
    // dismiss alert
    [alert dismissWithClickedButtonIndex:-1 animated:YES];
}




#pragma mark - Filter Controls

// Filter cards by COST
-(IBAction)filterByCost:(id)sender
{
    // grab tag for filter item pressed
    NSInteger costFilter = [sender tag];
    
    // available cards filter
    if ([self.restorationIdentifier isEqualToString:@"hb_create_deck_cards_available"])
    {
        
        // reset filter list
        [cardsListFiltered removeAllObjects];
        
        for (CardClass *card in self.savedCardsList)
        {
            
            if (costFilter == 0)
            {
                // reset card list so we are appending another list of cards
                [cardsListFiltered removeAllObjects];
                [cardsListFiltered addObjectsFromArray:self.savedCardsList];
            }
            else if (costFilter == 7 && card.cost >= 7)
            {
                // cards 7+
                [cardsListFiltered addObject:card];
            }
            else if (card.cost == costFilter)
            {
                [cardsListFiltered addObject:card];
            }
        }
        [cardsAvailableTableView reloadData];
    }
    
    
    // added cards filter
    if ([self.restorationIdentifier isEqualToString:@"hb_create_deck_cards_added"])
    {
        
        // reset filter
        [createdDeckFiltered removeAllObjects];
        
        for (CardClass *card in createdDeckSaved)
        {
            
            if (costFilter == 0)
            {
                // reset card list so we are appending another list of cards
                [createdDeckFiltered removeAllObjects];
                [createdDeckFiltered addObjectsFromArray:createdDeckSaved];
            }
            else if (costFilter == 7 && card.cost >= 7)
            {
                // cards 7+
                [createdDeckFiltered addObject:card];
            }
            else if (card.cost == costFilter)
            {
                [createdDeckFiltered addObject:card];
            }
        }
        [cardsAddedTableView reloadData];
    }
    
    
}

// Filter cards by TYPE
-(IBAction)filterByType:(id)sender
{
    NSInteger filterTag = [sender tag];
    NSString *filterType = [cardTypes objectAtIndex:filterTag];
    
    // reset list
    [cardsListFiltered removeAllObjects];

    // available cards filter
    if ([self.restorationIdentifier isEqualToString:@"hb_create_deck_cards_available"])
    {
        for (CardClass *card in self.savedCardsList)
        {
            NSLog(@"Type: %@", card.type);
            // add all cards if `all` is selected
            if ([filterType isEqual: [cardTypes objectAtIndex:0]])
            {
                [cardsListFiltered addObject:card];
            }
            // add cards based on `type` filter
            else if ([card.type isEqualToString:filterType])
            {
                [cardsListFiltered addObject:card];
            }
        }
        [cardsAvailableTableView reloadData];
    }
    
    
    
    // added cards filter
    if ([self.restorationIdentifier isEqualToString:@"hb_create_deck_cards_added"])
    {
        
        // reset filter
        [createdDeckFiltered removeAllObjects];
        
        for (CardClass *card in createdDeckSaved)
        {
            
            NSLog(@"Type: %@", card.type);
            // add all cards if `all` is selected
            if ([filterType isEqual: [cardTypes objectAtIndex:0]])
            {
                [createdDeckFiltered addObject:card];
            }
            // add cards based on `type` filter
            else if ([card.type isEqualToString:filterType])
            {
                [createdDeckFiltered addObject:card];
            }
        }
        [cardsAddedTableView reloadData];
    }
    
}


// Save Deck prompts the user to enter a Deck Name
-(IBAction)saveDeck
{
    // ALERT : Enter Deck Name
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Enter Deck Name" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil] ;
    
    // Add a text input field to alert to allow for entering Deck Name
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    // Show alert
    [alertView show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    // Grab data from alert's input field (Deck Name)
    UITextField * alertTextField = [alertView textFieldAtIndex:0];
    NSLog(@"Deck Name : %@",alertTextField.text);
    
    // Create Deck Class object to hold deck in progress data
    savedDeck = [[DeckClass alloc] init];
        // Deck Name
        savedDeck.deckName = alertTextField.text;
        // Deck Cards
        savedDeck.deckCards = createdDeckSaved;
        // Deck Class
        savedDeck.deckClass = deckInProgress.deckClass;
    
    // SEGUE [Manual] : View Decks
    // Manually triggers a segue to allow us to pass data back to View Decks view
    [self performSegueWithIdentifier:@"hb_view_decks" sender:self];
    
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // SEGUE : View Decks
    // Returns back to View Decks view and passes all necessary deck list, cards list and current decik in progress data
    if ([[segue identifier] isEqualToString:@"hb_view_decks"])
    {
        ViewController *viewController = segue.destinationViewController;
    
        if (viewController != nil)
        {
            viewController.savedDeck = savedDeck;
            viewController.savedCardsList = savedCardsList;
            viewController.savedDecksList = savedDecksList;
            
        }
        
    }
    // SEGUE : Create Deck (Class Select)
    // Returns user back to class selection screen
    else
    {
        ViewController *createDeckViewController = segue.destinationViewController;
        
        createDeckViewController.savedCardsList = savedCardsList;
        createDeckViewController.savedDecksList = savedDecksList;
    }
    
}


@end
