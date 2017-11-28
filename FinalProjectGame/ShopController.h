//
//  ShopController.h
//  FinalProjectGame
//
//  Created by Daniel Piper [el16dsp] on 28/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStore.h"

@interface ShopController : UIViewController

@property (nonatomic) NSInteger ClassSelected;
@property (nonatomic) NSInteger Coins;
@property (nonatomic) NSInteger Cost1;
@property (nonatomic) NSInteger Cost2;
@property (strong, nonatomic) DataStore *Data;

@property (weak, nonatomic) IBOutlet UILabel *CoinsLabel;
@property (weak, nonatomic) IBOutlet UIButton *Button1UpgradeOutlet;
@property (weak, nonatomic) IBOutlet UIButton *Button2UpgradeOutlet;

- (IBAction)Button1UpgradeAction:(id)sender;
- (IBAction)Button2UpgradeAction:(id)sender;

@end
