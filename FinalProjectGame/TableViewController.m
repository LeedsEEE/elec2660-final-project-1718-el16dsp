//
//  TableViewController.m
//  FinalProjectGame
//
//  Created by Daniel Piper [el16dsp] on 13/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "TableViewController.h"
#import "DataStore.h"
#import "PlayerClass.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"viewDidLoad from TableViewController called");
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.Data = [[DataStore alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSInteger PlayerClasses;
    NSLog(@"Making main menu sections...");
    
    PlayerClasses = self.Data.PlayerClassArray.count;
    
    NSLog(@"%@", [NSString stringWithFormat:@"%ld PlayerClasses loaded", PlayerClasses]);
    
    return PlayerClasses;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger NumberOfRows;
    NSLog(@"Making section %ld", section);
    if (section == 0) {
        NumberOfRows = 3;
    }
    
    return NumberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuButton" forIndexPath:indexPath];
    
    // Configure the cell...
    if (indexPath.section == 0) {
        PlayerClass *temp = [self.Data.PlayerClassArray objectAtIndex:indexPath.section];
        if (indexPath.row == 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"Play as %@", temp.Name];
        } else if (indexPath.row == 1) {
            cell.textLabel.text = [NSString stringWithFormat:@"Inspect %@", temp.Button1.Name];
        } else if (indexPath.row == 2) {
            cell.textLabel.text = [NSString stringWithFormat:@"Inspect %@", temp.Button2.Name];
        }
    }
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *cell;
    
    PlayerClass *temp = [self.Data.PlayerClassArray objectAtIndex:section];
    cell = temp.Name;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    // Taken and modified from the VLE
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"Row %ld pressed", indexPath.row);
    
    if ([[segue identifier] isEqualToString:@"ShowGame"]) {
        // Get destination
        ViewController *destination = [segue destinationViewController];
        
        // Show which class was selected
        NSLog(@"%@", [NSString stringWithFormat:@"Class %ld selected", indexPath.section]);
        
        // Get class integer and push it to the new view
        NSInteger TempClassIndex = indexPath.section;
        destination.ClassSelected = TempClassIndex;
        destination.RowSelected = indexPath.row;
    }
}

@end
