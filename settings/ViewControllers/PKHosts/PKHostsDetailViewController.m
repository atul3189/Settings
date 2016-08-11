//
//  HostsDetailViewController.m
//  Blink
//
//  Created by CARLOS CABANERO on 01/07/16.
//

#import "PKHostsDetailViewController.h"
#import "PKCardViewController.h"
#import "PKCard.h"

@interface PKHostsDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *hostKeyDetail;
@end

@implementation PKHostsDetailViewController

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
  }
}

- (IBAction)unwindFromKeys:(UIStoryboardSegue *)sender {
  PKCardViewController * controller = sender.sourceViewController;
  PKCard *pk = [controller selectedObject];
  self.hostKeyDetail.text = pk.ID;
  
}

@end
