//
//  ViewDeckViewController.m
//  hearthBrewer
//
//  Created by Daniel Campo on 8/14/14.
//  Copyright (c) 2014 Daniel Campo. All rights reserved.
//

#import "ViewDeckViewController.h"
#import "HeroClass.h"
#import "CardClass.h"
#import "CardListTableViewCell.h"
#import "CardSingleViewController.h"
#import "ViewController.h"

@interface ViewDeckViewController ()

@end

@implementation ViewDeckViewController

@synthesize savedCardsList, savedDecksList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Initial View Setup
- (void)viewDidLoad
{
    // User's saved decks
    savedDecksList = self.savedDecksList;
    // Official HearthStone cards array
    savedCardsList = self.savedCardsList;
    
    // Grab Hero / Class list data
    HeroClass *heroListFromClass = [[HeroClass alloc] init];
    NSArray *heroList = [[NSArray alloc] initWithArray:heroListFromClass.heroList];
    NSArray *classList = [[NSArray alloc] initWithArray:heroListFromClass.classList];
    
    // Array to hold the deck's original cards
    cardsListOriginal = [[NSMutableArray alloc] initWithArray:self.currentDeck.deckCards];
    // Array to hold cards that will be visible during a filter
    cardsListFiltered = [[NSMutableArray alloc] initWithArray:self.currentDeck.deckCards];
  
    // Define cards types for use in filtering
    cardTypes = [[NSArray alloc] initWithObjects: @"All", @"Minion", @"Spell", @"Weapon", nil];
    
    // Get current deck's Hero data
    NSString *heroNameString = [[NSString alloc] initWithFormat:@"hero%@",self.currentDeck.deckClass];
    NSInteger classIndex = [classList indexOfObject:heroNameString];
    
    HeroClass *currentDecksHero = [[HeroClass alloc] init];
    currentDecksHero = [heroList objectAtIndex:classIndex];
    
    
    // Ensure Current Deck data is valid before proceeding
    if (self.currentDeck != nil)
    {
        // Assign properties from deck object to appropriate labels
        // LABEL : Deck Name
        deckViewName.text = self.currentDeck.deckName;
        
        // LABEL : Deck Class
        NSString *deckClassStringForLabel = [[NSString alloc] initWithFormat:@"Class : %@", self.currentDeck.deckClass];
        deckViewClass.text = deckClassStringForLabel;
        
        // UIIMAGE : Deck Class Image
        NSString *classImageName = [[NSString alloc] initWithString:currentDecksHero.heroImageThumb];
        deckViewClassImage.image = [UIImage imageNamed:classImageName];
    }
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{

}


#pragma mark - Cards List Table View Setup
// set the number of cells for cards list
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // set number of cells equal to number of cards in list array
    return [cardsListFiltered count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // reuse existing cells
    CardListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hb_deck_view_card"];
    
    if (cell != nil)
    {
        // identify current row
        CardClass *currentCard = [cardsListFiltered objectAtIndex:indexPath.row];
        
        
        // populate the cell with the card's basic information
        [cell refreshCellWithInfo:currentCard.cost cardNameString:currentCard.name cardClassString:currentCard.type cardAttackNumber:currentCard.attack cardHealthNumber:currentCard.health cardQuantityInDeck:0 cardDescString:currentCard.desc cardImage:currentCard.image];
        
    }
    return cell;
}



#pragma mark - Navigation

#pragma mark - Deck View to Single Card View Segue
// send selected card data to single card view
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // SEUGE : Card Single View
    if ([[segue identifier] isEqualToString:@"hb_view_card"])
    {
        CardSingleViewController *cardSingleViewController = segue.destinationViewController;
        
        if (cardSingleViewController != nil)
        {
            UITableViewCell *cell = (UITableViewCell*)sender; // need to "cast" the sender of the cell that is pressed
            NSIndexPath *indexPath = [cardsListTableView indexPathForCell:cell];
            
            // get the string from the array based on the item in the tableview we clicked on
            CardClass *currentCard = [self.currentDeck.deckCards objectAtIndex:indexPath.row];
            
            // Pass properties from current card to Card Single View Controller
            cardSingleViewController.currentCard = currentCard;
            cardSingleViewController.currentDeck = self.currentDeck;
            cardSingleViewController.savedCardsList = savedCardsList;
            cardSingleViewController.savedDecksList = savedDecksList;
        }
    }
    
    
    // SEGUE : View Decks List
    if ([[segue identifier] isEqualToString:@"hb_view_decks"])
    {
        ViewController *viewController = segue.destinationViewController;
        
        if (viewController != nil)
        {
            viewController.savedCardsList = savedCardsList;
            viewController.savedDecksList = savedDecksList;
        }
        
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Filter Controls

// Filter cards by cost
-(IBAction)filterByCost:(id)sender
{
    // grab tag for filter item pressed
    NSInteger costFilter = [sender tag];
    
    // reset filter list
    [cardsListFiltered removeAllObjects];
    
    for (CardClass *card in self.currentDeck.deckCards)
    {
        if (costFilter == 0)
        {
            // reset card list so we are appending another list of cards
            [cardsListFiltered removeAllObjects];
            [cardsListFiltered addObjectsFromArray:self.currentDeck.deckCards];
        }
        else if (costFilter == 7 && [card cost] >= 7)
        {
            // cards 7+
            [cardsListFiltered addObject:card];
        }
        else if (card.cost == costFilter)
        {
            // add cards to filtered card array if filter and cost match
            [cardsListFiltered addObject:card];
        }
    }
    // reload the cards list table to show filtered array of cards
    [cardsListTableView reloadData];
}

// Filter cards by type
-(IBAction)filterByType:(id)sender
{
    NSInteger filterTag = [sender tag];
    NSString *filterType = [cardTypes objectAtIndex:filterTag];
    
    // reset list
    [cardsListFiltered removeAllObjects];
    
    for (CardClass *card in self.currentDeck.deckCards)
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
    [cardsListTableView reloadData];
}


#pragma mark - Share Deck
-(IBAction)shareDeck:(id)sender
{
    // Email Subject
    NSString *emailTitle = @"Check Out My HearthStone Deck";

    // Table rows holding each card's data
    NSString *cardRows = [[NSString alloc] init];
        // Build HTML for table rows
        cardRows = [self buildHTMLCardTable];

    // Email Content
    NSString *messageBody = [[NSString alloc] initWithFormat:@"<h1 style=\"margin:0;padding:0;\">%@</h1><h3 style=\"margin:0;padding:0;\">%@</h3><br><span style=\"text-decoration:underline;\">Cards:</span><br><table cellspacing=\"0\" cellpadding=\"0\" style=\"max-width:320px;padding:0;width:100%%;\"><thead><tr><td style=\"font-weight:text-align:center;font-weight:bold;padding-bottom:10px;width:30%%\">Name</td><td style=\"color:blue;font-weight:bold;text-align:center;width:10%%\">C</td><td style=\"color:red;font-weight:bold;text-align:center;width:10%%\">A</td><td style=\"color:green;font-weight:bold;text-align:center;width:10%%\">H</td></tr></thead><tbody>%@</tbody></table><br><br>Download <a href=\"google.com\" style=\"font-weight:bold;text-decoration:underline;\">HearthBrewer</a> today to start creating and sharing decks of your own!", self.currentDeck.deckName, self.currentDeck.deckClass, cardRows];
    
    // Default "To" address
    NSArray *toRecipents = [NSArray arrayWithObject:@"your@friend.com"];
    
    // Init Mail Composer
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:YES];
    [mc setToRecipients:toRecipents];
        
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

// ALERTS : Feedback for actions done during mail
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
        switch (result)
        {
            case MFMailComposeResultCancelled:
            {
             NSLog(@"Mail Cancelled");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Deck Sharing Canceled" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            }
                break;
            case MFMailComposeResultSaved:
            {
                NSLog(@"Mail Saved");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Deck Sharing Saved" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            }
                break;
            case MFMailComposeResultSent:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your Deck Was Shared!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            }
                NSLog(@"Mail Sent");
                break;
            case MFMailComposeResultFailed:
            {
                NSLog(@"Mail Sent Failure: %@", [error localizedDescription]);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry, there was an error sharing your deck. Please try again." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            }
                break;
            default:
                break;
        }
        
        // Close the Mail Interface
        [self dismissViewControllerAnimated:YES completion:NULL];
}

-(NSString*)buildHTMLCardTable
{
    // method to dynamically build the HTML card table rows
    NSArray *currentCardsList = [[NSArray alloc] initWithArray:self.currentDeck.deckCards];
    NSInteger count = [currentCardsList count];
    
    NSMutableString *cardRowsInHTML = [[NSMutableString alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        // get current card data
        CardClass *currentCard = [currentCardsList objectAtIndex:i];
        
        // assign card properties to HTML string
        NSString *cardRow = [[NSString alloc] initWithFormat:@"<tr style=\"padding-bottom:4px;\"><td style=\"font-weight:bold;\">%@<br><span style=\"color:#aaa;font-size:x-small;\">%@</span></td><td style=\"color:blue;text-align:center;vertical-align:top;\">%d</td><td style=\"color:red;text-align:center;vertical-align:top;\">%d</td><td style=\"color:green;text-align:center;vertical-align:top;\">%d</td></tr><tr style=\"text-align:left;\"><td colspan=\"4\"><span style=\"color:#777;font-size:small;\">%@</span><br><hr></td></tr>", currentCard.name, currentCard.type, (int)currentCard.cost, (int)currentCard.attack, (int)currentCard.health, currentCard.desc];
        
        [cardRowsInHTML appendString:cardRow];
    }
    
    // return table rows in HTML
    return cardRowsInHTML;
}





@end
