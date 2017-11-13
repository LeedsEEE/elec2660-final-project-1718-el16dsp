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
        
    }
    return self;
}

-(NSInteger) DamageDealtOnClick {
    // Called on any button press:
        // Called on obstacle button press if weapon. Ability won't do anything unless charged
        // Called on both ability button presses
        // Any weapon buttons need a catchout to stop this from activating if manual increment occurs
    if ([self.Type isEqualToString:@"W"]) {
        if (self.ClickAmount>0) {
            self.ClickAmount -= 1;
            return (self.DamagePerClick, self.StunDuration);
        }
    } else if ([self.Type isEqualToString:@"A"]) {
        if (self.ClickAmount == self.ClicksPerClip) {
            self.ClickAmount = 0;
            return (self.DamagePerClick, self.StunDuration);
        }
    }
    return (0, 0);
}

-(void) UpdateStats {
    // Called only once upgrade purchased
    NSInteger level;
    
    level = self.Level;
    
    // Needs to be updated and overridden for each player class ability
    self.DamagePerClick = 1;
    self.ClicksPerClip = 1;
    self.StunDuration = 1;
    self.AutoClickLoadRate = 1;
    self.ClickAmount = self.ClicksPerClip;
}

-(void) AutoIncrement {
    // Called on any button press in the game
    self.ClickAmount += self.AutoClickLoadRate;
}

-(void) ManualIncrement {
    // Called on the corresponding weapon or ability button press
    self.ClickAmount += 1;
}

@end
