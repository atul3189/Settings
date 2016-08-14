//
//  PKFontCreateViewController.m
//  settings
//
//  Created by Atul M on 14/08/16.
//  Copyright © 2016 CARLOS CABANERO. All rights reserved.
//

#import "PKFontCreateViewController.h"
#import "PKSettingsFileDownloader.h"

@interface PKFontCreateViewController ()
@property (weak, nonatomic) IBOutlet UIButton *importButton;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation PKFontCreateViewController

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

# pragma mark - Validations

- (IBAction)urlTextDidChange:(id)sender {
    NSURL *url = [NSURL URLWithString:_urlTextField.text];
    if (url && url.scheme && url.host){
        self.importButton.enabled = YES;
    } else {
        self.importButton.enabled = NO;
    }
    
}

- (IBAction)importButtonClicked:(id)sender{
    [PKSettingsFileDownloader downloadFileAtUrl:_urlTextField.text withCompletionHandler:^(NSString *filePath, NSError *error) {
        if(error == nil){
            [self downloadCompletedWithFilePath:filePath];
        } else {
            //Show alert
        }
    }];
}

- (void)downloadCompletedWithFilePath:(NSString*)filePath{
    self.importButton.enabled = NO;
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(didTapOnSave:)];
    [self.navigationItem setRightBarButtonItem:barButton];
}

- (IBAction)didTapOnSave:(id)sender{
    
}

@end
