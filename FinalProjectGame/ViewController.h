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
@property (nonatomic) NSInteger ClassSelected;
@property (nonatomic) NSInteger RowSelected;

// Game view stuff start
@property (weak, nonatomic) IBOutlet UIButton *Button1Outlet;
@property (weak, nonatomic) IBOutlet UIButton *Button2Outlet;
@property (weak, nonatomic) IBOutlet UILabel *HealthLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *Button2LabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *Button1LabelOutlet;
@property (weak, nonatomic) IBOutlet UIButton *CentralButtonOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *PlayerImageOutlet;
@property (weak, nonatomic) IBOutlet UILabel *CoinsLabelOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *BackgroundImageOutlet;

- (IBAction)Button1Pressed:(id)sender;
- (IBAction)Button2Pressed:(id)sender;
- (IBAction)CentralButtonPressed:(id)sender;

-(void) UpdateLabels:(NSString *)HealthLabel // Strings are of form @"16/20"
                    :(NSString *)Button1Label
                    :(NSString *)Button2Label;
// Game view stuff end

// Inspection view start
// Inspection view end
@end

