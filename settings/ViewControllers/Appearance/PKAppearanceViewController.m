//
//  PKAppearanceViewController.m
//  settings
//
//  Created by Atul M on 14/08/16.
//  Copyright © 2016 CARLOS CABANERO. All rights reserved.
//

#import "PKAppearanceViewController.h"
#import "PKTheme.h"
#import "PKFont.h"

#define FONT_SIZE_FIELD_TAG 2001

@interface PKAppearanceViewController ()

@end

@implementation PKAppearanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [[PKTheme all]count]+1;
    } else if(section == 1){
        return [[PKFont all]count]+1;
    } else {
        return 1;
    }
}

- (void)setFontsUIForCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath{
    if(indexPath.row == [[PKFont all]count]){
        cell.textLabel.text = @"Add a new font";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.textLabel.text = [[[PKFont all]objectAtIndex:indexPath.row]name];
    }
}

- (void)setThemesUIForCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath{
    if(indexPath.row == [[PKTheme all]count]){
        cell.textLabel.text = @"Add a new theme";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.textLabel.text = [[[PKTheme all]objectAtIndex:indexPath.row]name];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0 || indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"themeFontCell" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            [self setThemesUIForCell:cell atIndexPath:indexPath];
        } else {
            [self setFontsUIForCell:cell atIndexPath:indexPath];
        }
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fontSizeCell" forIndexPath:indexPath];
        UITextField *fontSizeField = [cell viewWithTag:FONT_SIZE_FIELD_TAG];
        fontSizeField.text = @"10px";
        return cell;
    }
    // Configure the cell...
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == [[PKTheme all]count]){
            [self performSegueWithIdentifier:@"addTheme" sender:self];
        }
    } else if (indexPath.section == 1){
        if(indexPath.row == [[PKFont all]count]){
            [self performSegueWithIdentifier:@"addFont" sender:self];
        }
    }
    
}

- (IBAction)unwindFromAddFont:(UIStoryboardSegue *)sender{
    NSIndexPath *newIdx = [NSIndexPath indexPathForRow:(PKFont.count - 1) inSection:1];
    if([[PKFont all]count] > newIdx.row){
        [self.tableView insertRowsAtIndexPaths:@[ newIdx ] withRowAnimation:UITableViewRowAnimationBottom];
    }
}

- (IBAction)unwindFromAddTheme:(UIStoryboardSegue *)sender{
    NSIndexPath *newIdx = [NSIndexPath indexPathForRow:(PKTheme.count - 1) inSection:0];
    if([[PKTheme all]count] > newIdx.row){
        [self.tableView insertRowsAtIndexPaths:@[ newIdx ] withRowAnimation:UITableViewRowAnimationBottom];
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
