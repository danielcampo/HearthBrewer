//
//  CardClass.h
//  hearthBrewer
//
//  Created by Daniel Campo on 8/14/14.
//  Copyright (c) 2014 Daniel Campo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CardClass : NSObject <NSCoding>

// card artwork
@property (nonatomic,strong) UIImage *image;

// card name, class type & description
@property (nonatomic,strong) NSString *name, *type, *hero, *desc;

// card cost, attack & health values
@property (nonatomic,assign) NSInteger cost, attack, health;

// Used to build a Card object to be added to Cards List array
-(id)initWithCardInfo:(NSString*)cardName cardType:(NSString*)cardType cardHero:(NSString*)cardHero cardDesc:(NSString*)cardDesc cardCost:(NSInteger)cardCost cardAttack:(NSInteger)cardAttack cardHealth:(NSInteger)cardHealth cardImage:(UIImage*)cardImage;

@end
