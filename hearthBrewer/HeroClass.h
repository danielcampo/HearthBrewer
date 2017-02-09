//
//  HeroClass.h
//  hearthBrewer
//
//  Created by Daniel Campo on 8/14/14.
//  Copyright (c) 2014 Daniel Campo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeroClass : NSObject

// Basic properties of a Hero
@property (nonatomic, strong) NSString *heroName, *heroClass, *heroPower, *heroImage, *heroImageThumb;

// These lists are hard-coded and are not to be modified, only referenced in other classes
@property (readonly) NSArray *heroList, *classList;

-(NSArray *)heroList;

@end
