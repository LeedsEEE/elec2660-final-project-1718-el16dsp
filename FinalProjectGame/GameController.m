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
    NSLog(@"%@", [NSString stringWithFormat:@"%ld encounters in room of level %ld", Encounters, DesiredLevel]);
    
    // Fill array with enemies
    for (Index = 0; Index < Encounters; Index++) {
        // Makes a temporary obstacle
        ObstacleClass *Temp = [[ObstacleClass alloc] init];
        
        // Picks a random number between 0 and ENCOUNTER_TOTAL
        RandomInt = arc4random() % ENCOUNTER_TOTAL;
        
        // Picks whether the obstacle is a chest, door or enemy
        if (RandomInt < ENCOUNTER_CHEST_CHANCE && Index != Encounters - 1) {
            NSLog(@"%@", [NSString stringWithFormat:@"Picked chest of level %ld", DesiredLevel]);
            [Temp GenerateChest:DesiredLevel];
            [self.ObstacleArray addObject:Temp];
            [Temp GenerateChestDead:DesiredLevel];
        } else if (RandomInt < (ENCOUNTER_CHEST_CHANCE + ENCOUNTER_DOOR_CHANCE) || Index == Encounters - 1) {
            NSLog(@"%@", [NSString stringWithFormat:@"Picked door of level %ld", DesiredLevel]);
            [Temp GenerateDoor:DesiredLevel];
            [self.ObstacleArray addObject:Temp];
            [Temp GenerateChestDead:DesiredLevel];
        } else {
            NSLog(@"%@", [NSString stringWithFormat:@"Picked enemy of level %ld", DesiredLevel]);
            [Temp GenerateEnemy:DesiredLevel];
        }
        // Add obstacle to ObstacleArray
        [self.ObstacleArray addObject:Temp];
        
    } // And repeat...
    
    return Encounters;
}

#pragma mark OnTick

-(NSMutableArray *)OnAnyTick {
    NSLog(@"OnAnyTick called from GameController");
    // Auto load obstacle ability amount
    NSString *HealthLabel = @"00/00";
    NSString *Button1Label = @"00/00";
    NSString *Button2Label = @"00/00";
    NSString *CoinsLabel = @"Coins: 000";
    NSString *ObstacleImageTitle = @"placeholder.png";
    NSString *PlayerImageTitle = @"placeholder.png";
    NSString *ObstacleWeaponStatus;
    
    NSMutableArray *ReturnValues = [NSMutableArray arrayWithCapacity:6];
    
    ObstacleClass *Temp = [self.ObstacleArray objectAtIndex:self.CurrentObstacle];
    
    NSLog(@"/// TURN %ld BEGIN \\\\\\", self.ClicksPressed + 1);
    
    // Call onbstacle weapon AutoIncrement
    NSLog(@"Obstacle Ability...");
    ObstacleWeaponStatus = [Temp.Ability AutoIncrement];
    // Added these 2 lines to confirm that the stuff done to temp is also done to the stored obstacle
    NSLog(@"Temp storage click amount %ld", [Temp GetClickAmount]);
    NSLog(@"Actual storage click amount %ld", [[self.ObstacleArray objectAtIndex:self.CurrentObstacle] GetClickAmount]);
    
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
            NSInteger DamageFromObstacle = [[Temp.Ability DamageDealtOnClick] objectAtIndex:0];
            // Since there are no mechanics for the player to be stunned, no obstacle can stun a player
            // Therefore, only the first element of the array is cared about
            NSLog(@"Obstacle damage to player is %ld", DamageFromObstacle);
            
            // Apply damage to the player
            float DamageToPlayer = [self.Player CalculateDamage:DamageFromObstacle];
            HealthLabel = [self.Player DoDamage:DamageToPlayer];
        }
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
    
    NSMutableArray *ReturnValues = [NSMutableArray arrayWithCapacity:6];
    NSMutableArray *Damage1 = [NSMutableArray arrayWithCapacity:2];
    NSMutableArray *Damage2 = [NSMutableArray arrayWithCapacity:2];
    
    ObstacleClass *Temp = [self.ObstacleArray objectAtIndex:self.CurrentObstacle];
    
    ReturnValues = [self OnAnyTick];
    
    // Call weapon 1 DamageDealtOnClick
    NSLog(@"Player weapon 1 attack processing...");
    Damage1 = [self.Player.Button1 DamageDealtOnClick];
    NSLog(@"Damage to be done is %@. Stun amount to be done is %@", [Damage1 objectAtIndex:0], [Damage1 objectAtIndex:1]);
    Button1Label = [Damage1 objectAtIndex:2];
    [ReturnValues replaceObjectAtIndex:1 withObject:Button1Label];
    
    // Call weapon 2 DamageDealtOnClick
    NSLog(@"Player weapon 2 attack processing...");
    Damage2 = [self.Player.Button2 DamageDealtOnClick];
    NSLog(@"Damage to be done is %@. Stun amount to be done is %@", [Damage2 objectAtIndex:0], [Damage2 objectAtIndex:1]);
    Button2Label = [Damage2 objectAtIndex:2];
    [ReturnValues replaceObjectAtIndex:2 withObject:Button2Label];
    
    // Do damage to obstacle here
    // Need to get the image and the coins returned
    // Need to update the coins label
    
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
    NSLog(@"HealthLabel %@ Button1Label %@ Button2Label %@", [ReturnValues objectAtIndex:0], [ReturnValues objectAtIndex:1], [ReturnValues objectAtIndex:2]);
    [self OnEndTurn];
    return ReturnValues;
}

-(NSMutableArray *)OnButton2Click {
    NSLog(@"Button 2 clicked from GameController");
    
    NSMutableArray *ReturnValues = [NSMutableArray arrayWithCapacity:6];
    
    ReturnValues = [self OnAnyTick];
    // Call weapon 2 manual increment method
    [ReturnValues replaceObjectAtIndex:2 withObject:[self.Player.Button2 ManualIncrement]];
    NSLog(@"HealthLabel %@ Button1Label %@ Button2Label %@", [ReturnValues objectAtIndex:0], [ReturnValues objectAtIndex:1], [ReturnValues objectAtIndex:2]);
    [self OnEndTurn];
    return ReturnValues;
}

-(void)OnEndTurn {
    NSLog(@"/// TURN %ld END \\\\\\", self.ClicksPressed + 1);
    
    self.ClicksPressed += 1;
    //Do player damage here
}

#pragma mark Getters

-(NSString *)GetObstacleName {
    ObstacleClass *Temp = [self.ObstacleArray objectAtIndex:self.CurrentObstacle];
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
