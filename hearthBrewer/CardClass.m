//
//  CardClass.m
//  hearthBrewer
//
//  Created by Daniel Campo on 8/14/14.
//  Copyright (c) 2014 Daniel Campo. All rights reserved.
//

#import "CardClass.h"

@implementation CardClass

@synthesize name, type, hero, desc, cost, health, attack, image;

// For use in "buildOfficialCardsList" – loads values pulled from JSON into final card object.
-(id)initWithCardInfo:(NSString *)cardName cardType:(NSString *)cardType cardHero:(NSString*)cardHero cardDesc:(NSString *)cardDesc cardCost:(NSInteger)cardCost cardAttack:(NSInteger)cardAttack cardHealth:(NSInteger)cardHealth cardImage:(UIImage *)cardImage
{
    if (self = [super init])
    {
        name = [cardName copy];
        type = [cardType copy];
        hero = [cardHero copy];
        desc = [cardDesc copy];
        cost = cardCost;
        attack = cardAttack;
        health = cardHealth;
        image = cardImage;
    }
    
    return self;
}


// Encode variables for use with NSCoder & NSKeyArchiver / Unarchiver
- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.name = [decoder decodeObjectForKey:@"name"];
    self.type = [decoder decodeObjectForKey:@"type"];
    self.hero = [decoder decodeObjectForKey:@"hero"];
    self.desc = [decoder decodeObjectForKey:@"desc"];
    self.cost = [decoder decodeIntegerForKey:@"cost"];
    self.attack = [decoder decodeIntegerForKey:@"attack"];
    self.health = [decoder decodeIntegerForKey:@"health"];
    self.image = [decoder decodeObjectForKey:@"image"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.type forKey:@"type"];
    [encoder encodeObject:self.type forKey:@"hero"];
    [encoder encodeObject:self.desc forKey:@"desc"];
    [encoder encodeInteger:self.cost forKey:@"cost"];
    [encoder encodeInteger:self.attack forKey:@"attack"];
    [encoder encodeInteger:self.health forKey:@"health"];
    [encoder encodeObject:self.image forKey:@"image"];
}





@end
