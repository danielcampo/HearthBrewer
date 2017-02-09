//
//  CreateDeckViewController.m
//  hearthBrewer
//
//  Created by Daniel Campo on 8/14/14.
//  Copyright (c) 2014 Daniel Campo. All rights reserved.
//

#import "CreateDeckViewController.h"
#import "ViewController.h"
#import "HeroClass.h"
#import "CreateDeckCardsViewController.h"

@interface CreateDeckViewController ()

@end

@implementation CreateDeckViewController

@synthesize savedCardsList, savedDecksList, deckInProgress;

- (void)viewDidLoad
{
    // initialize current deck in progress
    deckInProgress = [[DeckClass alloc] init];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - Choose Class Portrait Switcher
-(IBAction)selectClass:(id)sender
{
    // Set to ensure we can trigger segue to Create Deck Cards view
    readyForSegue = YES;
    
    // Assign button tag to selected Class
    NSInteger selectedHerosIndex = [sender tag];
    
    // Grab Hero / Class list data
    HeroClass *heroListFromClass = [[HeroClass alloc] init];
    NSArray *heroList = [[NSArray alloc] initWithArray:heroListFromClass.heroList];
    NSArray *classList = [[NSArray alloc] initWithArray:heroListFromClass.classList];
    
    // Get Hero / Class string
    NSString *heroNameString = [[NSString alloc] initWithFormat:@"%@",[classList objectAtIndex:selectedHerosIndex]];
    NSInteger classIndex = [classList indexOfObject:heroNameString];
    
    // Get current deck's Hero data
    HeroClass *currentSelectedHero = [[HeroClass alloc] init];
    currentSelectedHero = [heroList objectAtIndex:classIndex];
    
    // Get string of Hero's image name
    heroPortraitImageString = currentSelectedHero.heroImage;
    // UIIMAGE : Deck Class Portrait Image
    selectedClassImage.image = [UIImage imageNamed:heroPortraitImageString];
    
    // Assign Class to deck in progress
    deckInProgress.deckClass = currentSelectedHero.heroClass;
}



// Checks to see if a Class has been selected.
// If so, triggers a manual segue to proceed to Create Available Cards view.
// If not, display an alert to notify user to select a class.
-(IBAction)proceedToAddCardsView
{
    if (readyForSegue == YES)
    {
        // Manually triggers a segue to allow us to pass data back to View Decks view
        [self performSegueWithIdentifier:@"hb_create_deck_cards" sender:self];
    } else {
        
        // ALERT : Shown when a user has not selected a Class
        readyForSegueAlert = [[UIAlertView alloc] initWithTitle:@"Unable to Proceed"
                                                       message:@"Please select a Class."
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        
        // Show alert
        [readyForSegueAlert show];
        
    }
}




// send selecteddeck data to deck view
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // SEGUE : Create Deck Cards List
    if ([[segue identifier] isEqualToString:@"hb_create_deck_cards"])
    {
        UITabBarController *createDeckCardsTabBarController = segue.destinationViewController;
        CreateDeckCardsViewController *createDeckCardsViewController = [[createDeckCardsTabBarController customizableViewControllers] objectAtIndex:0];
        
        if (createDeckCardsViewController != nil)
        {
            // Current Deck data
            createDeckCardsViewController.deckInProgress = deckInProgress;
            
            // Saved HearthStone cards list
            createDeckCardsViewController.savedCardsList = self.savedCardsList;
            
            // Saved Decks List
            createDeckCardsViewController.savedDecksList = self.savedDecksList;
        }
    }
    
    // SEGUE : View Decks
    if ([[segue identifier] isEqualToString:@"hb_view_decks"])
    {
        CreateDeckViewController *viewController = segue.destinationViewController;
        
        if (viewController != nil)
        {
            // Saved HearthStone cards list
            viewController.savedCardsList = self.savedCardsList;
            
            // Saved Decks List
            viewController.savedDecksList = self.savedDecksList;
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
