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
            NSLog(@"%@", [NSString stringWithFormat:@"Generated chest of level %ld", DesiredLevel]);
            [Temp GenerateChest:DesiredLevel];
        } else if (RandomInt < (ENCOUNTER_CHEST_CHANCE + ENCOUNTER_DOOR_CHANCE) || Index == Encounters - 1) {
            NSLog(@"%@", [NSString stringWithFormat:@"Generated door of level %ld", DesiredLevel]);
            [Temp GenerateDoor:DesiredLevel];
        } else {
            NSLog(@"%@", [NSString stringWithFormat:@"Generated enemy of level %ld", DesiredLevel]);
            [Temp GenerateEnemy:DesiredLevel];
        }
        // Add obstacle to ObstacleArray
        [self.ObstacleArray addObject:Temp];
        
    } // And repeat...
    
    return Encounters;
}

-(NSMutableArray *)OnAnyTick {
    NSLog(@"OnAnyTick called from GameController");
    // Auto load obstacle ability amount
    NSString *HealthLabel = @"00/00";
    NSString *Button1Label = @"00/00";
    NSString *Button2Label = @"00/00";
    NSMutableArray *ReturnValues = [NSMutableArray arrayWithCapacity:3];
    
    [self.ObstacleArray objectAtIndex:self.CurrentObstacle]; // TODO
    
    
    // Call weapon 1 AutoIncrement
    Button1Label = [self.Player.Button1 AutoIncrement];
    NSLog(@"Button 1 label is %@", Button1Label);
    
    // Call weapon 2 AutoIncrement
    Button2Label = [self.Player.Button2 AutoIncrement];
    NSLog(@"Button 2 label is %@", Button2Label);
    
    // IF obstacle amount amount is full, fire
    // IF player ability 1 is an ability, call weapon 1 DamageDealtOnClick
    // IF player ability 2 is an ability, call weapon 2 DamageDealtOnClick
    // Update images and labels
    // TODO modify labels so that their size can be changed
    
    NSLog(@"HealthLabel %@ Button1Label %@ Button2Label %@", HealthLabel, Button1Label, Button2Label);
    [ReturnValues addObject:HealthLabel];
    [ReturnValues addObject:Button1Label];
    [ReturnValues addObject:Button2Label];
    return ReturnValues;
}

-(NSMutableArray *)OnObstacleClick {
    NSLog(@"ObstacleClicked from GameController");
    
    NSMutableArray *ReturnValues = [NSMutableArray arrayWithCapacity:3];
    
    ReturnValues = [self OnAnyTick];
    // IF player ability 1 is a weapon, call weapon 1 DamageDealtOnClick
    // IF player ability 2 is a weapon, call weapon 2 DamageDealtOnClick
    NSLog(@"HealthLabel %@ Button1Label %@ Button2Label %@", [ReturnValues objectAtIndex:0], [ReturnValues objectAtIndex:1], [ReturnValues objectAtIndex:2]);
    return ReturnValues;
}

-(NSMutableArray *)OnButton1Click {
    NSLog(@"Button 1 clicked from GameController");
    
    NSMutableArray *ReturnValues = [NSMutableArray arrayWithCapacity:3];
    
    ReturnValues = [self OnAnyTick];
    // Call weapon 1 manual increment method
    [ReturnValues replaceObjectAtIndex:1 withObject:[self.Player.Button1 ManualIncrement]];
    NSLog(@"HealthLabel %@ Button1Label %@ Button2Label %@", [ReturnValues objectAtIndex:0], [ReturnValues objectAtIndex:1], [ReturnValues objectAtIndex:2]);
    return ReturnValues;
}

-(NSMutableArray *)OnButton2Click {
    NSLog(@"Button 2 clicked from GameController");
    
    NSMutableArray *ReturnValues = [NSMutableArray arrayWithCapacity:3];
    
    ReturnValues = [self OnAnyTick];
    // Call weapon 2 manual increment method
    [ReturnValues replaceObjectAtIndex:2 withObject:[self.Player.Button2 ManualIncrement]];
    NSLog(@"HealthLabel %@ Button1Label %@ Button2Label %@", [ReturnValues objectAtIndex:0], [ReturnValues objectAtIndex:1], [ReturnValues objectAtIndex:2]);
    return ReturnValues;
}

-(void)ObstacleImageUpdate:(NSString *)NewImageName {
    // Call a method in ViewController to update the image by supplying a new name
}

-(void)PlayerImageUpdate:(NSString *)NewImageName {
    // Call a method in ViewController to update the image by supplying a new name
}

@end
