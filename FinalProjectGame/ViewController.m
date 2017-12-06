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
#import "ObstacleClass.h"
#define HEALTH_COLOUR_CHANGE_LIMIT 0.40
#define MODULE @"ELEC2660"
#define GET_CURRENT_OBSTACLE [self.GameHandler.ObstacleArray objectAtIndex:self.GameHandler.CurrentObstacle]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ViewController Loaded");
    self.GameHandler = [[GameController alloc] init];
    NSLog(@"Class %ld selected in ViewController", self.ClassSelected);
    NSLog(@"GameHandler loaded");
    
    if (self.ClassSelected >= 0) {
        self.GameHandler.Player = [[[DataStore alloc] init].PlayerClassArray objectAtIndex:self.ClassSelected];
    }
    
    self.ShopButton1Outlet.hidden = YES;
    self.ShopButton2Outlet.hidden = YES;
    
    if (self.RowSelected == 0 && self.ClassSelected >= 0) {
        NSLog(@"Game selected");
        NSLog(@"Class %ld %@ loaded with %@ and %@", self.ClassSelected, [self.GameHandler GetPlayerName], [self.GameHandler GetWeapon1Name], [self.GameHandler GetWeapon2Name]);
        // Hide instructions
        self.TextViewOutlet.hidden = YES;
        // Hide inspect stuff
        self.ClassNameLabelOutlet.hidden = YES;
        self.WeaponImageOutlet.hidden = YES;
        self.ImageBackgroundOutlet.hidden = YES;
        self.DescriptionLabelOutlet.hidden = YES;
        self.LevelLabelOutlet.hidden = YES;
        self.DamageLabelOutlet.hidden = YES;
        self.ClicksPerClipLabelOutlet.hidden = YES;
        self.StunDurationLabelOutlet.hidden = YES;
        self.AutoClickRateLabelOutlet.hidden = YES;
        self.WeaponNameLabelOutlet.hidden = YES;
        self.CostLabel.hidden = YES;
        
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
        
        self.Button1Outlet.enabled = YES;
        self.Button2Outlet.enabled = YES;
        self.CentralButtonOutlet.enabled = YES;
        
        // Add button images/frames
        NSString *HealthProportion = [NSString stringWithFormat:@"%ld/%ld", self.GameHandler.Player.CurrentHealth, self.GameHandler.Player.MaxHealth];
        NSString *Button1Proportion = [NSString stringWithFormat:@"%ld/%ld", self.GameHandler.Player.Button1.ClickAmount, self.GameHandler.Player.Button1.ClicksPerClip];
        NSString *Button2Proportion = [NSString stringWithFormat:@"%ld/%ld", self.GameHandler.Player.Button2.ClickAmount, self.GameHandler.Player.Button2.ClicksPerClip];
        [self.Button1Outlet setTitle:[NSString stringWithFormat:@"Load %@", [self.GameHandler GetWeapon1Name]] forState:UIControlStateNormal];
        [self.Button2Outlet setTitle:[NSString stringWithFormat:@"Load %@", [self.GameHandler GetWeapon2Name]] forState:UIControlStateNormal];
        [self UpdateLabelSize:HealthProportion
                             :Button1Proportion
                             :Button2Proportion
                             :@"Coins: 000"];
        [self UpdateLabelText:HealthProportion
                             :Button1Proportion
                             :Button2Proportion
                             :@"Coins: 000"];
        if ([[self.GameHandler GetObstacleName] isEqualToString:@"Enemy"]) {
            // Could be idle or pre_attack or attack
            if ([GET_CURRENT_OBSTACLE GetClickAmount] == ([GET_CURRENT_OBSTACLE GetMaxClicks] - [GET_CURRENT_OBSTACLE GetAutoClicks])) {
                [self UpdateImages:[NSString stringWithFormat:@"%@_idle.png", self.GameHandler.Player.ImageBasis]
                                  :@"enemy_attack.png"];
            } else if ([GET_CURRENT_OBSTACLE GetClickAmount] == ([GET_CURRENT_OBSTACLE GetMaxClicks] - (2 * [GET_CURRENT_OBSTACLE GetAutoClicks]))) {
                [self UpdateImages:[NSString stringWithFormat:@"%@_idle.png", self.GameHandler.Player.ImageBasis]
                                  :@"enemy_pre_attack.png"];
            } else {
                [self UpdateImages:[NSString stringWithFormat:@"%@_idle.png", self.GameHandler.Player.ImageBasis]
                                  :@"enemy_idle.png"];
            }
        } else if ([[self.GameHandler GetObstacleName] isEqualToString:@"Chest"]){
            [self UpdateImages:[NSString stringWithFormat:@"%@_idle.png", self.GameHandler.Player.ImageBasis]
                              :@"chest_idle.png"];
        } else {
            [self UpdateImages:[NSString stringWithFormat:@"%@_idle.png", self.GameHandler.Player.ImageBasis]
                              :@"door_idle.png"];
        }
        NSLog(@"/// GAME LOADED \\\\\\");
    }
    else if (self.RowSelected == 1 && self.ClassSelected >= 0) {
        NSLog(@"Inspect button 1");
        NSString *ImageName = @"placeholder.png";
        // Hide instructions
        self.TextViewOutlet.hidden = YES;
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
        self.ClassNameLabelOutlet.hidden = NO;
        self.WeaponImageOutlet.hidden = NO;
        self.ImageBackgroundOutlet.hidden = NO;
        self.DescriptionLabelOutlet.hidden = NO;
        self.LevelLabelOutlet.hidden = NO;
        self.DamageLabelOutlet.hidden = NO;
        self.ClicksPerClipLabelOutlet.hidden = NO;
        self.StunDurationLabelOutlet.hidden = NO;
        self.AutoClickRateLabelOutlet.hidden = NO;
        self.WeaponNameLabelOutlet.hidden = NO;
        self.CostLabel.hidden = NO;
        
        // Set labels and images
        self.ClassNameLabelOutlet.text = [NSString stringWithFormat:@"Class: %@", [self.GameHandler GetPlayerName]];
        self.DescriptionLabelOutlet.text = self.GameHandler.Player.Button1.Description;
        self.LevelLabelOutlet.text = [NSString stringWithFormat:@"Level: %ld", self.GameHandler.Player.Button1.Level];
        self.DamageLabelOutlet.text = [NSString stringWithFormat:@"Damage: %ld", self.GameHandler.Player.Button1.DamagePerClick];
        // IF type is 'A', display activation limit
        // ELSE IF type is 'W', display capacity
        if ([[self.GameHandler GetWeapon1Type] isEqualToString:@"A"]) {
            self.ClicksPerClipLabelOutlet.text = [NSString stringWithFormat:@"Activation limit: %ld", self.GameHandler.Player.Button1.ClicksPerClip];
        } else if ([[self.GameHandler GetWeapon1Type] isEqualToString:@"W"]) {
            self.ClicksPerClipLabelOutlet.text = [NSString stringWithFormat:@"Capacity: %ld", self.GameHandler.Player.Button1.ClicksPerClip];
        }
        self.StunDurationLabelOutlet.text = [NSString stringWithFormat:@"Stun Duration: %ld", self.GameHandler.Player.Button1.StunDuration];
        self.AutoClickRateLabelOutlet.text = [NSString stringWithFormat:@"Auto Load Rate: %ld", self.GameHandler.Player.Button1.AutoClickLoadRate];
        self.CostLabel.text = [NSString stringWithFormat:@"Next upgrade needs %ld coins", self.Cost];
        ImageName = self.GameHandler.Player.Button1.ImageName;
        [self.WeaponImageOutlet setImage:[UIImage imageNamed:ImageName]];
        self.WeaponNameLabelOutlet.text = self.GameHandler.Player.Button1.Name;
        // TODO Add weapon images (pistol.png and blowtorch.png)
    }
    else if (self.RowSelected == 2 && self.ClassSelected >= 0) {
        NSLog(@"Inspect button 2");
        NSString *ImageName = @"placeholder.png";
        // Hide instructions
        self.TextViewOutlet.hidden = YES;
        
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
        self.ClassNameLabelOutlet.hidden = NO;
        self.WeaponImageOutlet.hidden = NO;
        self.ImageBackgroundOutlet.hidden = NO;
        self.DescriptionLabelOutlet.hidden = NO;
        self.LevelLabelOutlet.hidden = NO;
        self.DamageLabelOutlet.hidden = NO;
        self.ClicksPerClipLabelOutlet.hidden = NO;
        self.StunDurationLabelOutlet.hidden = NO;
        self.AutoClickRateLabelOutlet.hidden = NO;
        self.WeaponNameLabelOutlet.hidden = NO;
        self.CostLabel.hidden = NO;
        
        // Set labels and images
        self.ClassNameLabelOutlet.text = [NSString stringWithFormat:@"Class: %@", [self.GameHandler GetPlayerName]];
        self.DescriptionLabelOutlet.text = self.GameHandler.Player.Button2.Description;
        self.LevelLabelOutlet.text = [NSString stringWithFormat:@"Level: %ld", self.GameHandler.Player.Button2.Level];
        self.DamageLabelOutlet.text = [NSString stringWithFormat:@"Damage: %ld", self.GameHandler.Player.Button2.DamagePerClick];
        // IF type is 'A', display activation limit
        // ELSE IF type is 'W', display capacity
        if ([[self.GameHandler GetWeapon2Type] isEqualToString:@"A"]) {
            self.ClicksPerClipLabelOutlet.text = [NSString stringWithFormat:@"Activation limit: %ld", self.GameHandler.Player.Button2.ClicksPerClip];
        } else if ([[self.GameHandler GetWeapon2Type] isEqualToString:@"W"]) {
            self.ClicksPerClipLabelOutlet.text = [NSString stringWithFormat:@"Capacity: %ld", self.GameHandler.Player.Button2.ClicksPerClip];
        }
        self.StunDurationLabelOutlet.text = [NSString stringWithFormat:@"Stun Duration: %ld", self.GameHandler.Player.Button2.StunDuration];
        self.AutoClickRateLabelOutlet.text = [NSString stringWithFormat:@"Auto Load Rate: %ld", self.GameHandler.Player.Button2.AutoClickLoadRate];
        self.CostLabel.text = [NSString stringWithFormat:@"Next upgrade needs %ld coins", self.Cost];
        ImageName = self.GameHandler.Player.Button2.ImageName;
        [self.WeaponImageOutlet setImage:[UIImage imageNamed:ImageName]];
        self.WeaponNameLabelOutlet.text = self.GameHandler.Player.Button2.Name;
    } else if (self.ClassSelected == -1) {
        // Instructions selected
        self.TextViewOutlet.hidden = NO;
        
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
        
        // Hide inspect stuff
        self.ClassNameLabelOutlet.hidden = YES;
        self.WeaponImageOutlet.hidden = YES;
        self.ImageBackgroundOutlet.hidden = YES;
        self.DescriptionLabelOutlet.hidden = YES;
        self.LevelLabelOutlet.hidden = YES;
        self.DamageLabelOutlet.hidden = YES;
        self.ClicksPerClipLabelOutlet.hidden = YES;
        self.StunDurationLabelOutlet.hidden = YES;
        self.AutoClickRateLabelOutlet.hidden = YES;
        self.WeaponNameLabelOutlet.hidden = YES;
        self.CostLabel.hidden = YES;
        
        // Need to get instruction text
        NSString *InstructionText = @"Breach doors, break chests and defeat imperial soldiers as you play as a pirate on a boarding mission. Play until your pirate is relieved of service, use the coins gathered on the run to upgrade the class weapons and pick another to continue the run with the new levels.\n\nEach pirate class has a unique play style brought by unique weapons and abilities. View these in the 'Inspect ...' and use them in the corresponding 'Play as ...'\n\nWhen boarding a ship, you can load your weapons and abilities or attack the obstacle. Read your enemies and use the moment effectively by pressing the button of your choice. Stun enemies to gain some peace in the midst of combat and attack them in the right moments.";
        // Will use the inspection view for the labels
        self.TextViewOutlet.text = InstructionText;
    }
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
    
    [self CheckIfDead:ReturnValues];
}

- (IBAction)Button2Pressed:(id)sender {
    NSLog(@"Button 2 pressed");
    
    NSMutableArray *ReturnValues = [NSMutableArray arrayWithCapacity:3];
    
    ReturnValues = [self.GameHandler OnButton2Click];
    // Start events on any button press
    // Load weapon if type is a weapon
    // Charge (and fire) if type is an ability
    NSLog(@"HealthLabel %@ Button1Label %@ Button2Label %@", [ReturnValues objectAtIndex:0], [ReturnValues objectAtIndex:1], [ReturnValues objectAtIndex:2]);
    
    [self CheckIfDead:ReturnValues];
}

- (IBAction)CentralButtonPressed:(id)sender {
    NSLog(@"Central button pressed");
    
    NSMutableArray *ReturnValues = [NSMutableArray arrayWithCapacity:3];
    
    ReturnValues = [self.GameHandler OnObstacleClick];
    // Start events on any button press
    // Do damage from weapons
    NSLog(@"HealthLabel %@ Button1Label %@ Button2Label %@", [ReturnValues objectAtIndex:0], [ReturnValues objectAtIndex:1], [ReturnValues objectAtIndex:2]);
    
    [self CheckIfDead:ReturnValues];
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
    CGFloat ScreenHeight = CGRectGetHeight(Screen);
    // Status bar information from https://stackoverflow.com/questions/3888517/get-iphone-status-bar-height on 30-NOV-2017
    CGRect StatusBar = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat BarOffset = self.navigationController.navigationBar.frame.size.height + StatusBar.size.height;
    NSLog(@"Update labels called with width %f and height %f", ScreenWidth, ScreenHeight);
    
    // Pull integers from the strings and find the ratio betwen them
    float HealthLabelProportion = [self CalcRatio:HealthLabel];
    float Button1LabelProportion = [self CalcRatio:Button1Label];
    float Button2LabelProportion = [self CalcRatio:Button2Label];
    
    NSLog(@"Health proportion is %f", HealthLabelProportion);
    NSLog(@"Button 1 proportion is %f", Button1LabelProportion);
    NSLog(@"Button 2 proportion is %f", Button2LabelProportion);
    
    // Update label frames
    
    // HEALTH LABEL
    // Taken from https://stackoverflow.com/questions/13306604/how-to-change-the-width-of-label-once-after-its-frame-has-been-set-and-to-get-t on 2017-NOV-15
    CGRect HealthLabelFrame = [self.HealthLabelOutlet frame];
    HealthLabelFrame.size.width = HealthLabelProportion * ScreenWidth;
    HealthLabelFrame.size.height = 30;
    NSLog(@"New Health width %f", HealthLabelFrame.size.width);
    HealthLabelFrame.origin.x = ((1.0 - HealthLabelProportion) * ScreenWidth)/2.0;
    // Taken from https://stackoverflow.com/questions/20160933/what-is-the-height-of-navigation-bar-in-ios-7 on 30-NOV-2017
    HealthLabelFrame.origin.y = BarOffset + 30;
    
    // Draw box behind label
    // Taken from https://stackoverflow.com/questions/14785188/drawing-rectangles-in-ios on 30-NOV-2017
    [self.HealthBox removeFromSuperview];
    self.HealthBox = [[UIView alloc] initWithFrame:HealthLabelFrame];
    if (HealthLabelProportion < HEALTH_COLOUR_CHANGE_LIMIT) {
        NSLog(@"Health label red");
        [self.HealthBox setBackgroundColor:[UIColor redColor]];
    } else {
        NSLog(@"Health label green");
        [self.HealthBox setBackgroundColor:[UIColor greenColor]];
    }
    [self.view addSubview:self.HealthBox];
    [self.view bringSubviewToFront:self.HealthLabelOutlet];
    
    // BUTTON 1 LABEL
    [self.Button1Box removeFromSuperview];
    CGRect Button1LabelFrame = [self.Button1LabelOutlet frame];
    Button1LabelFrame.size.width = 0.5 * Button1LabelProportion * ScreenWidth;
    Button1LabelFrame.size.height = 30;
    Button1LabelFrame.origin.x = self.Button1LabelOutlet.frame.origin.x;
    if (self.Button1LabelOutlet.frame.origin.y == 0) {
        NSString *DeviceName = [[UIDevice currentDevice] model]; // Taken from https://stackoverflow.com/questions/11197509/how-to-get-device-make-and-model-on-ios on 1-DEC-2017
        NSLog(@"Device is %@", DeviceName);
        if ([DeviceName isEqualToString:@"iPhone"]) {
            Button1LabelFrame.origin.y = 606; // For iPhone 6s+ although the simulator seems to convert this for each device's aspect ratios
        }
    } else {
        Button1LabelFrame.origin.y = self.Button1LabelOutlet.frame.origin.y;
    }
    NSLog(@"New Button1 width %f", Button1LabelFrame.size.width);
    self.Button1Box = [[UIView alloc] initWithFrame:Button1LabelFrame];
    if ([[self.GameHandler GetWeapon1Type] isEqualToString:@"W"] && [[[Button1Label componentsSeparatedByString:@"/"] objectAtIndex:0] intValue] == 0) {
        // Green if ammo remaining
        // Red if can't shoot
        NSLog(@"Button1 label red weapon");
        [self.Button1Box setBackgroundColor:[UIColor redColor]];
    } else if ([[self.GameHandler GetWeapon1Type] isEqualToString:@"W"]) {
        NSLog(@"Button1 label green weapon");
        [self.Button1Box setBackgroundColor:[UIColor greenColor]];
    } else if ([[self.GameHandler GetWeapon1Type] isEqualToString:@"A"] && Button1LabelProportion == 1.0) {
        // Green if can shoot (at full charge)
        // Red if can't
        NSLog(@"Button1 label green ability");
        [self.Button1Box setBackgroundColor:[UIColor greenColor]];
    } else if ([[self.GameHandler GetWeapon1Type] isEqualToString:@"A"]) {
        NSLog(@"Button1 label red ability");
        [self.Button1Box setBackgroundColor:[UIColor redColor]];
    }
    [self.view addSubview:self.Button1Box];
    [self.view bringSubviewToFront:self.Button1LabelOutlet];
    
    // BUTTON 2 LABEL
    [self.Button2Box removeFromSuperview];
    CGRect Button2LabelFrame = [self.Button2LabelOutlet frame];
    Button2LabelFrame.size.width = 0.5 * Button2LabelProportion * ScreenWidth;
    Button2LabelFrame.size.height = 30;
    Button2LabelFrame.origin.x = ScreenWidth - 0.5 * Button2LabelProportion * ScreenWidth;
    if (self.Button2LabelOutlet.frame.origin.y == 0) {
        NSString *DeviceName = [[UIDevice currentDevice] model];
        NSLog(@"Device is %@", DeviceName);
        if ([DeviceName isEqualToString:@"iPhone"]) {
            Button2LabelFrame.origin.y = 606; // For iPhone 6s+ although the simulator seems to convert this for each device's aspect ratios
        }
    } else {
        Button2LabelFrame.origin.y = self.Button2LabelOutlet.frame.origin.y;
    }
    NSLog(@"New Button2 width %f", Button2LabelFrame.size.width);
    self.Button2Box = [[UIView alloc] initWithFrame:Button2LabelFrame];
    if ([[self.GameHandler GetWeapon2Type] isEqualToString:@"W"] && [[[Button2Label componentsSeparatedByString:@"/"] objectAtIndex:0] intValue] == 0) {
        // Green if ammo remaining
        // Red if can't shoot
        NSLog(@"Button2 label red weapon");
        [self.Button2Box setBackgroundColor:[UIColor redColor]];
    } else if ([[self.GameHandler GetWeapon2Type] isEqualToString:@"W"]) {
        NSLog(@"Button2 label green weapon");
        [self.Button2Box setBackgroundColor:[UIColor greenColor]];
    } else if ([[self.GameHandler GetWeapon2Type] isEqualToString:@"A"] && Button2LabelProportion == 1.0) {
        // Green if can shoot (at full charge)
        // Red if can't
        NSLog(@"Button2 label green ability");
        [self.Button2Box setBackgroundColor:[UIColor greenColor]];
    } else if ([[self.GameHandler GetWeapon2Type] isEqualToString:@"A"]) {
        NSLog(@"Button2 label red ability");
        [self.Button2Box setBackgroundColor:[UIColor redColor]];
    }
    [self.view addSubview:self.Button2Box];
    [self.view bringSubviewToFront:self.Button2LabelOutlet];

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

- (IBAction)ShopButton1Action:(id)sender {
    // Call the method in GameController to spend the monies
    self.CoinsLabelOutlet.text = [self.GameHandler OnShop1Click];
    [self.GameHandler AssignWeapon1Cost:self.ClassSelected];
    [self.ShopButton1Outlet setTitle:[NSString stringWithFormat:@"Upgrade %@ to level %ld for %ld coins", self.GameHandler.Player.Button1.Name, self.GameHandler.Player.Button1.Level + 1, self.GameHandler.Cost1] forState:UIControlStateNormal];
}

- (IBAction)ShopButton2Action:(id)sender {
    // Call the method in GameController to spend the monies
    self.CoinsLabelOutlet.text = [self.GameHandler OnShop2Click];
    [self.GameHandler AssignWeapon2Cost:self.ClassSelected];
    [self.ShopButton2Outlet setTitle:[NSString stringWithFormat:@"Upgrade %@ to level %ld for %ld coins", self.GameHandler.Player.Button2.Name, self.GameHandler.Player.Button2.Level + 1, self.GameHandler.Cost2] forState:UIControlStateNormal];
}

-(void) CheckIfDead:(NSMutableArray *)ReturnValues {
    // View Controller's equivalent of OnEndTick
    
    NSInteger HealthNumerator = [[[[ReturnValues objectAtIndex:0] componentsSeparatedByString:@"/"] objectAtIndex:0] intValue];
    
    if (HealthNumerator > 0) {
        // If player not dead
        [self UpdateLabelText:[ReturnValues objectAtIndex:0] :[ReturnValues objectAtIndex:1] :[ReturnValues objectAtIndex:2] :[ReturnValues objectAtIndex:3]];
        [self UpdateLabelSize:[ReturnValues objectAtIndex:0] :[ReturnValues objectAtIndex:1] :[ReturnValues objectAtIndex:2] :[ReturnValues objectAtIndex:3]];
        [self UpdateImages:[ReturnValues objectAtIndex:4] :[ReturnValues objectAtIndex:5]];
    } else {
        // Player is dead
        
        self.GameHandler.ClassSelected = self.ClassSelected;
        [self.GameHandler AssignWeapon1Cost:self.ClassSelected];
        [self.GameHandler AssignWeapon2Cost:self.ClassSelected];
        
        self.Button1Outlet.enabled = NO;
        self.Button2Outlet.enabled = NO;
        self.CentralButtonOutlet.enabled = NO;
        
        [self.ShopButton1Outlet setTitle:[NSString stringWithFormat:@"Upgrade %@ to level %ld for %ld coins", self.GameHandler.Player.Button1.Name, self.GameHandler.Player.Button1.Level + 1, self.GameHandler.Cost1] forState:UIControlStateNormal];
        [self.ShopButton2Outlet setTitle:[NSString stringWithFormat:@"Upgrade %@ to level %ld for %ld coins", self.GameHandler.Player.Button2.Name, self.GameHandler.Player.Button2.Level + 1, self.GameHandler.Cost2] forState:UIControlStateNormal];
        
        self.ShopButton1Outlet.hidden = NO;
        self.ShopButton2Outlet.hidden = NO;
        //[self performSegueWithIdentifier:@"ShowShop" sender:self];
    }
}

@end

