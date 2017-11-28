//
//  ViewController.m
//  FinalProjectGame
//
//  Created by Daniel Piper [el16dsp] on 07/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "ViewController.h"
#import "GameController.h"
#import "ShopController.h"
#import "DataStore.h"
#define HEALTH_COLOUR_CHANGE_LIMIT 0.40
#define MODULE @"ELEC2660"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ViewController Loaded");
    
    // Set Label Content Mode to not autosize
    self.HealthLabelOutlet.autoresizesSubviews = NO;
    
    if (self.RowSelected == 0) {
        NSLog(@"Game selected");
        self.GameHandler = [[GameController alloc] init];
        NSLog(@"Class %ld selected in ViewController", self.ClassSelected);
        NSLog(@"GameHandler loaded");
    
        self.GameHandler.Player = [[[DataStore alloc] init].PlayerClassArray objectAtIndex:self.ClassSelected];
        NSLog(@"Class %ld %@ loaded with %@ and %@", self.ClassSelected, [self.GameHandler GetPlayerName], [self.GameHandler GetWeapon1Name], [self.GameHandler GetWeapon2Name]);
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
        [self.Button1Outlet setTitle:[NSString stringWithFormat:@"Load %@", [self.GameHandler GetWeapon1Name]] forState:UIControlStateNormal];
        [self.Button2Outlet setTitle:[NSString stringWithFormat:@"Load %@", [self.GameHandler GetWeapon2Name]] forState:UIControlStateNormal];
        [self UpdateLabelSize:[NSString stringWithFormat:@"%ld/%ld", self.GameHandler.Player.CurrentHealth, self.GameHandler.Player.MaxHealth]
                             :[NSString stringWithFormat:@"%ld/%ld", self.GameHandler.Player.Button1.ClickAmount, self.GameHandler.Player.Button1.ClicksPerClip]
                             :[NSString stringWithFormat:@"%ld/%ld", self.GameHandler.Player.Button2.ClickAmount, self.GameHandler.Player.Button2.ClicksPerClip]
                             :@"Coins: 000"];
        [self UpdateImages:@"cutter_idle.png" :@"enemy_idle.png"];
        NSLog(@"/// GAME LOADED \\\\\\");
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
    
    NSInteger HealthNumerator = [[[[ReturnValues objectAtIndex:0] componentsSeparatedByString:@"/"] objectAtIndex:0] intValue];
    
    if (HealthNumerator > 0) {
        // If player not dead
        //[self UpdateLabelText:[ReturnValues objectAtIndex:0] :[ReturnValues objectAtIndex:1] :[ReturnValues objectAtIndex:2] :[ReturnValues objectAtIndex:3]];
        [self UpdateLabelSize:[ReturnValues objectAtIndex:0] :[ReturnValues objectAtIndex:1] :[ReturnValues objectAtIndex:2] :[ReturnValues objectAtIndex:3]];
        [self UpdateImages:[ReturnValues objectAtIndex:4] :[ReturnValues objectAtIndex:5]];
    } else {
        // Player is dead
        [self performSegueWithIdentifier:@"ShowShop" sender:self];
    }
}

- (IBAction)Button2Pressed:(id)sender {
    NSLog(@"Button 2 pressed");
    
    NSMutableArray *ReturnValues = [NSMutableArray arrayWithCapacity:3];
    
    ReturnValues = [self.GameHandler OnButton2Click];
    // Start events on any button press
    // Load weapon if type is a weapon
    // Charge (and fire) if type is an ability
    NSLog(@"HealthLabel %@ Button1Label %@ Button2Label %@", [ReturnValues objectAtIndex:0], [ReturnValues objectAtIndex:1], [ReturnValues objectAtIndex:2]);
    
    NSInteger HealthNumerator = [[[[ReturnValues objectAtIndex:0] componentsSeparatedByString:@"/"] objectAtIndex:0] intValue];
    
    if (HealthNumerator > 0) {
        // If player not dead
        //[self UpdateLabelText:[ReturnValues objectAtIndex:0] :[ReturnValues objectAtIndex:1] :[ReturnValues objectAtIndex:2] :[ReturnValues objectAtIndex:3]];
        [self UpdateLabelSize:[ReturnValues objectAtIndex:0] :[ReturnValues objectAtIndex:1] :[ReturnValues objectAtIndex:2] :[ReturnValues objectAtIndex:3]];
        [self UpdateImages:[ReturnValues objectAtIndex:4] :[ReturnValues objectAtIndex:5]];
    } else {
        // Player is dead
        [self performSegueWithIdentifier:@"ShowShop" sender:self];
    }
}

- (IBAction)CentralButtonPressed:(id)sender {
    NSLog(@"Central button pressed");
    
    NSMutableArray *ReturnValues = [NSMutableArray arrayWithCapacity:3];
    
    ReturnValues = [self.GameHandler OnObstacleClick];
    // Start events on any button press
    // Do damage from weapons
    NSLog(@"HealthLabel %@ Button1Label %@ Button2Label %@", [ReturnValues objectAtIndex:0], [ReturnValues objectAtIndex:1], [ReturnValues objectAtIndex:2]);
    
    NSInteger HealthNumerator = [[[[ReturnValues objectAtIndex:0] componentsSeparatedByString:@"/"] objectAtIndex:0] intValue];
    
    if (HealthNumerator > 0) {
        // If player not dead
        //[self UpdateLabelText:[ReturnValues objectAtIndex:0] :[ReturnValues objectAtIndex:1] :[ReturnValues objectAtIndex:2] :[ReturnValues objectAtIndex:3]];
        [self UpdateLabelSize:[ReturnValues objectAtIndex:0] :[ReturnValues objectAtIndex:1] :[ReturnValues objectAtIndex:2] :[ReturnValues objectAtIndex:3]];
        [self UpdateImages:[ReturnValues objectAtIndex:4] :[ReturnValues objectAtIndex:5]];
    } else {
        // Player is dead
        [self performSegueWithIdentifier:@"ShowShop" sender:self];
    }
}

-(void) UpdateLabelText:(NSString *)HealthLabel
                       :(NSString *)Button1Label
                       :(NSString *)Button2Label
                       :(NSString *)CoinsLabel {
    
    // Update label text
    // Commenting out these as this makes the labels change size and colour
    NSLog(@"Updating labels with: Health %@, Button1 %@, Button2 %@, Coins %@", HealthLabel, Button1Label, Button2Label, CoinsLabel);
    [self.HealthLabelOutlet setText:HealthLabel]; // Full screen width
    [self.Button1LabelOutlet setText:Button1Label]; // Half screen width
    [self.Button2LabelOutlet setText:Button2Label]; // Half screen width
    [self.CoinsLabelOutlet setText:CoinsLabel];
}

-(void) UpdateLabelSize:(NSString *)HealthLabel // Strings are of form @"16/20"
                       :(NSString *)Button1Label
                       :(NSString *)Button2Label
                       :(NSString *)CoinsLabel { // Need to add the coins label
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
        NSLog(@"Health label red");
        [self.HealthLabelOutlet setBackgroundColor:[UIColor clearColor]];
        [self.HealthLabelOutlet setBackgroundColor:[UIColor redColor]];
    } else {
        NSLog(@"Health label green");
        [self.HealthLabelOutlet setBackgroundColor:[UIColor clearColor]];
        [self.HealthLabelOutlet setBackgroundColor:[UIColor greenColor]];
    }
    [self.HealthLabelOutlet setFrame:HealthLabelFrame];
    
    CGRect Button1LabelFrame = [self.Button1LabelOutlet frame];
    Button1LabelFrame.size.width = 0.5 * Button1LabelProportion * ScreenWidth;
    NSLog(@"New Button1 width %f", Button1LabelFrame.size.width);
    if ([[self.GameHandler GetWeapon1Type] isEqualToString:@"W"] && [[[Button1Label componentsSeparatedByString:@"/"] objectAtIndex:0] intValue] == 0) {
        // Green if ammo remaining
        // Red if can't shoot
        NSLog(@"Button1 label red weapon");
        [self.Button1LabelOutlet setBackgroundColor:[UIColor clearColor]];
        [self.Button1LabelOutlet setBackgroundColor:[UIColor redColor]];
    } else if ([[self.GameHandler GetWeapon1Type] isEqualToString:@"W"]) {
        NSLog(@"Button1 label green weapon");
        [self.Button1LabelOutlet setBackgroundColor:[UIColor clearColor]];
        [self.Button1LabelOutlet setBackgroundColor:[UIColor greenColor]];
    } else if ([[self.GameHandler GetWeapon1Type] isEqualToString:@"A"] && Button1LabelProportion == 1.0) {
        // Green if can shoot (at full charge)
        // Red if can't
        NSLog(@"Button1 label green ability");
        [self.Button1LabelOutlet setBackgroundColor:[UIColor clearColor]];
        [self.Button1LabelOutlet setBackgroundColor:[UIColor greenColor]];
    } else if ([[self.GameHandler GetWeapon1Type] isEqualToString:@"A"]) {
        NSLog(@"Button1 label red ability");
        [self.Button1LabelOutlet setBackgroundColor:[UIColor clearColor]];
        [self.Button1LabelOutlet setBackgroundColor:[UIColor redColor]];
    }
    [self.Button1LabelOutlet setFrame:Button1LabelFrame];
    
    CGRect Button2LabelFrame = [self.Button2LabelOutlet frame];
    Button2LabelFrame.size.width = 0.5 * Button2LabelProportion * ScreenWidth;
    Button2LabelFrame.origin.x = ScreenWidth - 0.5 * Button2LabelProportion * ScreenWidth;
    NSLog(@"New Button2 width %f", Button2LabelFrame.size.width);
    if ([[self.GameHandler GetWeapon2Type] isEqualToString:@"W"] && [[[Button2Label componentsSeparatedByString:@"/"] objectAtIndex:0] intValue] == 0) {
        // Green if ammo remaining
        // Red if can't shoot
        NSLog(@"Button2 label red weapon");
        [self.Button2LabelOutlet setBackgroundColor:[UIColor clearColor]];
        [self.Button2LabelOutlet setBackgroundColor:[UIColor redColor]];
    } else if ([[self.GameHandler GetWeapon2Type] isEqualToString:@"W"]) {
        NSLog(@"Button2 label green weapon");
        [self.Button2LabelOutlet setBackgroundColor:[UIColor clearColor]];
        [self.Button2LabelOutlet setBackgroundColor:[UIColor greenColor]];
    } else if ([[self.GameHandler GetWeapon2Type] isEqualToString:@"A"] && Button2LabelProportion == 1.0) {
        // Green if can shoot (at full charge)
        // Red if can't
        NSLog(@"Button2 label green ability");
        [self.Button2LabelOutlet setBackgroundColor:[UIColor clearColor]];
        [self.Button2LabelOutlet setBackgroundColor:[UIColor greenColor]];
    } else if ([[self.GameHandler GetWeapon2Type] isEqualToString:@"A"]) {
        NSLog(@"Button2 label red ability");
        [self.Button2LabelOutlet setBackgroundColor:[UIColor clearColor]];
        [self.Button2LabelOutlet setBackgroundColor:[UIColor redColor]];
    }
    [self.Button2LabelOutlet setFrame:Button2LabelFrame];
    
    // TODO Make sure that the width changes on update rather than on the next update
    // System seems to redraw in the idle time between button presses and as long as the text hasn't changed
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
    NSLog(@"Updating images with %@ and %@", PlayerImageTitle, ObstacleImageTitle);
    UIImage *PlayerImage = [UIImage imageNamed:PlayerImageTitle];
    [self.PlayerImageOutlet setImage:PlayerImage];
    
    UIImage *ObstacleImage = [UIImage imageNamed:ObstacleImageTitle];
    [self.CentralButtonOutlet setImage:ObstacleImage forState:UIControlStateNormal];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Needs to send class info, levels and coins
    
    if ([[segue identifier] isEqualToString:@"ShowShop"]) {
        // Get destination
        ShopController *destination = [segue destinationViewController];
        
        // Get class integer and push it to the new view
        destination.ClassSelected = self.ClassSelected;
        destination.Coins = self.GameHandler.Coins;
    }
    
}

@end
