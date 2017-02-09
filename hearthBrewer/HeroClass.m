//
//  HeroClass.m
//  hearthBrewer
//
//  Created by Daniel Campo on 8/14/14.
//  Copyright (c) 2014 Daniel Campo. All rights reserved.
//

#import "HeroClass.h"

@implementation HeroClass

@synthesize heroList = _heroList, classList = _classList;

-(NSArray *)heroList
{
    // List of all Hero Classes in the game
    HeroClass *heroDruid = [[HeroClass alloc] init];
    HeroClass *heroHunter = [[HeroClass alloc] init];
    HeroClass *heroMage = [[HeroClass alloc] init];
    HeroClass *heroPaladin = [[HeroClass alloc] init];
    HeroClass *heroPriest = [[HeroClass alloc] init];
    HeroClass *heroRogue = [[HeroClass alloc] init];
    HeroClass *heroWarrior = [[HeroClass alloc] init];
    HeroClass *heroWarlock = [[HeroClass alloc] init];
    
    // Load default values for each Hero Class
    heroDruid.heroName = @"Malfurion"; heroDruid.heroClass = @"Druid"; heroDruid.heroPower = @"Power"; heroDruid.heroImage = @"hero_malfurion.png"; heroDruid.heroImageThumb = @"hero_malfurion_thumb.png";
    heroHunter.heroName = @"Rexxar"; heroHunter.heroClass = @"Hunter"; heroHunter.heroPower = @"Power"; heroHunter.heroImage = @"hero_rexxar.png"; heroHunter.heroImageThumb = @"hero_rexxar_thumb.png";
    heroMage.heroName = @"Jaina"; heroMage.heroClass = @"Mage"; heroMage.heroPower = @"Power"; heroMage.heroImage = @"hero_jaina.png"; heroMage.heroImageThumb = @"hero_jaina_thumb.png";
    heroPaladin.heroName = @"Uther"; heroPaladin.heroClass = @"Paladin"; heroPaladin.heroPower = @"Power"; heroPaladin.heroImage = @"hero_uther.png"; heroPaladin.heroImageThumb = @"hero_uther_thumb.png";
    heroPriest.heroName = @"Anduin"; heroPriest.heroClass = @"Priest"; heroPriest.heroPower = @"Power"; heroPriest.heroImage = @"hero_anduin.png"; heroPriest.heroImageThumb = @"hero_anduin_thumb.png";
    heroRogue.heroName = @"Valeera"; heroRogue.heroClass = @"Rogue"; heroRogue.heroPower = @"Power"; heroRogue.heroImage = @"hero_valeera.png"; heroRogue.heroImageThumb = @"hero_valeera_thumb.png";
    heroWarrior.heroName = @"Garrosh"; heroWarrior.heroClass = @"Warrior"; heroWarrior.heroPower = @"Power"; heroWarrior.heroImage = @"hero_garrosh.png"; heroWarrior.heroImageThumb = @"hero_garrosh_thumb.png";
    heroWarlock.heroName = @"Guldan"; heroWarlock.heroClass = @"Warlock"; heroWarlock.heroPower = @"Power"; heroWarlock.heroImage = @"hero_guldan.png"; heroWarlock.heroImageThumb = @"hero_guldan_thumb.png";
    
    // Compile Hero List into single array
    NSArray *list = [[NSArray alloc] initWithObjects:
                heroDruid,
                heroHunter,
                heroMage,
                heroPaladin,
                heroPriest,
                heroRogue,
                heroWarrior,
                heroWarlock,
                nil
                ];
    
    _heroList = list;
    
    return _heroList;
    
}

-(NSArray *)classList
{
    NSArray *list = [[NSArray alloc] initWithObjects:@"heroDruid",@"heroHunter",@"heroMage",@"heroPaladin",@"heroPriest", @"heroRogue", @"heroWarrior", @"heroWarlock",nil];
    
    _classList = list;
    
    return _classList;
}


@end
