//
//  DataStore.m
//  FinalProjectGame
//
//  Created by Daniel Piper [el16dsp] on 13/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "DataStore.h"
#import "PlayerClass.h"

@implementation DataStore

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.PlayerClassArray = [NSMutableArray array];
        
        // Make placeholder classes here
        PlayerClass *class_0 = [[PlayerClass alloc] init];
        PlayerClass *class_1 = [[PlayerClass alloc] init];
        
        [self LoadData];
        
        // Fill in classes here
        // As it turns out, each class will need it's own weapon subclasses to override them.
        class_0.Name = @"Cutter";
        class_0.ImageBasis = @"class_0";
        class_0.MaxHealth = 40;
        class_0.Armour = 0;
        
        class_0.Button1.Type = @"W";
        class_0.Button1.Name = @"Pistol";
        class_0.Button1.ImageName = @"pistol.png"; // TODO Add picture to supoprting files
        class_0.Button1.Description = @"A basic weapon for a basic pirate";
    }
    return self;
}

-(NSInteger) LoadData {
    // Find out how to find class level data and import that
    // taken from http://www.ios-blog.co.uk/tutorials/read-text-files-in-ios-objective/
    NSString *path = [[NSBundle mainBundle] pathForResource:@"class_levels_data"
                                                     ofType:@"txt"];
    NSLog(@"%@", path);
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSLog(@"%@", content);
    return 0;
}

-(NSInteger) SaveData {
    // Save class levels into json file
    return 0;
}

@end
