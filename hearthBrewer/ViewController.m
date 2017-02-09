//
//  ViewController.m
//  hearthBrewer
//
//  Created by Daniel Campo on 8/14/14.
//  Copyright (c) 2014 Daniel Campo. All rights reserved.
//

#import "ViewController.h"
#import "HeroClass.h"
#import "DeckClass.h"
#import "DeckListTableViewCell.h"
#import "ViewDeckViewController.h"
#import "CreateDeckViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize savedCardsList, savedDecksList;

- (void)viewDidLoad {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // LOAD : Saved Cards List
    // Checks to see if the HearthStone cards list has already been loaded. If not, attempt to load it via local storage.
    if ([savedCardsList count] == 0)
    {
        // PATH : Cards List
        saveCardsToDiskFilename = [[NSString alloc] init];
        saveCardsToDiskFilename = [documentsDirectory stringByAppendingPathComponent:@"savedCardsList.txt"];
        
        // Add contents of saved cards to array and then check if array is empty.
        // If the card list is not saved in local storage, proceed with building the official card list.
        loadedCardsList = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:saveCardsToDiskFilename]];
    
        if([loadedCardsList count] == 0)
        {
            // Cards list array was empty. Log it to console.
            NSLog(@"No CARDS to Load...");
            
            // Generate official HearthStone cards list and assign it main cards list array.
            self.savedCardsList = [self buildOfficialCardsArray];
            
            // Array file didn't exist... create a new one.
            loadedCardsList = [[NSMutableArray alloc] init];
            
            // Fill with cards list array generated from "buildOfficialCardsArray" method
            loadedCardsList = [self.savedCardsList mutableCopy];
            
            // Save Generated Cards List to Disk
            [NSKeyedArchiver archiveRootObject:loadedCardsList toFile:saveCardsToDiskFilename];
            
        } else {

            // Cards list was successfully loaded from local storage, assign it to main array object to handle cards– "savedCardsList"
            self.savedCardsList = loadedCardsList;
            
        }
    }
    
    // Check if Saved Cards List was successfully passed from another view via segue and then assign it to local view variable.
    if (self.savedCardsList != nil)
    {
        
        savedCardsList = self.savedCardsList;
        officialCardsList = savedCardsList;
    }
    
    
    // LOAD : Saved Decks List
    // Checks to see if the HearthStone cards list has already been loaded. If not, attempt to load it via local storage.
    savedDecksList = [[NSMutableArray alloc] initWithArray:self.savedDecksList];
   
    // Checks to see if the User Created Deck list has already been loaded. If not, attempt to load it via local storage.
    if ([savedDecksList count] == 0)
    {
        // PATH : Decks List
        saveDecksToDiskFilename = [[NSString alloc] init];
        saveDecksToDiskFilename = [documentsDirectory stringByAppendingPathComponent:@"savedDecksList.txt"];

        // Add contents of saved decks to array and then check if array is empty.
        // If the decks list is not saved in local storage, proceed with preloading example decks.
        NSMutableArray *loadedDecksList = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:saveDecksToDiskFilename]];
        if([loadedDecksList count] == 0)
        {
            // Decks list array was non-existent.
            NSLog(@"No DECKS to Load...");
            
            // Preload Sample Decks
            self.savedDecksList = [self preloadDeckListExamples];
            
            // Array file didn't exist... create a new one
            loadedDecksList = [[NSMutableArray alloc] init];

            // Fill with preloaded decks generated from "preloadDeckListExamples."
            loadedDecksList = [self.savedDecksList mutableCopy];
            
            // Save Decks List to Disk
            [NSKeyedArchiver archiveRootObject:loadedDecksList toFile:saveDecksToDiskFilename];
        }
        
        self.savedDecksList = loadedDecksList;
        savedDecksList = loadedDecksList;
    }

    // savedDeck will only contain a value if the user has just saved a deck.
    // If so, add the newly created deck to the Saved Decks List and then save it to local storage.
    if (self.savedDeck != nil)
    {
        // file : decks
        saveDecksToDiskFilename = [[NSString alloc] init];
        saveDecksToDiskFilename = [documentsDirectory stringByAppendingPathComponent:@"savedDecksList.txt"];
        
        DeckClass *newDeck = [[DeckClass alloc] init];
        newDeck.deckName = self.savedDeck.deckName; newDeck.deckClass = self.savedDeck.deckClass; newDeck.deckCards = self.savedDeck.deckCards;
        [savedDecksList addObject:newDeck];
        [NSKeyedArchiver archiveRootObject:savedDecksList toFile:saveDecksToDiskFilename];
    }
    
    // Assign saved decks list data to local decks list variable
    if ([savedDecksList count] != 0) {
        deckList = savedDecksList;
    }
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)viewWillAppear:(BOOL)animated
{
    
    
}


// -----------------------------
// -----------------------------
#pragma - Build Deck List TableView
// -----------------------------
// -----------------------------

// set the number of cells for cards list
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // set number of cells equal to number of cards in list array
    return [deckList count];
}

// current deck list
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // reuse existing cells
    DeckListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hb_deck"];
    
    if (cell != nil)
    {
        // identify current row
        DeckClass *currentDeck = [deckList objectAtIndex:indexPath.row];
        
        // populate the cell with the card's basic information
        [cell refreshCellWithInfo:currentDeck.deckName deckClassString:currentDeck.deckClass];
    }
    return cell;
}

// Enable table editing
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Remove the deleted object from Saved Decks List.
        [self.savedDecksList removeObjectAtIndex:indexPath.row];
        
        // Save Updated Decks List to Disk
        [NSKeyedArchiver archiveRootObject:savedDecksList toFile:saveDecksToDiskFilename];
        
        [tableView reloadData]; // tell Deck List table to refresh now
    }
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // SEGUE : View Selected Deck
    if ([[segue identifier] isEqualToString:@"hb_view_existing"])
    {
        ViewDeckViewController *viewDeckViewController = segue.destinationViewController;
        
        if (viewDeckViewController != nil)
        {
            UITableViewCell *cell = (UITableViewCell*)sender; // need to "cast" the sender of the cell that is pressed
            NSIndexPath *indexPath = [deckListTableView indexPathForCell:cell];
            
            // Get Deck based on the item in the tableview that was pressed
            DeckClass *currentDeck = [deckList objectAtIndex:indexPath.row];
            
            // SEGUE DATA : Selected Deck, Saved Cards List, Saved Decks List
            viewDeckViewController.currentDeck = currentDeck;
            viewDeckViewController.savedCardsList = officialCardsList;
            viewDeckViewController.savedDecksList = savedDecksList;
        }
    }
    
    // SEGUE : Create New Deck
    if ([[segue identifier] isEqualToString:@"hb_create_deck"])
    {
        CreateDeckViewController *createDeckViewController = segue.destinationViewController;
        
        if (createDeckViewController != nil)
        {
            // SEGUE DATA : Saved Cards List, Saved Decks List
            createDeckViewController.savedCardsList = officialCardsList;
            createDeckViewController.savedDecksList = savedDecksList;
        }
    }
}







// -----------------------------
// -----------------------------
// -----------------------------
#pragma - Build Full Cards Array
// -----------------------------
// -----------------------------
// -----------------------------
-(NSMutableArray*)buildOfficialCardsArray
{
    officialCardsList = [[NSMutableArray alloc] init];
    
    // PATH : JSON File Containing Cards List Data
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"all-cards" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    
    NSDictionary *wikiaData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    
    NSArray *wikiaDataBasic = [wikiaData objectForKey:@"cards"];
    
    for (NSInteger i = 0; i < 50; i++)
    {
        CardClass *card = [self createCardFromDictionary:[wikiaDataBasic objectAtIndex:i]];
        
        if (card != nil)
        {
            NSString *currentCardType = [card type];
            
            // Grab only specific cards types. We do not want to grab Hero cards or other unofficial in-game cards.
            if ([currentCardType  isEqual: @"Weapon"] || [currentCardType  isEqual: @"Minion"] || [currentCardType  isEqual: @"Spell"])
            {
                [officialCardsList addObject:card];
            }
        }
    }
    
    return officialCardsList;
}





// -----------------------------
// -----------------------------
// -----------------------------
#pragma - Build Individual Cards
// -----------------------------
// -----------------------------
// -----------------------------
-(CardClass*)createCardFromDictionary:(NSDictionary*)cardsListDictionary
{
    // Build a card from the data generated from the JSON call
    NSString *cardName = [cardsListDictionary objectForKey:@"name"];
    NSString *cardType = [cardsListDictionary objectForKey:@"type"];
    NSString *cardHero = [cardsListDictionary objectForKey:@"hero"];
    NSString *cardDesc = [cardsListDictionary objectForKey:@"text"];
    NSString *imageURLString = [cardsListDictionary objectForKey:@"image_url"];
    NSData *imageURL = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURLString]];
    UIImage *cardImage = [UIImage imageWithData:imageURL];
    int cardCost = [[cardsListDictionary objectForKey:@"cost"] intValue];
    
    int cardAttack;
    // Ensure we are not grabbing Hero cards.
    // Checks to make sure current card is not a hero card and then grabs attack number.
    if (![[cardsListDictionary objectForKey:@"type"] isEqualToString:@"hero"])
    {
        cardAttack = [[cardsListDictionary objectForKey:@"attack"] intValue];
    }

    int cardHealth = [[cardsListDictionary objectForKey:@"health"] intValue];
  
    // Create final Card Class object
    CardClass *hearthStoneCard = [[CardClass alloc] initWithCardInfo:cardName cardType:cardType cardHero:cardHero cardDesc:cardDesc cardCost:cardCost cardAttack:cardAttack cardHealth:cardHealth cardImage:cardImage];

    return hearthStoneCard;
}


// -----------------------------
// -----------------------------
// -----------------------------
#pragma - Preload Example Decks
// -----------------------------
// -----------------------------
// -----------------------------
-(NSMutableArray*)preloadDeckListExamples
{
    // Sample Decks
    DeckClass *deck001 = [[DeckClass alloc] init];
    deck001.deckName = @"Insatiable Rogue"; deck001.deckClass = @"Rogue"; deck001.deckCards = [[NSMutableArray alloc] init];
    
    DeckClass *deck002 = [[DeckClass alloc] init];
    deck002.deckName = @"Control Warrior"; deck002.deckClass = @"Warrior"; deck002.deckCards = [[NSMutableArray alloc] init];
    
    DeckClass *deck003 = [[DeckClass alloc] init];
    deck003.deckName = @"Zoolock"; deck003.deckClass = @"Warlock"; deck003.deckCards = [[NSMutableArray alloc] init];
    
    // SAMPLE DECK LIST CREATION ----------------------/
    // Add Sample Decks to Current Deck List
    deckList = [[NSMutableArray alloc] initWithObjects:deck001, deck002, deck003, nil];
    
    savedDecksList = deckList;
    
    for (DeckClass *deck in deckList)
    {
        // Randomly select 30 cards for each preloaded deck
        for (int i = 0; [deck.deckCards count] <= 30; i++)
        {
            int lowerBound = 0;
            NSUInteger upperBound = [officialCardsList count];
            int randomCard = lowerBound + arc4random() % (upperBound - lowerBound);
            
            CardClass *cardPicked = [officialCardsList objectAtIndex:randomCard];
            
            // Ensure we are only adding cards the current deck class can use.
            // i.e.: A Rogue can only use Rogue or Neutral class cards.
            if ([cardPicked.hero isEqualToString:deck.deckClass] || [cardPicked.hero isEqualToString:@"neutral"])
            {
                [deck.deckCards addObject:[officialCardsList objectAtIndex:randomCard]];
            }
        }
    }
    
    return deckList;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
