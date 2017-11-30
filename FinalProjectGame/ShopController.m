//
//  ShopController.m
//  FinalProjectGame
//
//  Created by Daniel Piper [el16dsp] on 28/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "ShopController.h"

@interface ShopController ()

@end

@implementation ShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Data = [[DataStore alloc] init];
    //[self.navigationItem]
    
    NSLog(@"Loading shop with class %ld and %ld coins", self.ClassSelected, self.Coins);
    self.CoinsLabel.text = [NSString stringWithFormat:@"Coins: %3ld", self.Coins];
    
    self.Cost1 = [self.Data GetWeapon1Cost:self.ClassSelected];
    self.Cost2 = [self.Data GetWeapon2Cost:self.ClassSelected];
    
    [self.Button1UpgradeOutlet setTitle:[NSString stringWithFormat:@"Upgrade %@ for %ld coins", [self.Data GetWeapon1Title:self.ClassSelected], self.Cost1] forState:UIControlStateNormal];
    [self.Button2UpgradeOutlet setTitle:[NSString stringWithFormat:@"Upgrade %@ for %ld coins", [self.Data GetWeapon2Title:self.ClassSelected], self.Cost2] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark Buttons

- (IBAction)Button1UpgradeAction:(id)sender {
    NSLog(@"Button 1 Upgrade pressed");
    // IF enough coins, decrease coins by amount spent and save new level in file
    if (self.Coins >= self.Cost1) {
        self.Coins -= self.Cost1;
        [self.Data SaveData:self.ClassSelected :0 :[self.Data GetWeapon1Level:self.ClassSelected]];
        self.CoinsLabel.text = [NSString stringWithFormat:@"Coins: %3ld", self.Coins];
        self.Cost1 = [self.Data GetWeapon1Cost:self.ClassSelected];
        [self.Button1UpgradeOutlet setTitle:[NSString stringWithFormat:@"Upgrade %@ for %ld coins", [self.Data GetWeapon1Title:self.ClassSelected], self.Cost1] forState:UIControlStateNormal];
    }
}

- (IBAction)Button2UpgradeAction:(id)sender {
    NSLog(@"Button 2 Upgrade pressed");
    // IF enough coins, decrease coins by amount spent and save new level in file
    if (self.Coins >= self.Cost2) {
        self.Coins -= self.Cost2;
        [self.Data SaveData:self.ClassSelected
                           :1
                           :[self.Data GetWeapon2Level:self.ClassSelected]+1];
        self.CoinsLabel.text = [NSString stringWithFormat:@"Coins: %3ld", self.Coins];
        self.Cost2 = [self.Data GetWeapon2Cost:self.ClassSelected];
        [self.Button2UpgradeOutlet setTitle:[NSString stringWithFormat:@"Upgrade %@ for %ld coins", [self.Data GetWeapon2Title:self.ClassSelected], self.Cost2] forState:UIControlStateNormal];
    }
}

@end
