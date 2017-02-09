//
//  DeckClass.h
//  hearthBrewer
//
//  Created by Daniel Campo on 8/14/14.
//  Copyright (c) 2014 Daniel Campo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeckClass : NSObject <NSCoding>

// card name, class type & description
@property (nonatomic,strong) NSString *deckName, *deckClass;

// Array containing all of the cards in a given deck
@property (nonatomic,strong) NSMutableArray *deckCards;

@end
