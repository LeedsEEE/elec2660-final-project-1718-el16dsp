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
        self.CurrentRoomObstacle = 0;
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

-(void)OnAnyTick {
    NSLog(@"OnAnyTick called from GameController");
    // Auto load obstacle ability amount
    // Call weapon 1 AutoIncrement
    // Call weapon 2 AutoIncrement
    // IF obstacle amount amount is full, fire
    // IF player ability 1 is an ability, call weapon 1 DamageDealtOnClick
    // IF player ability 2 is an ability, call weapon 2 DamageDealtOnClick
    // Update images and labels
}

-(void)OnObstacleClick {
    NSLog(@"ObstacleClicked from GameController");
    [self OnAnyTick];
    // IF player ability 1 is a weapon, call weapon 1 DamageDealtOnClick
    // IF player ability 2 is a weapon, call weapon 2 DamageDealtOnClick
}

-(void)OnButton1Click {
    NSLog(@"Button 1 clicked from GameController");
    [self OnAnyTick];
    // Call weapon 1 manual increment method
}

-(void)OnButton2Click {
    NSLog(@"Button 2 clicked from GameController");
    [self OnAnyTick];
    // Call weapon 2 manual increment method
}

-(void)ObstacleImageUpdate:(NSString *)NewImageName {
    // Call a method in ViewController to update the image by supplying a new name
}

-(void)PlayerImageUpdate:(NSString *)NewImageName {
    // Call a method in ViewController to update the image by supplying a new name
}

@end
