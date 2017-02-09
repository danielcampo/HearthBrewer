//
//  CardSingleViewController.m
//  hearthBrewer
//
//  Created by Daniel Campo on 8/14/14.
//  Copyright (c) 2014 Daniel Campo. All rights reserved.
//

#import "CardSingleViewController.h"
#import "ViewDeckViewController.h"

@interface CardSingleViewController ()

@end

@implementation CardSingleViewController

@synthesize savedCardsList, savedDecksList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



// assign properties from card object to appropriate labels
-(void)viewWillAppear:(BOOL)animated
{
    // Assign properties from card object to appropriate labels
    
    // UIMAGE : Card Image
    image.image = self.currentCard.image;
    
    // LABEL : Card Name
    name.text = self.currentCard.name;
    
    // LABEL : Card Type
    type.text = self.currentCard.type;
    
    // LABEL : Card Cost
    if (self.currentCard.cost == 0)
    {
        // set label to "-" if value is zero (typically applies to spell cards)
        cost.text = @"-";
    } else {
        cost.text = [[NSString alloc] initWithFormat:@"%d", (int)self.currentCard.cost];
    }
    
    // LABEL : Card Attack
    if (self.currentCard.attack == 0)
    {
        // set label to "-" if value is zero (typically applies to spell cards)
        attack.text = @"-";
    } else {
        attack.text = [[NSString alloc] initWithFormat:@"%d", (int)self.currentCard.attack];
    }
    
    // LABEL : Card Health
    if (self.currentCard.health == 0) {
        // set label to "-" if value is zero (typically applies to spell cards)
        health.text = @"-";
    } else {
        health.text = [[NSString alloc] initWithFormat:@"%d", (int)self.currentCard.health];
    }
    
    // LABEL : Card Description
    desc.text = self.currentCard.desc;
}


// send selecteddeck data to deck view
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // SEGUE : View Selected Deck
    ViewDeckViewController *viewDeckViewController = segue.destinationViewController;
    
    if (viewDeckViewController != nil)
    {
        // get the string from the array based on the item in the tableview we clicked on
        viewDeckViewController.currentDeck = self.currentDeck;
        viewDeckViewController.savedCardsList = self.savedCardsList;
        viewDeckViewController.savedDecksList = self.savedDecksList;
    }
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
