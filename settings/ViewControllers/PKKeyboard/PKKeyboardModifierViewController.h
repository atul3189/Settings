//
//  PKKeyboardModifierViewController.h
//  settings
//
//  Created by Atul M on 13/08/16.
//  Copyright © 2016 CARLOS CABANERO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKKeyboardModifierViewController : UITableViewController

- (void)performInitialSelection:(NSString *)selectedPrediction;
- (id)selectedObject;

@end
