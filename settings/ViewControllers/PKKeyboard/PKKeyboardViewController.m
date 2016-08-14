//
//  PKKeyboardViewController.m
//  settings
//
//  Created by Atul M on 13/08/16.
//  Copyright © 2016 CARLOS CABANERO. All rights reserved.
//

#import "PKKeyboardViewController.h"
#import "PKKeyboardModifierViewController.h"

#define KEY_LABEL_TAG 1001
#define VALUE_LABEL_TAG 1002

@interface PKKeyboardViewController ()

@property (nonatomic, strong) NSIndexPath* currentSelectionIdx;
@property (nonatomic, strong) NSMutableArray *keyList;
@property (nonatomic, strong) NSMutableArray *modifierList;

@end

@implementation PKKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UICollection View Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _keyList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"keyMapperCell" forIndexPath:indexPath];
    
    UILabel *keyLabel = [cell viewWithTag:KEY_LABEL_TAG];
    keyLabel.text = [_keyList objectAtIndex:indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _currentSelectionIdx = indexPath;
}

- (IBAction)unwindFromKeyboardModifier:(UIStoryboardSegue *)sender{
    PKKeyboardModifierViewController *modifier = sender.sourceViewController;
    
}

@end
