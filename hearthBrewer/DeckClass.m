//
//  DeckClass.m
//  hearthBrewer
//
//  Created by Daniel Campo on 8/14/14.
//  Copyright (c) 2014 Daniel Campo. All rights reserved.
//

#import "DeckClass.h"

@implementation DeckClass

@synthesize deckName, deckClass, deckCards;


// Encode variables for use with NSCoder & NSKeyArchiver / Unarchiver
- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.deckName = [decoder decodeObjectForKey:@"deckName"];
    self.deckClass = [decoder decodeObjectForKey:@"deckClass"];
    self.deckCards = [decoder decodeObjectForKey:@"deckCards"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.deckName forKey:@"deckName"];
    [encoder encodeObject:self.deckClass forKey:@"deckClass"];
    [encoder encodeObject:self.deckCards forKey:@"deckCards"];
}

@end
