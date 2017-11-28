//
//  DataStore.m
//  FinalProjectGame
//
//  Created by Daniel Piper [el16dsp] on 13/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "DataStore.h"
#import "PlayerClass.h"
#define DATA_STORE_STRING_SPLITTER @":"
#define MAKE_TEMP_PLAYER PlayerClass *Temp = [self.PlayerClassArray objectAtIndex:Class];

@implementation DataStore

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSLog(@"DataStore init called");
        
        self.PlayerClassArray = [NSMutableArray array];
        
        self.StoredData = [self LoadData];
        
        // Make placeholder classes here
        PlayerClass *class_0 = [[PlayerClass alloc] init];
        NSLog(@"Defining player classes");
        // Fill in classes here
        // As it turns out, each class will need it's own weapon subclasses to override them.
        class_0.Name = @"Cutter";
        class_0.ImageBasis = @"class_0";
        class_0.MaxHealth = 40;
        class_0.CurrentHealth = class_0.MaxHealth;
        class_0.Armour = 0;
        
        class_0.Button1 = [[class_0_1 alloc] init];
        class_0.Button1.Level = [[[self.StoredData componentsSeparatedByString:DATA_STORE_STRING_SPLITTER] objectAtIndex:0] intValue];
        NSLog(@"Button1 level is %ld", class_0.Button1.Level);
        [class_0.Button1 UpdateStats];
        class_0.Button1.Type = @"W";
        class_0.Button1.Name = @"Pistol";
        class_0.Button1.ImageName = @"pistol.png"; // TODO Add picture to supporting files
        class_0.Button1.Description = @"A basic weapon for a basic pirate";
        NSLog(@"Button1 new name is %@", class_0.Button1.Name);
        
        class_0.Button2 = [[class_0_2 alloc] init];
        class_0.Button2.Level = [[[self.StoredData componentsSeparatedByString:DATA_STORE_STRING_SPLITTER] objectAtIndex:1] intValue];
        NSLog(@"Button2 level is %ld", class_0.Button2.Level);
        [class_0.Button2 UpdateStats];
        class_0.Button2.Type = @"A";
        class_0.Button2.Name = @"Blowtorch";
        class_0.Button2.ImageName = @"blowtorch.png"; // TODO Add picture to supporting files
        class_0.Button2.Description = @"A versatile tool for a versatile pirate";
        NSLog(@"Button2 new name is %@", class_0.Button2.Name);
        
        [self.PlayerClassArray addObject:class_0];
    }
    return self;
}

-(NSString *) LoadData {
    // Find out how to find class level data and import that
    // Taken from http://www.ios-blog.co.uk/tutorials/read-text-files-in-ios-objective/ on 2017-NOV-13
    NSString *path = [[NSBundle mainBundle] pathForResource:@"class_levels_data"
                                                     ofType:@"txt"];
    NSLog(@"%@", path);
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSLog(@"%@", content);
    return content;
}

-(NSInteger) SaveData:(NSInteger) Class
                     :(NSInteger) WeaponOffset
                     :(NSInteger) NewLevel {
    // Save class levels into text file
    NSInteger NumberOfClasses = [self.PlayerClassArray count];
    NSMutableArray *ClassData = [NSMutableArray arrayWithCapacity:NumberOfClasses];
    
    // Get path
    NSString *path = [[NSBundle mainBundle] pathForResource:@"class_levels_data"
                                                     ofType:@"txt"];
    NSLog(@"%@", path);
    
    // Make string
    NSString *content = self.StoredData;
    for (NSInteger index = 0; index < NumberOfClasses*2; index++) {
        NSString *cell_value = [[content componentsSeparatedByString:DATA_STORE_STRING_SPLITTER] objectAtIndex:index];
        NSLog(@"Cell %ld:%@", index, cell_value);
        [ClassData addObject:cell_value];
    }
    // Level index is 2*ClassNumber+(1 IF Weapon is Button2, 0 if not). ClassNumber starts at 0
    NSString *NewLevelString = [NSString stringWithFormat:@"%ld", NewLevel];
    NSInteger DataSaveIndex = 2*Class+WeaponOffset;
    NSLog(@"Saving %@ into index %ld", NewLevelString, DataSaveIndex);
    [ClassData replaceObjectAtIndex:DataSaveIndex withObject:NewLevelString];
    
    content = [ClassData componentsJoinedByString:DATA_STORE_STRING_SPLITTER];
    NSLog(@"New Data: %@", content);
    
    // Dump string into file
    self.StoredData = content;
    
    // Taken from https://stackoverflow.com/questions/1820204/objective-c-creating-a-text-file-with-a-string on 2017-NOV-28
    NSLog(@"File saved: %d", [content writeToFile:[NSString stringWithFormat:@"%@", path] atomically:NO encoding:NSStringEncodingConversionAllowLossy error:nil]);
    
    // Remakes classes with the new data
    [self init];
    
    return 0;
}

-(NSString *) GetClassName:(NSInteger)Class {
    MAKE_TEMP_PLAYER
    return Temp.Name;
}

-(NSString *) GetWeapon1Title:(NSInteger)Class {
    MAKE_TEMP_PLAYER
    return Temp.Button1.Name;
}

-(NSString *) GetWeapon2Title:(NSInteger)Class {
    MAKE_TEMP_PLAYER
    return Temp.Button2.Name;
}

-(NSInteger) GetWeapon1Cost:(NSInteger) Class {
    float CostPrecise;
    NSInteger Cost;
    MAKE_TEMP_PLAYER
    float NumberOfStatsAffectedByLevelling = Temp.Button1.LevelsPerUpgrade;
    float CurrentLevel = Temp.Button1.Level;
    CostPrecise = (1.0 + 0.1 * NumberOfStatsAffectedByLevelling) * powf(10.0, 1 + ((1 + 0.1 * NumberOfStatsAffectedByLevelling) * CurrentLevel)/12);
    NSLog(@"Precise cost for upgrading %@ to level %.0f is %3.3f", Temp.Button1.Name, CurrentLevel + 1.0, CostPrecise);
    Cost = (NSInteger)roundf(CostPrecise);
    NSLog(@"Actual cost for upgrading is %ld", Cost);
    return Cost;
}

-(NSInteger) GetWeapon2Cost:(NSInteger) Class {
    float CostPrecise;
    NSInteger Cost;
    MAKE_TEMP_PLAYER
    float NumberOfStatsAffectedByLevelling = Temp.Button2.LevelsPerUpgrade;
    float CurrentLevel = Temp.Button2.Level;
    CostPrecise = (1.0 + 0.1 * NumberOfStatsAffectedByLevelling) * powf(10.0, 1 + ((1 + 0.1 * NumberOfStatsAffectedByLevelling) * CurrentLevel)/12);
    NSLog(@"Precise cost for upgrading %@ to level %.0f is %3.3f", Temp.Button2.Name, CurrentLevel + 1.0, CostPrecise);
    Cost = (NSInteger)roundf(CostPrecise);
    NSLog(@"Actual cost for upgrading is %ld", Cost);
    return Cost;
}

-(NSInteger) GetWeapon1Level:(NSInteger)Class {
    MAKE_TEMP_PLAYER
    return Temp.Button1.Level;
}

-(NSInteger) GetWeapon2Level:(NSInteger)Class {
    MAKE_TEMP_PLAYER
    return Temp.Button2.Level;
}

@end
