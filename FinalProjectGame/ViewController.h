//
//  ViewController.h
//  FinalProjectGame
//
//  Created by Daniel Piper [el16dsp] on 07/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameController.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) GameController *GameHandler;

// Segued stuff
@property (nonatomic) NSInteger ClassSelected;
@property (nonatomic) NSInteger RowSelected;
@property (nonatomic) NSInteger Cost;

// Game view stuff start
@property (weak, nonatomic) IBOutlet UIButton *Button1Outlet;
@property (weak, nonatomic) IBOutlet UIButton *Button2Outlet;

@property (weak, nonatomic) IBOutlet UILabel *HealthLabelOutlet;
@property (nonatomic) UIView *HealthBox;

@property (weak, nonatomic) IBOutlet UILabel *Button2LabelOutlet;
@property (nonatomic) UIView *Button1Box;

@property (weak, nonatomic) IBOutlet UILabel *Button1LabelOutlet;
@property (nonatomic) UIView *Button2Box;

@property (weak, nonatomic) IBOutlet UIButton *CentralButtonOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *PlayerImageOutlet;
@property (weak, nonatomic) IBOutlet UILabel *CoinsLabelOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *BackgroundImageOutlet;

- (IBAction)Button1Pressed:(id)sender;
- (IBAction)Button2Pressed:(id)sender;
- (IBAction)CentralButtonPressed:(id)sender;

-(void) UpdateLabelText:(NSString *)HealthLabel // Strings are of form @"16/20"
                       :(NSString *)Button1Label
                       :(NSString *)Button2Label
                       :(NSString *)CoinsLabel;
-(void) UpdateLabelSize:(NSString *)HealthLabel // Strings are of form @"16/20"
                       :(NSString *)Button1Label
                       :(NSString *)Button2Label
                       :(NSString *)CoinsLabel;
-(float) CalcRatio:(NSString *)RatioString; // Strings are of form @"16/20"
-(void) UpdateImages:(NSString *)PlayerImageTitle
                    :(NSString *)ObstacleImageTitle;
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender
                       :(id)sender;
// Game view stuff end

// Inspection view start
@property (weak, nonatomic) IBOutlet UILabel *ClassNameLabelOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *WeaponImageOutlet;
@property (weak, nonatomic) IBOutlet UILabel *DescriptionLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *LevelLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *DamageLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *ClicksPerClipLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *StunDurationLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *AutoClickRateLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *WeaponNameLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *CostLabel;
// Inspection view end
@end
