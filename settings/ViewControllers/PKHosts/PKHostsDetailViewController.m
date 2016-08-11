//
//  HostsDetailViewController.m
//  Blink
//
//  Created by CARLOS CABANERO on 01/07/16.
//

#import "PKHostsDetailViewController.h"
#import "PKCardViewController.h"
#import "PKPredictionViewController.h"
#import "PKCard.h"
#import "PKHosts.h"

@interface PKHostsDetailViewController ()<UITextFieldDelegate>
- (IBAction)textFieldDidChange:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *hostKeyDetail;
@property (weak, nonatomic) IBOutlet UILabel *predictionDetail;
@property (weak, nonatomic) IBOutlet UITextField *hostField;
@property (weak, nonatomic) IBOutlet UITextField *hostNameField;
@property (weak, nonatomic) IBOutlet UITextField *sshPortField;
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *moshPortField;
@property (weak, nonatomic) IBOutlet UITextField *startUpCmdField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation PKHostsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.saveButton.enabled = NO;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
  // if ([[segue identifier] isEqualToString:@"predictionModeSegue"]) {
  //   UITableView *predictionMode = (UITableView *)segue.destinationViewController.view;
  //   [predictionMode setDelegate:self];
  // }
  if ([[segue identifier] isEqualToString:@"keysSegue"]) {
    // TODO: Name as "enableMarkOnSelect"
    PKCardViewController *keys = segue.destinationViewController;
    // The host understands the ID, because it is its domain, what it saves.
    [keys makeSelectable:YES initialSelection:self.hostKeyDetail.text];
  } else if([[segue identifier]isEqualToString:@"predictionModeSegue"]){
      PKPredictionViewController *prediction = segue.destinationViewController;
      [prediction performInitialSelection:_predictionDetail.text];
  }
}

- (IBAction)unwindFromKeys:(UIStoryboardSegue *)sender
{
  PKCardViewController * controller = sender.sourceViewController;
  PKCard *pk = [controller selectedObject];
  self.hostKeyDetail.text = pk.ID;
}

- (IBAction)unwindFromPrediction:(UIStoryboardSegue *)sender
{
    PKPredictionViewController * controller = sender.sourceViewController;
    self.predictionDetail.text = [controller selectedObject];
}

#pragma mark - Text field validations

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _hostField || textField == _hostNameField || textField == _userField) {
        if ([string isEqualToString:@" "]) {
            return NO;
        }
    }
    return YES;
}

- (IBAction)textFieldDidChange:(id)sender
{
    if(_hostField.text.length && _hostNameField.text.length && _userField.text.length){
        self.saveButton.enabled = YES;
    } else {
        self.saveButton.enabled = NO;
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    NSString *errorMsg;
    if ([identifier isEqualToString:@"unwindFromCreate"]) {
        if ([PKHosts withHost:_hostField.text]) {
            errorMsg = @"Cannot have two hosts with the same name.";
        } else if ([_hostField.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]].location != NSNotFound) {
            errorMsg = @"Spaces are not permitted in the host.";
        } else if ([_hostNameField.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]].location != NSNotFound) {
            errorMsg = @"Spaces are not permitted in the host name.";
        } else if ([_userField.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]].location != NSNotFound) {
            errorMsg = @"Spaces are not permitted in the User.";
        } else {
            _pkHost = [PKHosts saveHost:_hostField.text hostName:_hostNameField.text sshPort:_sshPortField.text user:_userField.text password:_passwordField.text hostKey:_hostKeyDetail.text moshPort:_moshPortField.text startUpCmd:_startUpCmdField.text prediction:_predictionDetail.text];
            if (!_pkHost) {
                errorMsg = @"Could not create new host.";
            }
        }
        if (errorMsg) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Hosts error" message:errorMsg preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
            
            return NO;
        }
        
    }
    
    return YES;
}

@end
