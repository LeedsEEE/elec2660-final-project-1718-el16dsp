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
    // Start events on any button press
    // Load weapon if type is a weapon
    // Charge (and fire) if type is an ability
}

- (IBAction)CentralButtonPressed:(id)sender {
    NSLog(@"Central button pressed");
    [self.GameHandler OnObstacleClick];
    // Start events on any button press
    // Do damage from weapons
}

-(void) UpdateLabels: (NSString *)HealthLabel // Strings are of form @"16/20"
                    :(NSString *)Button1Label
                    :(NSString *)Button2Label {
    // Taken from https://stackoverflow.com/questions/3655104/iphone-ipad-how-to-get-screen-width-programmatically on 2017-NOV-15
    CGRect Screen = [[UIScreen mainScreen] bounds];
    CGFloat ScreenWidth = CGRectGetWidth(Screen);
    NSLog(@"Update labels called with width %f", ScreenWidth);
    
    // Pull integers from the strings and find the ratio betwen them
    NSInteger MaxHealth = [[[HealthLabel componentsSeparatedByString:@"/"] objectAtIndex:1] intValue];
    NSInteger CurrentHealth = [[[HealthLabel componentsSeparatedByString:@"/"] objectAtIndex:0] intValue];
    float HealthLabelProportion = (float)CurrentHealth/MaxHealth;
    NSLog(@"Health proportion is %f %ld/%ld", HealthLabelProportion, CurrentHealth, MaxHealth);
    
    NSInteger MaxCount1 = [[[Button1Label componentsSeparatedByString:@"/"] objectAtIndex:1] intValue];
    NSInteger CurrentCount1 = [[[Button1Label componentsSeparatedByString:@"/"] objectAtIndex:0] intValue];
    float Button1LabelProportion = (float)CurrentCount1/MaxCount1;
    NSLog(@"Button 1 proportion is %f %ld/%ld", Button1LabelProportion, CurrentCount1, MaxCount1);
    
    NSInteger MaxCount2 = [[[Button2Label componentsSeparatedByString:@"/"] objectAtIndex:1] intValue];
    NSInteger CurrentCount2 = [[[Button2Label componentsSeparatedByString:@"/"] objectAtIndex:0] intValue];
    float Button2LabelProportion = (float)CurrentCount2/MaxCount2;
    NSLog(@"Button 2 proportion is %f %ld/%ld", Button2LabelProportion, CurrentCount2, MaxCount2);
    
    
    // Update label text
    self.HealthLabelOutlet.text = HealthLabel; // Full screen width
    self.Button1LabelOutlet.text = Button1Label; // Half screen width
    self.Button2LabelOutlet.text = Button2Label; // Half screen width
    
    // Update label frames
    // Taken from https://stackoverflow.com/questions/13306604/how-to-change-the-width-of-label-once-after-its-frame-has-been-set-and-to-get-t on 2017-NOV-15
    CGRect HealthLabelFrame = [self.HealthLabelOutlet frame];
    HealthLabelFrame.size.width = HealthLabelProportion * ScreenWidth;
    [self.HealthLabelOutlet setFrame:HealthLabelFrame];
    
    CGRect Button1LabelFrame = [self.Button1LabelOutlet frame];
    Button1LabelFrame.size.width = 0.5 * Button1LabelProportion * ScreenWidth;
    [self.Button1LabelOutlet setFrame:Button1LabelFrame];
    
    CGRect Button2LabelFrame = [self.Button2LabelOutlet frame];
    Button2LabelFrame.size.width = 0.5 * Button2LabelProportion * ScreenWidth;
    [self.Button2LabelOutlet setFrame:Button2LabelFrame];
}

@end
