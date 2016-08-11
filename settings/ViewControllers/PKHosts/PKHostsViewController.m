//
//  PKHostsViewController.m
//  settings
//
//  Created by Atul M on 11/08/16.
//  Copyright © 2016 CARLOS CABANERO. All rights reserved.
//

#import "PKHostsViewController.h"
#import "PKHosts.h"

@implementation PKHostsViewController

#pragma mark - UITable View delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return PKHosts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger pkIdx = indexPath.row;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    if(cell == nil)
//    {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//    }
    PKHosts *pk = [PKHosts.all objectAtIndex:pkIdx];
    
    // Configure the cell...
    cell.textLabel.text = pk.host;
    cell.detailTextLabel.text = @"";
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Remove PKCard
        [PKHosts.all removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:true];
        [PKHosts saveHosts];
        [self.tableView reloadData];
    }
}


#pragma mark - Navigation
- (IBAction)unwindFromCreate:(UIStoryboardSegue *)sender
{
    NSIndexPath *newIdx = [NSIndexPath indexPathForRow:(PKHosts.count - 1) inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[ newIdx ] withRowAnimation:UITableViewRowAnimationBottom];
}

@end
