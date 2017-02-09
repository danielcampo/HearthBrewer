//
//  CreateDeckViewController.h
//  hearthBrewer
//
//  Created by Daniel Campo on 8/14/14.
//  Copyright (c) 2014 Daniel Campo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeckClass.h"

@interface CreateDeckViewController : UIViewController
{
    // Name of hero portrait artwork
    NSString *heroPortraitImageString;
    
    // The image that switches to a selected a class
    IBOutlet UIImageView *selectedClassImage;
    
    // Used to determine if a user has selected a class or not
    // If yes, proceed with segue. If no, do not proceed
    BOOL readyForSegue;
    UIAlertView *readyForSegueAlert;
}

@property (nonatomic,strong) NSMutableArray *savedCardsList, *savedDecksList;

// Current deck in progress
@property (strong,nonatomic) DeckClass *deckInProgress;

// Action to swtich the portraight image at the top of the view
-(IBAction)selectClass:(id)sender;

// Triggers segue ONLY if a Class has been selected
-(IBAction)proceedToAddCardsView;

@end
