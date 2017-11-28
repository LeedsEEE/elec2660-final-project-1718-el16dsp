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
@property (strong, nonatomic) NSString *StoredData;

-(NSString *) LoadData; // String returning methods taken from https://stackoverflow.com/questions/2975367/how-to-define-a-function-that-returns-a-string-in-objective-c-iphone-sdk on 2017-NOV-14
-(NSInteger) SaveData;

-(NSString *) GetClassName:(NSInteger) Class;
-(NSString *) GetWeapon1Title:(NSInteger) Class;
-(NSString *) GetWeapon2Title:(NSInteger) Class;

@end
