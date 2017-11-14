//
//  ViewController.m
//  FinalProjectGame
//
//  Created by Daniel Piper [el16dsp] on 07/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ViewController Loaded");
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Button1Pressed:(id)sender {
    // Start events on any button press
    // Load weapon if type is a weapon
    // Charge (and fire) if type is an ability
}

- (IBAction)Button2Pressed:(id)sender {
    // Functionally the same as Button1Pressed but for a different ability
}

- (IBAction)CentralButtonPressed:(id)sender {
    // Start events on any button press
    // Do damage from weapons
}
@end
