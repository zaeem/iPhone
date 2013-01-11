//
//  ConventionCode.m
//  MSSNGR
//
//  Created by uraan on 11/22/11.
//  Copyright 2011 Coeus Solutions. All rights reserved.
//

#import "ConventionCodeViewController.h"
#import "Singleton.h"
#import "User.h"
#import "LogOutConventionViewController.h"
#import "Utility.h"
@implementation ConventionCodeViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

-(void)viewWillAppear:(BOOL)animated
{
    [ConventionIntroTextView setText:NSLocalizedString(@"If you participate in a meeting or convention at this hotel, please enter code below. Otherwise leave blank.",@"Convention Welcome Message")];
    [lblConventionCode setText:NSLocalizedString(@"Convention Code:",@"Convention Code")];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (!mapper) {
        mapper=[[ConventionMapper alloc]init];
        mapper.target=self;
    }
	[mapper joiningConvention:[Singleton sharedSingleton].appUser.token :ConventionCodeTextField.text];
	return YES;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
    [Utility setNavigationBar:self addNextButton:NO addBackButton:YES addSearchButton:NO title:NSLocalizedString(@"Conventions",@"")];
	lostConventionCodeTextView.hidden = YES;
	[ConventionCodeTextField becomeFirstResponder];
}

-(IBAction)backButtonAction
{
	[self.navigationController popViewControllerAnimated:YES];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [mapper release];
    [lostConventionCodeTextView release];
    [ConventionCodeTextField release];
    ConventionCodeTextField = nil;
    lostConventionCodeTextView = nil;
     mapper = nil;
    [super dealloc];
}

-(void)joiningConventionSucceeded:(Result *)result
{
    //UINavigationController *nav = self.navigationController;
    [self.navigationController popViewControllerAnimated:YES];
    //nav.tabBarController.selectedIndex=0;
}

-(void)joiningConventionFailed:(Result *)result
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Cannot recognize code. Please enter again!",@"Message vor invalid convention code") delegate:nil cancelButtonTitle:NSLocalizedString(@"Cancel",@"Cancel") otherButtonTitles:NSLocalizedString(@"Ok",@"Ok"),nil];
	[alertView show];
	[alertView release];
	
	lostConventionCodeTextView.hidden = NO;
}

@end
