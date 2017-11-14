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

@property (weak, nonatomic) IBOutlet UIButton *Button1Outlet;
@property (weak, nonatomic) IBOutlet UIButton *Button2Outlet;
@property (weak, nonatomic) IBOutlet UILabel *HealthLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *Button2LabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *Button1LabelOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *PlayerImageOutlet;
@property (weak, nonatomic) IBOutlet UILabel *CoinsLabelOutlet;

@property (strong, nonatomic) GameController *GameHandler;
@property (nonatomic) NSInteger ClassSelected;

- (IBAction)Button1Pressed:(id)sender;
- (IBAction)Button2Pressed:(id)sender;
- (IBAction)CentralButtonPressed:(id)sender;

@end

