//
//  PKThemeCreateViewController.m
//  settings
//
//  Created by Atul M on 14/08/16.
//  Copyright © 2016 CARLOS CABANERO. All rights reserved.
//

#import "PKThemeCreateViewController.h"
#import "PKSettingsFileDownloader.h"
#import "PKTheme.h"
@interface PKThemeCreateViewController ()
@property (weak, nonatomic) IBOutlet UIButton *importButton;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) NSString *tempFilePath;
@end

@implementation PKThemeCreateViewController

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

- (IBAction)nameFieldDidChange:(id)sender {
    if (self.nameTextField.text.length > 0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}


- (IBAction)importButtonClicked:(id)sender{
    [PKSettingsFileDownloader downloadFileAtUrl:_urlTextField.text withCompletionHandler:^(NSString *filePath, NSError *error) {
        if(error == nil){
            [self performSelectorOnMainThread:@selector(downloadCompletedWithFilePath:) withObject:filePath waitUntilDone:NO];
        } else {
            //Show alert
        }
    }];
}

- (void)downloadCompletedWithFilePath:(NSString*)filePath{
    self.importButton.enabled = NO;
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(didTapOnSave:)];
    [self.navigationItem setRightBarButtonItem:barButton];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (IBAction)didTapOnSave:(id)sender{
    if([PKTheme withTheme:self.nameTextField.text]){
        //Error
    } else {        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,self.nameTextField.text];
        [[NSFileManager defaultManager]copyItemAtURL:[NSURL URLWithString:_tempFilePath] toURL:[NSURL URLWithString:filePath] error:nil];
        [PKTheme saveTheme:self.nameTextField.text withFilePath:filePath];
        [PKTheme saveThemes];
    }
}
@end
