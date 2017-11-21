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
#define MODULE @"ELEC2660"

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
        self.BackgroundImageOutlet.hidden = NO;
        // TODO Add button images/frames
        
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
        self.BackgroundImageOutlet.hidden = YES;
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
        self.BackgroundImageOutlet.hidden = YES;
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

-(void) UpdateLabels:(NSString *)HealthLabel // Strings are of form @"16/20"
                    :(NSString *)Button1Label
                    :(NSString *)Button2Label { // Need to add the coins label
    // Taken from https://stackoverflow.com/questions/3655104/iphone-ipad-how-to-get-screen-width-programmatically on 2017-NOV-15
    CGRect Screen = [[UIScreen mainScreen] bounds];
    CGFloat ScreenWidth = CGRectGetWidth(Screen);
    NSLog(@"Update labels called with width %f", ScreenWidth);
    
    // Pull integers from the strings and find the ratio betwen them
    float HealthLabelProportion = [self CalcRatio:HealthLabel];
    float Button1LabelProportion = [self CalcRatio:Button1Label];
    float Button2LabelProportion = [self CalcRatio:Button2Label];
    
    NSLog(@"Health proportion is %f", HealthLabelProportion);
    NSLog(@"Button 1 proportion is %f", Button1LabelProportion);
    NSLog(@"Button 2 proportion is %f", Button2LabelProportion);
    
    // Update label frames
    // Taken from https://stackoverflow.com/questions/13306604/how-to-change-the-width-of-label-once-after-its-frame-has-been-set-and-to-get-t on 2017-NOV-15
    CGRect HealthLabelFrame = [self.HealthLabelOutlet frame];
    HealthLabelFrame.size.width = HealthLabelProportion * ScreenWidth;
    NSLog(@"New Health width %f", HealthLabelFrame.size.width);
    HealthLabelFrame.origin.x = ((1.0 - HealthLabelProportion) * ScreenWidth)/2.0;
    if (HealthLabelProportion < HEALTH_COLOUR_CHANGE_LIMIT) {
        [self.HealthLabelOutlet setBackgroundColor:[UIColor clearColor]];
        [self.HealthLabelOutlet setBackgroundColor:[UIColor redColor]];
    } else {
        [self.HealthLabelOutlet setBackgroundColor:[UIColor clearColor]];
        [self.HealthLabelOutlet setBackgroundColor:[UIColor greenColor]];
    }
    [self.HealthLabelOutlet setFrame:HealthLabelFrame];
    
    CGRect Button1LabelFrame = [self.Button1LabelOutlet frame];
    Button1LabelFrame.size.width = 0.5 * Button1LabelProportion * ScreenWidth; // 5 removed due to the margin offset. Originally thought to be 15 but this works better
    NSLog(@"New Button1 width %f", Button1LabelFrame.size.width);
    [self.Button1LabelOutlet setFrame:Button1LabelFrame];
    
    CGRect Button2LabelFrame = [self.Button2LabelOutlet frame];
    Button2LabelFrame.size.width = 0.5 * Button2LabelProportion * ScreenWidth; // 5 removed due to the margin offset. Originally thought to be 15 but this works better
    Button2LabelFrame.origin.x = ScreenWidth - 0.5 * Button2LabelProportion * ScreenWidth;
    NSLog(@"New Button2 width %f", Button2LabelFrame.size.width);
    [self.Button2LabelOutlet setFrame:Button2LabelFrame];
    
    // Update label text
    NSLog(@"Updating labels with: Health %@, Button1 %@, Button2 %@", HealthLabel, Button1Label, Button2Label);
    [self.HealthLabelOutlet setText:HealthLabel]; // Full screen width
    [self.Button1LabelOutlet setText:Button1Label]; // Half screen width
    [self.Button2LabelOutlet setText:Button2Label]; // Half screen width
    
    // TODO Make sure that the width changes on update rather than on the next update
    // System seems to redraw in the idle time between button presses
    [self.view setNeedsDisplay];
}

-(float) CalcRatio:(NSString *)RatioString {
    NSInteger Denominator = [[[RatioString componentsSeparatedByString:@"/"] objectAtIndex:1] intValue];
    NSInteger Numerator = [[[RatioString componentsSeparatedByString:@"/"] objectAtIndex:0] intValue];
    
    NSLog(@"Old Values: %ld/%ld", Numerator, Denominator);
    if (Denominator == 0) { // Added to deal with 'Not a Number' errors
        Denominator = 1;
    }
    if (Numerator == 0) {
        Numerator = 1;
    }
    NSLog(@"New Values: %ld/%ld", Numerator, Denominator);
    float Ratio = (float)Numerator/Denominator;
    return Ratio;
}

-(void) UpdateImages:(NSString *)PlayerImageTitle
                    :(NSString *)ObstacleImageTitle {
    // Taken from https://stackoverflow.com/questions/1469474/setting-an-image-for-a-uibutton-in-code on 21-NOV-2017
    UIImage *PlayerImage = [UIImage imageNamed:PlayerImageTitle];
    [self.PlayerImageOutlet setImage:PlayerImage];
    
    UIImage *ObstacleImage = [UIImage imageNamed:ObstacleImageTitle];
    [self.CentralButtonOutlet setImage:ObstacleImage forState:UIControlStateNormal];
}
@end
