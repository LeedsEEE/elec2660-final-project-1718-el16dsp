//
//  WeaponClass.h
//  FinalProjectGame
//
//  Created by Daniel Piper [el16dsp] on 13/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeaponClass : NSObject

// Type is used to determine how it operates in gameplay
@property (strong, nonatomic) NSString *Type; // Will be either @"A" or @"W"
// 'W' or weapon types will consume one 'click' per use and will do one set of damage. They need to be topped up by pressing on it's button
// 'A' or ability types will need to be charged up by pressing the button a few times then do an effect on the obstacle

// Non-necessary stuff in the sense that these don't affect gameplay but will be used in the inspection view
@property (strong, nonatomic) NSString *Name;
@property (strong, nonatomic) NSString *ImageName;
@property (strong, nonatomic) NSString *Description;

// These values will directly affect gameplay and will be tailored to each player class
@property (nonatomic) NSInteger Level; // The following values scale up with this. This can be increased by paying a number of coins
@property (nonatomic) float LevelsPerUpgrade; // Is used for determining the cost of the upgrade
@property (nonatomic) NSInteger DamagePerClick; // How much damage is done per use
@property (nonatomic) NSInteger ClicksPerClip; // How many clicks can this store
@property (nonatomic) NSInteger ClickAmount; // A value that, in gameplay, will vary between 0 and ClicksPerClip
@property (nonatomic) NSInteger StunDuration; // Affects the obstacle only and stops it from attacking
@property (nonatomic) NSInteger AutoClickLoadRate; // On any click, this will add it's value to ClickAmount

-(NSMutableArray *) DamageDealtOnClick;
-(void) UpdateStats;
-(NSString *) AutoIncrement;
-(NSString *) ManualIncrement;
-(NSString *) GetRatio;

@end

#pragma mark class_0_1

@interface class_0_1 : WeaponClass

-(void) UpdateStats;

@end

#pragma mark class_0_2

@interface class_0_2 : WeaponClass

-(void) UpdateStats;

@end

#pragma mark class_1_1

@interface class_1_1 : WeaponClass

-(void) UpdateStats;

@end

#pragma mark class_1_2

@interface class_1_2 : WeaponClass

-(void) UpdateStats;

@end
