//
//  GameController.m
//  FinalProjectGame
//
//  Created by Daniel Piper [el16dsp] on 14/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "GameController.h"
#import "ObstacleClass.h"
#define ENCOUNTER_OFFSET 100
#define ENCOUNTER_RANGE 300
#define ENCOUNTER_TOTAL ENCOUNTER_ENEMY_CHANCE+ENCOUNTER_CHEST_CHANCE+ENCOUNTER_DOOR_CHANCE
#define ENCOUNTER_ENEMY_CHANCE 5
#define ENCOUNTER_CHEST_CHANCE 2
#define ENCOUNTER_DOOR_CHANCE 2
#define ENCOUNTER_LEVEL_RANGE 3
#define GET_CURRENT_OBSTACLE [self.ObstacleArray objectAtIndex:self.CurrentObstacle]

@implementation GameController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Coins = 0;
        self.ClicksPressed = 0;
        self.ObstacleArray = [NSMutableArray array];
        self.RoomInteger = 0;
        self.CurrentObstacle = 0;
        [self GenerateObstacleArray];
    }
    return self;
}

#pragma mark Obstacle generation

-(NSInteger)GenerateObstacleArray {
    
    NSInteger Encounters;
    NSInteger Index;
    NSInteger DesiredLevel;
    NSInteger RandomInt;
    
    // Determine number of encounters based on a random amount and the number of ticks done so far
    Encounters = 1 + ((self.ClicksPressed + 1) % (ENCOUNTER_OFFSET + (arc4random() % ENCOUNTER_RANGE)));
    DesiredLevel = 1 + (self.Coins / (2 + (arc4random() % ENCOUNTER_LEVEL_RANGE)));
    NSLog(@"%ld encounters in room of level %ld", Encounters, DesiredLevel);
    
    // Fill array with enemies
    for (Index = 0; Index < Encounters; Index++) {
        // Makes a temporary obstacle
        ObstacleClass *Temp = [[ObstacleClass alloc] init];
        ObstacleClass *Temp2 = [[ObstacleClass alloc] init];
        
        // Picks a random number between 0 and ENCOUNTER_TOTAL
        RandomInt = arc4random() % ENCOUNTER_TOTAL;
        
        // Picks whether the obstacle is a chest, door or enemy
        NSLog(@"Random roll was %ld out of %d:%d:%d", RandomInt, ENCOUNTER_CHEST_CHANCE, ENCOUNTER_DOOR_CHANCE, ENCOUNTER_ENEMY_CHANCE);
        NSLog(@"Chest possible %d", (0 <= ENCOUNTER_CHEST_CHANCE && Index != (Encounters - 1)));
        NSLog(@"Door possible %d", ((0 <= (ENCOUNTER_CHEST_CHANCE + ENCOUNTER_DOOR_CHANCE)) || (Index == Encounters - 1)));
        if (RandomInt <= ENCOUNTER_CHEST_CHANCE && Index != (Encounters - 1)) {
            NSLog(@"%@", [NSString stringWithFormat:@"Picked chest of level %ld", DesiredLevel]);
            [Temp2 GenerateChest:DesiredLevel];
            [self.ObstacleArray addObject:Temp2];
            [Temp GenerateChestDead:DesiredLevel];
        } else if ((RandomInt <= (ENCOUNTER_CHEST_CHANCE + ENCOUNTER_DOOR_CHANCE)) || Index == Encounters - 1) {
            NSLog(@"%@", [NSString stringWithFormat:@"Picked door of level %ld", DesiredLevel]);
            [Temp2 GenerateDoor:DesiredLevel];
            [self.ObstacleArray addObject:Temp2];
            [Temp GenerateDoorDead:DesiredLevel];
        } else {
            NSLog(@"%@", [NSString stringWithFormat:@"Picked enemy of level %ld", DesiredLevel]);
            [Temp GenerateEnemy:DesiredLevel];
        }
        // Add obstacle to ObstacleArray
        [self.ObstacleArray addObject:Temp];
        
    } // And repeat...
    
    return Encounters;
}

#pragma mark OnTick methods

-(NSMutableArray *)OnAnyTick {
    NSLog(@"OnAnyTick called from GameController");
    // Auto load obstacle ability amount
    NSString *HealthLabel = [NSString stringWithFormat:@"%ld/%ld", self.Player.CurrentHealth, self.Player.MaxHealth]; // Get current health ratio for the player
    NSString *Button1Label = [self.Player.Button1 GetRatio];
    NSString *Button2Label = [self.Player.Button2 GetRatio];
    NSString *CoinsLabel = [NSString stringWithFormat:@"Coins: %03ld", self.Coins];
    NSString *ObstacleImageTitle = @"placeholder.png";
    NSString *PlayerImageTitle = @"placeholder.png";
    NSString *ObstacleWeaponStatus;
    
    NSMutableArray *ReturnValues = [NSMutableArray arrayWithCapacity:6];
    
    ObstacleClass *Temp = GET_CURRENT_OBSTACLE;
    
    NSLog(@"/// TURN %ld BEGIN \\\\\\", self.ClicksPressed + 1);
    
    NSLog(@"Currently facing obstacle %ld %@ of %ld with health of %ld", self.CurrentObstacle+1, Temp.Name, [self.ObstacleArray count], [GET_CURRENT_OBSTACLE ReturnHealth]);
    ObstacleImageTitle = [NSString stringWithFormat:@"%@.png",Temp.ImageBasis];
    
    // Call onbstacle weapon AutoIncrement
    NSLog(@"Obstacle Ability...");
    ObstacleWeaponStatus = [Temp.Ability AutoIncrement];
    // Added these 2 lines to confirm that the stuff done to temp is also done to the stored obstacle
    NSLog(@"Temp storage click amount %ld", [Temp GetClickAmount]);
    NSLog(@"Actual storage click amount %ld", [GET_CURRENT_OBSTACLE GetClickAmount]);
    
    // Call weapon 1 AutoIncrement
    NSLog(@"Player weapon 1...");
    Button1Label = [self.Player.Button1 AutoIncrement];
    NSLog(@"Button 1 label is %@", Button1Label);
    
    // Call weapon 2 AutoIncrement
    NSLog(@"Player weapon 2...");
    Button2Label = [self.Player.Button2 AutoIncrement];
    NSLog(@"Button 2 label is %@", Button2Label);
    
    NSLog(@"Obstacle attack processing...");
    // If the obstacle is still stunned, it can't do anything
    
    if ([Temp IsStunned] == NO) { // IF Obstacle is not stunned
        NSLog(@"Obstacle not stunned");
        
        // This is literally just a copy of the CalcRatio from ViewController
        NSInteger Denominator = [[[ObstacleWeaponStatus componentsSeparatedByString:@"/"] objectAtIndex:1] intValue];
        NSInteger Numerator = [[[ObstacleWeaponStatus componentsSeparatedByString:@"/"] objectAtIndex:0] intValue];
        
        NSLog(@"Old Obstacle Weapon Status: %@", ObstacleWeaponStatus);
        if (Denominator == 0) { // Added to deal with 'Not a Number' errors
            Denominator = 1;
        }
        if (Numerator == 0) {
            Numerator = 1;
        }
        NSLog(@"New Obstacle Weapon Status: %ld/%ld", Numerator, Denominator);
        float Ratio = (float)Numerator/Denominator;
        if (Ratio == 1.0) {
            // IF obstacle amount amount is full, fire
            NSLog(@"Obstacle Attacking");
            
            // Ask if obstacle will damage player
            NSMutableArray *DamageArrayFromObstacle = [Temp.Ability DamageDealtOnClick];
            NSInteger DamageFromObstacle = [[DamageArrayFromObstacle objectAtIndex:0] integerValue];
            // Since there are no mechanics for the player to be stunned, no obstacle can stun a player
            // Therefore, only the first element of the array is cared about
            NSLog(@"Obstacle damage to player is %ld", DamageFromObstacle);
            
            // Apply damage to the player
            float DamageToPlayer = [self.Player CalculateDamage:DamageFromObstacle];
            HealthLabel = [self.Player DoDamage:DamageToPlayer];
        }
    }
    
    if ([[GET_CURRENT_OBSTACLE GetName] isEqualToString:@"Enemy"]) {
        // Need to get the image for the current, still living obstacle's next state
        // ie. Show what the obstacle will do in the coming turn
        // This is only for enemies
        if ([GET_CURRENT_OBSTACLE IsStunned]) { // IF Obstacle was stunned last turn, set image to stunned_alt
            // This can't be done as the selected images were changed from being last turn's action to the next turn's action
            // Ergo, if the obstacle was stunned this turn, set image to stunned alt
            ObstacleImageTitle = @"enemy_alt_stunned";
            
        } else if ([GET_CURRENT_OBSTACLE GetClickAmount] == ([GET_CURRENT_OBSTACLE GetMaxClicks] - (2 * [GET_CURRENT_OBSTACLE GetAutoClicks]))) { // IF ClickAmount is 2 AutoClicks away from MaxClick, get pre attack image
            ObstacleImageTitle = @"enemy_pre_attack";
            
        } else if ([GET_CURRENT_OBSTACLE GetClickAmount] == ([GET_CURRENT_OBSTACLE GetMaxClicks] - [GET_CURRENT_OBSTACLE GetAutoClicks])) { // IF ClickAmount is 1 AutoClick away from MaxClick, get attack image
            ObstacleImageTitle = @"enemy_attack";
            
        } else {
            // Get idle image
            ObstacleImageTitle = @"enemy_idle";
            
        }
        /*
         else if () { //IF StunToObstacle is > 0 ie. Object is stunned in the action, set image to stunned
         // This should be higher up in priority
         // This can't be done as the selected images were changed from being last turn's action to the next turn's action
         // Ergo, if the obstacle will be stunned next turn, set image to stunned
         // This involves predicting what a person will do. This is out of scope for this project
         // Therefore abandon this aspect
         }
         */
    }
    
    // Update images and labels
    NSLog(@"HealthLabel %@ Button1Label %@", HealthLabel, Button1Label);
    NSLog(@"Button2Label %@ CoinsLabel %@", Button2Label, CoinsLabel);
    NSLog(@"PlayerImage %@ ObstacleImage %@", PlayerImageTitle, ObstacleImageTitle);
    
    [ReturnValues addObject:HealthLabel];       // Index 0
    [ReturnValues addObject:Button1Label];      // Index 1
    [ReturnValues addObject:Button2Label];      // Index 2
    [ReturnValues addObject:CoinsLabel];        // Index 3
    [ReturnValues addObject:PlayerImageTitle];  // Index 4
    [ReturnValues addObject:ObstacleImageTitle];// Index 5
    return ReturnValues;
}

-(NSMutableArray *)OnObstacleClick {
    NSLog(@"ObstacleClicked from GameController");
    
    NSString *Button1Label;
    NSString *Button2Label;
    
    NSInteger DamageToObstacle;
    NSInteger StunToObstacle;
    
    NSMutableArray *ReturnValues = [NSMutableArray arrayWithCapacity:6];
    NSMutableArray *Damage1 = [NSMutableArray arrayWithCapacity:2];
    NSMutableArray *Damage2 = [NSMutableArray arrayWithCapacity:2];
    
    ObstacleClass *Temp = GET_CURRENT_OBSTACLE;
    
    ReturnValues = [self OnAnyTick];
    
    // Call weapon 1 DamageDealtOnClick
    NSLog(@"Player weapon 1 attack processing...");
    Damage1 = [self.Player.Button1 DamageDealtOnClick];
    // Since the values returned from DamageDealtOnClick are NSNumbers, they need to be converted to NSIntegers. I don't know why they don't work as integers but, hey, this is objective-c
    NSLog(@"Damage to be done is %ld. Stun amount to be done is %ld", [[Damage1 objectAtIndex:0] integerValue], [[Damage1 objectAtIndex:1] integerValue]);
    Button1Label = [Damage1 objectAtIndex:2];
    [ReturnValues replaceObjectAtIndex:1 withObject:Button1Label];
    
    // Call weapon 2 DamageDealtOnClick
    NSLog(@"Player weapon 2 attack processing...");
    Damage2 = [self.Player.Button2 DamageDealtOnClick];
    NSLog(@"Damage to be done is %ld. Stun amount to be done is %ld", [[Damage2 objectAtIndex:0] integerValue], [[Damage2 objectAtIndex:1] integerValue]);
    Button2Label = [Damage2 objectAtIndex:2];
    [ReturnValues replaceObjectAtIndex:2 withObject:Button2Label];
    
    // Do damage to obstacle here
    NSLog(@"Damage to obstacle processing...");
    // Add damage from both weapons together
    DamageToObstacle = [[Damage1 objectAtIndex:0] integerValue] + [[Damage2 objectAtIndex:0] integerValue];
    // Pick the larger of the two stun amounts
    StunToObstacle = ([[Damage1 objectAtIndex:1] integerValue] > [[Damage2 objectAtIndex:1] integerValue]) ? [[Damage1 objectAtIndex:1] integerValue] : [[Damage2 objectAtIndex:1] integerValue]; // A fancy IF statement in a single line to determine which one to pick
    NSLog(@"Total damage to be done is %ld. Stun effect to be done is %ld", DamageToObstacle, StunToObstacle);
    
    NSString *ObstacleHealthLabel = [Temp TakeDamage:DamageToObstacle :StunToObstacle];
    NSLog(@"Obstacle health is %@", ObstacleHealthLabel);
    NSInteger Numerator = [[[ObstacleHealthLabel componentsSeparatedByString:@"/"] objectAtIndex:0] intValue];
    if (Numerator == 0) {
        // Obstacle is dead
        NSLog(@"Obstacle %ld of %ld overcome", self.CurrentObstacle, [self.ObstacleArray count]);
        self.CurrentObstacle += 1;
        if (self.CurrentObstacle >= [self.ObstacleArray count]) {
            NSLog(@"Obstacles for room overcome. Generating next room");
            [self GenerateObstacleArray];
            self.CurrentObstacle = 0;
        }
        NSLog(@"Old coins amount %ld", self.Coins);
        self.Coins += Temp.Reward;
        NSLog(@"New coins amoung %ld", self.Coins);
        [ReturnValues replaceObjectAtIndex:5 withObject:[GET_CURRENT_OBSTACLE GetImageName]];
    }
    
    // For the graphics, show what the player has done in the last turn
    if (([[Damage1 objectAtIndex:0] integerValue] > 0 || [[Damage1 objectAtIndex:1] integerValue]) && ([[Damage2 objectAtIndex:0] integerValue] > 0 || [[Damage2 objectAtIndex:1] integerValue])) { // IF the player fired both button 1 and button 2
        // Handles case of some weapons not doing damage but stunning instead
        [ReturnValues replaceObjectAtIndex:4 withObject:@"cutter_fire_12"];
            
    } else if ([[Damage1 objectAtIndex:0] integerValue] > 0 || [[Damage1 objectAtIndex:1] integerValue]) { // IF the player fired button 1
        [ReturnValues replaceObjectAtIndex:4 withObject:@"cutter_fire_1"];
            
    } else if ([[Damage2 objectAtIndex:0] integerValue] > 0 || [[Damage2 objectAtIndex:1] integerValue]) { // IF the player fired button 2
        [ReturnValues replaceObjectAtIndex:4 withObject:@"cutter_fire_2"];
            
    } else { // Pick idle
        [ReturnValues replaceObjectAtIndex:4 withObject:@"cutter_idle"];
    } // Loading an individual weapon is done in the appropriate button press
    
    NSLog(@"HealthLabel %@ Button1Label %@", [ReturnValues objectAtIndex:0], [ReturnValues objectAtIndex:1]);
    NSLog(@"Button2Label %@ CoinsLabel %@", [ReturnValues objectAtIndex:2], [ReturnValues objectAtIndex:3]);
    NSLog(@"PlayerImage %@ ObstacleImage %@", [ReturnValues objectAtIndex:4], [ReturnValues objectAtIndex:5]);
    [self OnEndTurn];
    return ReturnValues;
}

-(NSMutableArray *)OnButton1Click {
    NSLog(@"Button 1 clicked from GameController");
    
    NSMutableArray *ReturnValues = [NSMutableArray arrayWithCapacity:6];
    
    ReturnValues = [self OnAnyTick];
    // Call weapon 1 manual increment method
    [ReturnValues replaceObjectAtIndex:1 withObject:[self.Player.Button1 ManualIncrement]];
    [ReturnValues replaceObjectAtIndex:4 withObject:@"cutter_load_1"];
    NSLog(@"HealthLabel %@ Button1Label %@", [ReturnValues objectAtIndex:0], [ReturnValues objectAtIndex:1]);
    NSLog(@"Button2Label %@ CoinsLabel %@", [ReturnValues objectAtIndex:2], [ReturnValues objectAtIndex:3]);
    NSLog(@"PlayerImage %@ ObstacleImage %@", [ReturnValues objectAtIndex:4], [ReturnValues objectAtIndex:5]);
    [self OnEndTurn];
    return ReturnValues;
}

-(NSMutableArray *)OnButton2Click {
    NSLog(@"Button 2 clicked from GameController");
    
    NSMutableArray *ReturnValues = [NSMutableArray arrayWithCapacity:6];
    
    ReturnValues = [self OnAnyTick];
    // Call weapon 2 manual increment method
    [ReturnValues replaceObjectAtIndex:2 withObject:[self.Player.Button2 ManualIncrement]];
    [ReturnValues replaceObjectAtIndex:4 withObject:@"cutter_load_2"];
    NSLog(@"HealthLabel %@ Button1Label %@", [ReturnValues objectAtIndex:0], [ReturnValues objectAtIndex:1]);
    NSLog(@"Button2Label %@ CoinsLabel %@", [ReturnValues objectAtIndex:2], [ReturnValues objectAtIndex:3]);
    NSLog(@"PlayerImage %@ ObstacleImage %@", [ReturnValues objectAtIndex:4], [ReturnValues objectAtIndex:5]);
    [self OnEndTurn];
    return ReturnValues;
}

-(void)OnEndTurn {
    NSLog(@"/// TURN %ld END \\\\\\", self.ClicksPressed + 1);
    
    self.ClicksPressed += 1;
    //Resolve player damage here
    if (self.Player.CurrentHealth <= 0) {
        NSLog(@"Player is dead");
        // ViewController must open the shop and disable the combat buttons
    }
}

#pragma mark Getters

-(NSString *)GetObstacleName {
    ObstacleClass *Temp = GET_CURRENT_OBSTACLE;
    NSString *Name = Temp.Name;
    NSLog(@"Returning obstacle name %@", Name);
    return Name;
}

-(NSString *)GetPlayerName {
    NSString *Name = self.Player.Name;
    NSLog(@"Returning player name %@", Name);
    return Name;
}

-(NSString *)GetWeapon1Name {
    NSString *Name = self.Player.Button1.Name;
    NSLog(@"Returning weapon 1 name %@", Name);
    return Name;
}


-(NSString *)GetWeapon1Type {
    NSString *Name = self.Player.Button1.Type;
    NSLog(@"Returning weapon 1 type %@", Name);
    return Name;
}

-(NSString *)GetWeapon2Name {
    NSString *Name = self.Player.Button2.Name;
    NSLog(@"Returning weapon 2 name %@", Name);
    return Name;
}


-(NSString *)GetWeapon2Type {
    NSString *Name = self.Player.Button2.Type;
    NSLog(@"Returning weapon 2 type %@", Name);
    return Name;
}

@end
