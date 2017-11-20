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
#define HEALTH_COLOUR_CHANGE_LIMIT 0.25
#define RED [UIColor colorWithRed:255 green:8 blue:0 alpha:1.0]
#define GREEN [UIColor colorWithRed:8 green:255 blue:0 alpha:1.0]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ViewController Loaded");
    if (self.RowSelected == 0) {
        NSLog(@"Game selected");
        self.GameHandler = [[GameController alloc] init];
        NSLog(@"Class %ld selected in ViewController", self.ClassSelected);
        NSLog(@"GameHandler loaded");
    
        self.GameHandler.Player = [[[DataStore alloc] init].PlayerClassArray objectAtIndex:self.ClassSelected];
        NSLog(@"Class %ld %@ loaded with %@ and %@", self.ClassSelected, self.GameHandler.Player.Name, self.GameHandler.Player.Button1.Name, self.GameHandler.Player.Button2.Name);
        // Hide inspect stuff
        
        // Show game stuff
        self.CentralButtonOutlet.hidden = NO;
        self.Button1Outlet.hidden = NO;
        self.Button2Outlet.hidden = NO;
        self.HealthLabelOutlet.hidden = NO;
        self.Button1LabelOutlet.hidden = NO;
        self.Button2LabelOutlet.hidden = NO;
        self.PlayerImageOutlet.hidden = NO;
        self.CoinsLabelOutlet.hidden = NO;
        
        [self UpdateLabels:[NSString stringWithFormat:@"%ld/%ld", self.GameHandler.Player.CurrentHealth, self.GameHandler.Player.MaxHealth]
                          :[NSString stringWithFormat:@"%ld/%ld", self.GameHandler.Player.Button1.ClickAmount, self.GameHandler.Player.Button1.ClicksPerClip]
                          :[NSString stringWithFormat:@"%ld/%ld", self.GameHandler.Player.Button2.ClickAmount, self.GameHandler.Player.Button2.ClicksPerClip]];
    }
    else if (self.RowSelected == 1) {
        NSLog(@"Inspect button 1");
        // Hide game stuff
        self.CentralButtonOutlet.hidden = YES;
        self.Button1Outlet.hidden = YES;
        self.Button2Outlet.hidden = YES;
        self.HealthLabelOutlet.hidden = YES;
        self.Button1LabelOutlet.hidden = YES;
        self.Button2LabelOutlet.hidden = YES;
        self.PlayerImageOutlet.hidden = YES;
        self.CoinsLabelOutlet.hidden = YES;
        // Show inspect stuff
    }
    else if (self.RowSelected == 2) {
        NSLog(@"Inspect button 2");
        // Hide game stuff
        self.CentralButtonOutlet.hidden = YES;
        self.Button1Outlet.hidden = YES;
        self.Button2Outlet.hidden = YES;
        self.HealthLabelOutlet.hidden = YES;
        self.Button1LabelOutlet.hidden = YES;
        self.Button2LabelOutlet.hidden = YES;
        self.PlayerImageOutlet.hidden = YES;
        self.CoinsLabelOutlet.hidden = YES;
        // Show inspect stuff
    }
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Button1Pressed:(id)sender {
    NSLog(@"Button 1 pressed");
    
    NSMutableArray *ReturnValues = [NSMutableArray arrayWithCapacity:3];
    
    ReturnValues = [self.GameHandler OnButton1Click];
    // Start events on any button press
    // Load weapon if type is a weapon
    // Charge (and fire) if type is an ability
    NSLog(@"HealthLabel %@ Button1Label %@ Button2Label %@", [ReturnValues objectAtIndex:0], [ReturnValues objectAtIndex:1], [ReturnValues objectAtIndex:2]);
    [self UpdateLabels:[ReturnValues objectAtIndex:0] :[ReturnValues objectAtIndex:1] :[ReturnValues objectAtIndex:2]];
}

- (IBAction)Button2Pressed:(id)sender {
    NSLog(@"Button 2 pressed");
    
    NSMutableArray *ReturnValues = [NSMutableArray arrayWithCapacity:3];
    
    ReturnValues = [self.GameHandler OnButton2Click];
    // Start events on any button press
    // Load weapon if type is a weapon
    // Charge (and fire) if type is an ability
    NSLog(@"HealthLabel %@ Button1Label %@ Button2Label %@", [ReturnValues objectAtIndex:0], [ReturnValues objectAtIndex:1], [ReturnValues objectAtIndex:2]);
    [self UpdateLabels:[ReturnValues objectAtIndex:0] :[ReturnValues objectAtIndex:1] :[ReturnValues objectAtIndex:2]];
}

- (IBAction)CentralButtonPressed:(id)sender {
    NSLog(@"Central button pressed");
    
    NSMutableArray *ReturnValues = [NSMutableArray arrayWithCapacity:3];
    
    ReturnValues = [self.GameHandler OnObstacleClick];
    // Start events on any button press
    // Do damage from weapons
    NSLog(@"HealthLabel %@ Button1Label %@ Button2Label %@", [ReturnValues objectAtIndex:0], [ReturnValues objectAtIndex:1], [ReturnValues objectAtIndex:2]);
    [self UpdateLabels:[ReturnValues objectAtIndex:0] :[ReturnValues objectAtIndex:1] :[ReturnValues objectAtIndex:2]];
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
    
    NSLog(@"Old Health Values: %ld/%ld", CurrentHealth, MaxHealth);
    if (MaxHealth == 0) { // Added to deal with 'Not a Number' errors
        MaxHealth = 1;
    }
    if (CurrentHealth == 0) {
        CurrentHealth = 1;
    }
    NSLog(@"New Health Values: %ld/%ld", CurrentHealth, MaxHealth);
    
    float HealthLabelProportion = (float)CurrentHealth/MaxHealth;
    NSLog(@"Health proportion is %f %ld/%ld", HealthLabelProportion, CurrentHealth, MaxHealth);
    
    NSInteger MaxCount1 = [[[Button1Label componentsSeparatedByString:@"/"] objectAtIndex:1] intValue];
    NSInteger CurrentCount1 = [[[Button1Label componentsSeparatedByString:@"/"] objectAtIndex:0] intValue];
    
    NSLog(@"Old Count1 Values: %ld/%ld", CurrentCount1, MaxCount1);
    if (MaxCount1 == 0) { // Added to deal with 'Not a Number' errors
        MaxCount1 = 1;
    }
    if (CurrentCount1 == 0) {
        CurrentCount1 = 1;
    }
    NSLog(@"New Count1 Values: %ld/%ld", CurrentCount1, MaxCount1);
    
    float Button1LabelProportion = (float)CurrentCount1/MaxCount1;
    NSLog(@"Button 1 proportion is %f %ld/%ld", Button1LabelProportion, CurrentCount1, MaxCount1);
    
    NSInteger MaxCount2 = [[[Button2Label componentsSeparatedByString:@"/"] objectAtIndex:1] intValue];
    NSInteger CurrentCount2 = [[[Button2Label componentsSeparatedByString:@"/"] objectAtIndex:0] intValue];
    
    NSLog(@"Old Count2 Values: %ld/%ld", CurrentCount2, MaxCount2);
    if (MaxCount2 == 0) { // Added to deal with 'Not a Number' errors
        MaxCount2 = 1;
    }
    if (CurrentCount2 == 0) {
        CurrentCount2 = 1;
    }
    NSLog(@"New Count2 Values: %ld/%ld", CurrentCount2, MaxCount2);
    
    float Button2LabelProportion = (float)CurrentCount2/MaxCount2;
    NSLog(@"Button 2 proportion is %f %ld/%ld", Button2LabelProportion, CurrentCount2, MaxCount2);
    
    
    // Update label text
    NSLog(@"Updating labels with: Health %@, Button1 %@, Button2 %@", HealthLabel, Button1Label, Button2Label);
    [self.HealthLabelOutlet setText:HealthLabel]; // Full screen width
    [self.Button1LabelOutlet setText:Button1Label]; // Half screen width
    [self.Button2LabelOutlet setText:Button2Label]; // Half screen width
    
    // Update label frames
    // Taken from https://stackoverflow.com/questions/13306604/how-to-change-the-width-of-label-once-after-its-frame-has-been-set-and-to-get-t on 2017-NOV-15
    CGRect HealthLabelFrame = [self.HealthLabelOutlet frame];
    HealthLabelFrame.size.width = HealthLabelProportion * ScreenWidth;
    NSLog(@"New Health width %f", HealthLabelFrame.size.width);
    HealthLabelFrame.origin.x = ((1.0 - HealthLabelProportion) * ScreenWidth)/2.0;
    [self.HealthLabelOutlet setFrame:HealthLabelFrame];
    if (HealthLabelProportion < HEALTH_COLOUR_CHANGE_LIMIT) {
        [self.HealthLabelOutlet setBackgroundColor:[UIColor clearColor]];
        [self.HealthLabelOutlet setBackgroundColor:RED];
    } else {
        [self.HealthLabelOutlet setBackgroundColor:[UIColor clearColor]];
        [self.HealthLabelOutlet setBackgroundColor:GREEN];
    }
    // TODO Make sure that the width changes on update rather than on the next update
    
    CGRect Button1LabelFrame = [self.Button1LabelOutlet frame];
    Button1LabelFrame.size.width = 0.5 * Button1LabelProportion * ScreenWidth - 5.0; // 5 removed due to the margin offset. Originally thought to be 15 but this works better
    NSLog(@"New Button1 width %f", Button1LabelFrame.size.width);
    [self.Button1LabelOutlet setFrame:Button1LabelFrame];
    
    CGRect Button2LabelFrame = [self.Button2LabelOutlet frame];
    Button2LabelFrame.size.width = 0.5 * Button2LabelProportion * ScreenWidth - 5.0; // 5 removed due to the margin offset. Originally thought to be 15 but this works better
    Button2LabelFrame.origin.x = ScreenWidth - 0.5 * Button2LabelProportion * ScreenWidth;
    NSLog(@"New Button2 width %f", Button2LabelFrame.size.width);
    [self.Button2LabelOutlet setFrame:Button2LabelFrame];
}

@end
