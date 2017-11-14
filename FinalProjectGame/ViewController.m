//
//  ViewController.m
//  FinalProjectGame
//
//  Created by Daniel Piper [el16dsp] on 07/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "ViewController.h"
#import "GameController.h"
#import "DataStore.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ViewController Loaded");
    self.GameHandler = [[GameController alloc] init];
    NSLog(@"Class %ld selected in ViewController", self.ClassSelected);
    NSLog(@"GameHandler loaded");
    
    self.GameHandler.Player = [[[DataStore alloc] init].PlayerClassArray objectAtIndex:self.ClassSelected];
    NSLog(@"Class %ld %@ loaded with %@ and %@", self.ClassSelected, self.GameHandler.Player.Name, self.GameHandler.Player.Button1.Name, self.GameHandler.Player.Button2.Name);
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Button1Pressed:(id)sender {
    NSLog(@"Button 1 pressed");
    [self.GameHandler OnButton1Click];
    // Start events on any button press
    // Load weapon if type is a weapon
    // Charge (and fire) if type is an ability
}

- (IBAction)Button2Pressed:(id)sender {
    NSLog(@"Button 2 pressed");
    [self.GameHandler OnButton2Click];
    // Functionally the same as Button1Pressed but for a different ability
}

- (IBAction)CentralButtonPressed:(id)sender {
    NSLog(@"Central button pressed");
    [self.GameHandler OnObstacleClick];
    // Start events on any button press
    // Do damage from weapons
}
@end
