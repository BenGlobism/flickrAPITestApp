//
//  SearchViewController.m
//  Globism
//
//  Created by Ben omer on 3/26/14.
//
//

#import "SearchViewController.h"
#import "GTAMasterViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

@synthesize vc, gestureRecognizer;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setTextColor:[UIColor lightGrayColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    [gestureRecognizer setCancelsTouchesInView:NO];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)hideKeyboard {

    [self.searchText resignFirstResponder];
    
}

-(void)keyboardWillShow:(NSNotification *)notification {
    [gestureRecognizer setCancelsTouchesInView:YES];
}

-(void)keyboardDidHide:(NSNotification *)notification {
    [gestureRecognizer setCancelsTouchesInView:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self hideKeyboard];
    self.searchText.text = nil;
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

- (void)dealloc {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}



#pragma mark - UITextFieldDelegate methods
- (BOOL) textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    [self startSearchWithText:self.searchText];

    return YES; 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate methods
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self startSearchWithText:self.searchText];
}

-(void)startSearchWithText:(UITextField *)textField
{
    if (![textField.text isEqualToString:@""]) {
        NSLog(@"checking");
        vc.queryText = textField.text;
        vc.reloadSwitch = @"yes";
        

    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Search Field Was Blank!" message:@"No results will be returned" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        vc.queryText = nil;
    }
    
    [vc deleteAllEntitiesForName:@"ImageSearchModel"];
    vc.fetchedResultsController = nil;
    
    
    [self.navigationController popDrawerViewController:YES];

}


@end
