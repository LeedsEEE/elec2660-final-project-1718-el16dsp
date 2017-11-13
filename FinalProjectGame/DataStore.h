//
//  DataStore.h
//  FinalProjectGame
//
//  Created by Daniel Piper [el16dsp] on 13/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataStore : NSObject

@property (strong, nonatomic) NSMutableArray *PlayerClassArray;

-(NSInteger) LoadData;
-(NSInteger) SaveData;

@end
