//
//  PlayerClass.h
//  FinalProjectGame
//
//  Created by Daniel Piper [el16dsp] on 13/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeaponClass.h"

@interface PlayerClass : NSObject

// The non-game-changing stuff
@property (strong, nonatomic) NSString *Name; // Is the name of the class that the user would know eg. Captain and Boatswain (because pirate theme)
@property (strong, nonatomic) NSString *ImageBasis; // Is the basis of the image names that this will use. Suffixes will be added to this to find the right image

// Game affecting stuff
@property (nonatomic) NSInteger MaxHealth; // Sets upper limit for what health can be
@property (nonatomic) NSInteger CurrentHealth; // Will change during gameplay and ranges from MaxHealth to any value less than 0
@property (nonatomic) NSInteger Armour; // Is a value that reduces damage taken
@property (strong, nonatomic) WeaponClass *Button1; // Needs to be set in the data model
@property (strong, nonatomic) WeaponClass *Button2; // Needs to be set in the data model

-(NSInteger) ReturnHealth; // Just returns the value of the player's health
-(float) CalculateDamage: (NSInteger) RawDamageIn; // Takes in the damage from the obstacle's damage per click and processes it. Returns a floating value of damage taken
-(NSString *) DoDamage:(float)DamageIn; // Returns string of form @"16/20"

@end
