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

@implementation DataStore

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSLog(@"DataStore init called");
        
        self.PlayerClassArray = [NSMutableArray array];
        
        // Make placeholder classes here
        PlayerClass *class_0 = [[PlayerClass alloc] init];
        //PlayerClass *class_1 = [[PlayerClass alloc] init];
        
        self.StoredData = [self LoadData];
        
        // Fill in classes here
        // As it turns out, each class will need it's own weapon subclasses to override them.
        class_0.Name = @"Cutter";
        class_0.ImageBasis = @"class_0";
        class_0.MaxHealth = 40;
        class_0.Armour = 0;
        
        class_0.Button1 = [[class_0_1 alloc] init];
        class_0.Button1.Level = [[[self.StoredData componentsSeparatedByString:DATA_STORE_STRING_SPLITTER] objectAtIndex:0] intValue];
        NSLog(@"Button1 level is %ld", class_0.Button1.Level);
        class_0.Button1.Type = @"W";
        class_0.Button1.Name = @"Pistol";
        class_0.Button1.ImageName = @"pistol.png"; // TODO Add picture to supporting files
        class_0.Button1.Description = @"A basic weapon for a basic pirate";
        NSLog(@"Button1 new name is %@", class_0.Button1.Name);
        
        class_0.Button2 = [[class_0_2 alloc] init];
        class_0.Button2.Level = [[[self.StoredData componentsSeparatedByString:DATA_STORE_STRING_SPLITTER] objectAtIndex:1] intValue];
        NSLog(@"Button2 level is %ld", class_0.Button2.Level);
        class_0.Button2.Type = @"A";
        class_0.Button2.Name = @"Grenade";
        class_0.Button2.ImageName = @"grenade.png"; // TODO Add picture to supporting files
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

-(NSInteger) SaveData {
    // Save class levels into json file
    return 0;
}

@end
