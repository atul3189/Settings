////////////////////////////////////////////////////////////////////////////////
//
// B L I N K
//
// Copyright (C) 2016 Blink Mobile Shell Project
//
// This file is part of Blink.
//
// Blink is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Blink is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Blink. If not, see <http://www.gnu.org/licenses/>.
//
// In addition, Blink is also subject to certain additional terms under
// GNU GPL version 3 section 7.
//
// You should have received a copy of these additional terms immediately
// following the terms and conditions of the GNU General Public License
// which accompanied the Blink Source Code. If not, see
// <http://www.github.com/blinksh/blink>.
//
////////////////////////////////////////////////////////////////////////////////

#import <CommonCrypto/CommonDigest.h>

#import "PKCard.h"
#import "PKCardCreateViewController.h"
#import "PKCardDetailsViewController.h"
#import "PKCardViewController.h"


@interface PKCardViewController ()

@end

@implementation PKCardViewController {
  NSString *_clipboardPassphrase;
  SshRsa *_clipboardKey;
  BOOL _selectable;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _selectable ? PKCard.count + 1 : PKCard.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell;

  if (_selectable && indexPath.row == 0) {
    cell = [tableView dequeueReusableCellWithIdentifier:@"None" forIndexPath:indexPath];
  } else {
    NSInteger pkIdx = _selectable ? indexPath.row - 1 : indexPath.row;
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PKCard *pk = [PKCard.all objectAtIndex:pkIdx];

    // Configure the cell...
    cell.textLabel.text = pk.ID;
    cell.detailTextLabel.text = @"";
  }

  if( _selectable) {
    if (_currentSelectionIdx == indexPath) {
      [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
      [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
  }

  return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return _selectable ? UITableViewCellEditingStyleNone : UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    // Remove PKCard
    [PKCard.all removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:true];
    [PKCard saveIDS];
    [self.tableView reloadData];
  }
}

- (IBAction)addKey:(id)sender
{
  UIAlertController *keySourceController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
  UIAlertAction *generate = [UIAlertAction actionWithTitle:@"Create New"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *_Nonnull action) {
                                                     _clipboardKey = nil;
                                                     [self performSegueWithIdentifier:@"createKeySegue" sender:sender];
                                                   }];
  UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                   style:UIAlertActionStyleCancel
                                                 handler:^(UIAlertAction *_Nonnull action){
                                                   //
                                                 }];

  [keySourceController addAction:generate];
  [keySourceController addAction:cancel];
  [[keySourceController popoverPresentationController] setBarButtonItem:sender];
  [self presentViewController:keySourceController animated:YES completion:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
  if ([[segue identifier] isEqualToString:@"keyInfoSegue"]) {
    PKCardDetailsViewController *details = segue.destinationViewController;

    NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
    PKCard *pkcard = [PKCard.all objectAtIndex:indexPath.row];
    details.pkcard = pkcard;
    return;
  }
  if ([[segue identifier] isEqualToString:@"createKeySegue"]) {
    PKCardCreateViewController *create = segue.destinationViewController;

    if (_clipboardKey) {
      create.key = _clipboardKey;
      create.passphrase = _clipboardPassphrase;
    }

    return;
  }
}

- (IBAction)unwindFromCreate:(UIStoryboardSegue *)sender
{
  NSIndexPath *newIdx = [NSIndexPath indexPathForRow:(PKCard.count - 1) inSection:0];
  [self.tableView insertRowsAtIndexPaths:@[ newIdx ] withRowAnimation:UITableViewRowAnimationBottom];
}

- (IBAction)unwindFromDetails:(UIStoryboardSegue *)sender
{
  //NSIndexPath *selection = [self.tableView indexPathForSelectedRow];
  [self.tableView reloadRowsAtIndexPaths:@[ _currentSelectionIdx ] withRowAnimation:UITableViewRowAnimationNone];
}

// TODO: Maybe we should call it "markable", because the selection still exists and it is important.
#pragma mark - Selectable
- (void)makeSelectable:(BOOL)selectable initialSelection:(NSString *)selectionID
{
  _selectable = selectable;

  if (_selectable) {
    // Object as initial selection.
    // Guess the indexPath
    NSInteger pos;
    if (selectionID.length) {
      pos = [PKCard.all indexOfObject:[PKCard withID:selectionID]];
    } else {
      pos = 0;
    }
    _currentSelectionIdx = [NSIndexPath indexPathForRow:pos inSection:0];
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (_selectable && _currentSelectionIdx != nil) {
    // When in selectable mode, do not show details.
    [[tableView cellForRowAtIndexPath:_currentSelectionIdx] setAccessoryType:UITableViewCellAccessoryNone];
  }
  _currentSelectionIdx = indexPath;

  [tableView deselectRowAtIndexPath:indexPath animated:YES];  

  if (_selectable) {
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
  } else {
    // Show details if not selectable
    [self showKeyInfo:indexPath];
  }
}

- (id)selectedObject
{
  return _selectable ? PKCard.all[_currentSelectionIdx.row - 1] : PKCard.all[_currentSelectionIdx.row];
}

- (void)showKeyInfo:(NSIndexPath *)indexPath
{
  [self performSegueWithIdentifier:@"keyInfoSegue" sender:self];
}

@end
