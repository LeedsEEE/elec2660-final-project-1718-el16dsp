//
//  DataStore.m
//  FinalProjectGame
//
//  Created by Daniel Piper [el16dsp] on 13/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "DataStore.h"

@implementation DataStore

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.PlayerClassArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSInteger) LoadData {
    // Find out how to find class level data and import that
    return 0;
}

-(NSInteger) SaveData {
    // Save class levels into txt file 
}

@end
