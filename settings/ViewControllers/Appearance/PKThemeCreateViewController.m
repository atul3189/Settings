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
@property (strong, nonatomic) NSData *tempFileData;
@property (assign, nonatomic) BOOL downloadCompleted;
@end

@implementation PKThemeCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        [self performSegueWithIdentifier:@"unwindFromAddTheme" sender:self];
    }
    [super viewWillDisappear:animated];
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
    if (self.nameTextField.text.length > 0 && _downloadCompleted) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}


- (IBAction)importButtonClicked:(id)sender{
    if(_urlTextField.text.length > 4 && [[_urlTextField.text substringFromIndex:[_urlTextField.text length]-4]isEqualToString:@".css"]){
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        self.urlTextField.enabled = NO;
        self.importButton.enabled = NO;
        [PKSettingsFileDownloader downloadFileAtUrl:_urlTextField.text withCompletionHandler:^(NSData *fileData, NSError *error) {
            if(error == nil){
                [self performSelectorOnMainThread:@selector(downloadCompletedWithFilePath:) withObject:fileData waitUntilDone:NO];
            } else {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Network error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:ok];
                [self presentViewController:alertController animated:YES completion:nil];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                self.urlTextField.enabled = YES;
                self.importButton.enabled = YES;
            }
        }];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"URL error" message:@"Please enter valid .css URL" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)downloadCompletedWithFilePath:(NSData*)fileData{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.importButton.enabled = NO;
    _downloadCompleted = YES;
    _tempFileData = fileData;
    [self nameFieldDidChange:self.nameTextField];
}

- (IBAction)didTapOnSave:(id)sender{
    if([PKTheme withTheme:self.nameTextField.text]){
        //Error
    } else {        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *folderPath = [NSString stringWithFormat:@"%@/ThemesDir/",documentsDirectory];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@", folderPath,self.nameTextField.text];
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
        NSError *error;
        [_tempFileData writeToURL:[NSURL fileURLWithPath:filePath] options:NSDataWritingAtomic error:&error];
        [PKTheme saveTheme:self.nameTextField.text withFilePath:filePath];
        [PKTheme saveThemes];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
