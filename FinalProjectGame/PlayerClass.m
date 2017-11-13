//
//  PlayerClass.m
//  FinalProjectGame
//
//  Created by Daniel Piper [el16dsp] on 13/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "PlayerClass.h"

@implementation PlayerClass

- (instancetype)init
{
    self = [super init];
    if (self) {
        // Put placeholder's here
        self.Name = @"PlaceholderClass";
        self.ImageBasis = @"class_placeholder";
        self.MaxHealth = 0;
        self.CurrentHealth = 0;
        self.Armour = 0;
        self.Button1 = [[WeaponClass alloc] init];
        self.Button2 = [[WeaponClass alloc] init];
    }
    return self;
}

-(NSInteger) ReturnHealth {
    if (self.CurrentHealth < 0) {
        self.CurrentHealth = 0;
    }
    return self.CurrentHealth;
}

-(float) CalculateDamage:(NSInteger)RawDamageIn {
    float damage_taken;
    float numerator = 100*RawDamageIn;
    float denominator = 100+self.Armour;
    damage_taken = numerator/denominator;
    return damage_taken;
}

@end
