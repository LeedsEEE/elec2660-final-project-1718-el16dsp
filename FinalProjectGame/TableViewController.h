//
//  TableViewController.h
//  FinalProjectGame
//
//  Created by Daniel Piper [el16dsp] on 13/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStore.h"
#import "ViewController.h"

@interface TableViewController : UITableViewController

@property (strong, nonatomic) DataStore *Data;

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section; // Taken from https://stackoverflow.com/questions/5752930/how-to-set-group-tables-section-header-text on 2017-NOV-14

@end
