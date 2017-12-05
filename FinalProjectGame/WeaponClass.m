//
//  WeaponClass.m
//  FinalProjectGame
//
//  Created by Daniel Piper [el16dsp] on 13/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "WeaponClass.h"

@implementation WeaponClass

- (instancetype)init
{
    self = [super init];
    if (self) {
        // Puts in placeholder values
        
        NSLog(@"WeaponClass init called");
        
        self.Type = @"W";
        
        self.Name = @"Placeholder";
        self.ImageName = @"placeholder.png";
        self.Description = @"This should be updated";
        
        self.Level = 0;
        self.LevelsPerUpgrade = 0.0;
        self.DamagePerClick = 0;
        self.ClicksPerClip = 0;
        self.StunDuration = 0;
        self.AutoClickLoadRate = 0;
        // Weapon is invalid and cannot be used properly if (self.DamagePerClick + self.StunDuration == 0)
    }
    return self;
}

-(NSMutableArray *) DamageDealtOnClick {
    // Called on any button press:
        // Called on obstacle button press if weapon. Ability won't do anything unless charged
        // Called on both ability button presses
        // Any weapon buttons need a catchout to stop this from activating if manual increment occurs
    NSMutableArray *ReturnValues = [NSMutableArray arrayWithCapacity:3];
    NSInteger Zero = 0;
    [ReturnValues addObject:[NSNumber numberWithInteger:Zero]];
    [ReturnValues addObject:[NSNumber numberWithInteger:Zero]];
    [ReturnValues addObject:[NSString stringWithFormat:@"%ld/%ld", self.ClickAmount, self.ClicksPerClip]];
    if ([self.Type isEqualToString:@"W"] && self.ClickAmount>0) {
        NSLog(@"Firing weapon for damage %ld and stun %ld", self.DamagePerClick, self.StunDuration);
        self.ClickAmount -= 1;
        [ReturnValues replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:self.DamagePerClick]];
        [ReturnValues replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:self.StunDuration]];
        [ReturnValues replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%ld/%ld", self.ClickAmount, self.ClicksPerClip]];
    } else if ([self.Type isEqualToString:@"A"] && self.ClickAmount == self.ClicksPerClip)
    {
        NSLog(@"Firing ability for damage %ld and stun %ld", self.DamagePerClick, self.StunDuration);
        self.ClickAmount = 0;
        [ReturnValues replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:self.DamagePerClick]];
        [ReturnValues replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:self.StunDuration]];
        [ReturnValues replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%ld/%ld", self.ClickAmount, self.ClicksPerClip]];
    }
    return ReturnValues;
}

-(void) UpdateStats {
    // Called only once upgrade purchased
    NSInteger level;
    
    level = self.Level;
    
    // Needs to be updated and overridden for each player class ability
    self.LevelsPerUpgrade = 0.0;
    self.DamagePerClick = 1;
    self.ClicksPerClip = 1;
    self.StunDuration = 1;
    self.AutoClickLoadRate = 1;
    self.ClickAmount = self.ClicksPerClip;
}

-(NSString *) AutoIncrement {
    // Called on any button press in the game
    NSString *Label;
    NSLog(@"AutoIncrement Called");
    NSLog(@"Old ClickAmount = %ld", self.ClickAmount);
    if (self.ClickAmount < self.ClicksPerClip) {
        self.ClickAmount = self.AutoClickLoadRate + self.ClickAmount;
        NSLog(@"New ClickAmount = %ld", self.ClickAmount);
    } else {
        self.ClickAmount = self.ClicksPerClip;
        NSLog(@"Max clip reached");
    }
    Label = [NSString stringWithFormat:@"%ld/%ld", self.ClickAmount, self.ClicksPerClip];
    NSLog(@"Auto label is %@", Label);
    return Label;
}

-(NSString *) ManualIncrement {
    // Called on the corresponding weapon or ability button press
    NSString *Label = @"00/00";
    NSLog(@"ManualIncrement Called");
    NSLog(@"Old ClickAmount = %ld", self.ClickAmount);
    if (self.ClickAmount < self.ClicksPerClip) {
        self.ClickAmount = self.ClickAmount + 1;
        NSLog(@"New ClickAmount = %ld", self.ClickAmount);
    } else {
        NSLog(@"Max clip reached");
    }
    Label = [NSString stringWithFormat:@"%ld/%ld", self.ClickAmount, self.ClicksPerClip];
    NSLog(@"Manual label is %@", Label);
    return Label;
}

-(NSString *) GetRatio {
    // Returns the ratio between click amount and max click
    NSString *Ratio;
    NSInteger Numerator = self.ClickAmount;
    NSInteger Denominator = self.ClicksPerClip;
    Ratio = [NSString stringWithFormat:@"%ld/%ld", Numerator, Denominator];
    return Ratio;
}

@end

#pragma mark Class 0 - Cutter - Weapon 1 - Pistol

@implementation class_0_1

-(void) UpdateStats {
    // Class 0 is Cutter
    // Slot 1 is the pistol
    NSInteger level;
    
    level = self.Level;
    
    // Needs to be updated and overridden for each player class ability
    self.LevelsPerUpgrade = 1.2;
    self.DamagePerClick = 1*level;
    self.ClicksPerClip = 10;
    self.StunDuration = 0;
    self.AutoClickLoadRate = 0+(level/5);
    self.ClickAmount = self.ClicksPerClip;
}

@end

#pragma mark Class 0 - Cutter - Ability 2 - Grenade

@implementation class_0_2

-(void) UpdateStats {
    // Class 0 is Cutter
    // Slot 2 is the blowtorch
    NSInteger level;
    
    level = self.Level;
    
    // Needs to be updated and overridden for each player class ability
    self.LevelsPerUpgrade = 2.0;
    self.DamagePerClick = 2 + level;
    self.ClicksPerClip = 10;
    self.StunDuration = 4 + level;
    self.AutoClickLoadRate = 0;
    self.ClickAmount = self.ClicksPerClip;
}

@end

#pragma mark Class 1 - Master Gunner - Ability 1 - Stun rig

@implementation class_1_1

-(void) UpdateStats {
    // Class 1 is Master Gunner
    // Slot 1 is the stun rig
    // Short ability that only stuns the obstacle
    NSInteger level;
    
    level = self.Level;
    
    // Needs to be updated and overridden for each player class ability
    self.LevelsPerUpgrade = 1.1;
    self.DamagePerClick = 0;
    self.ClicksPerClip = 5;
    self.StunDuration = level + 1;
    self.AutoClickLoadRate = 0 + (level % 10);
    self.ClickAmount = self.ClicksPerClip;
}

@end

#pragma mark Class 2 - Master Gunner - Ability 2 - Heavy Rifle

@implementation class_1_2

-(void) UpdateStats {
    // Class 1 is Master Gunner
    // Slot 1 is the heavy rifle
    // Short ability that does high damage
    NSInteger level;
    
    level = self.Level;
    
    // Needs to be updated and overridden for each player class ability
    self.LevelsPerUpgrade = 3.2;
    self.DamagePerClick = 3 * (1 + level);
    self.ClicksPerClip = 9;
    self.StunDuration = 0;
    self.AutoClickLoadRate = 0 + (level % 5);
    self.ClickAmount = self.ClicksPerClip;
}

@end

