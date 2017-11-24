//
//  ObstacleClass.h
//  FinalProjectGame
//
//  Created by Daniel Piper [el16dsp] on 13/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeaponClass.h"

@interface ObstacleClass : NSObject

@property (strong, nonatomic) NSString *Name;
@property (strong, nonatomic) NSString *ImageBasis;

@property (nonatomic) NSInteger Level;
@property (nonatomic) NSInteger MaxHealth;
@property (nonatomic) NSInteger CurrentHealth;
@property (nonatomic) NSInteger Armour;
@property (nonatomic) NSInteger Reward;
@property (strong, nonatomic) WeaponClass *Ability;
@property (nonatomic) NSInteger StunnedFor;

-(void) GenerateChest:(NSInteger) DesiredLevel;
-(void) GenerateChestDead:(NSInteger)DesiredLevel;
-(void) GenerateDoor:(NSInteger) DesiredLevel;
-(void) GenerateDoorDead:(NSInteger)DesiredLevel;
-(void) GenerateEnemy:(NSInteger) DesiredLevel;
-(NSInteger) ReturnHealth;
-(NSInteger) GetClickAmount;
-(BOOL) IsStunned;
-(NSString *) TakeDamage:(NSInteger) DamageAmount
                        :(NSInteger) StunAmount;

@end
