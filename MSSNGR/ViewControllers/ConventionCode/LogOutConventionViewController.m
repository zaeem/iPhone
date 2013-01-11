//
//  LogOutConvention.m
//  MSSNGR
//
//  Created by uraan on 11/22/11.
//  Copyright 2011 Coeus Solutions. All rights reserved.
//

#import "LogOutConventionViewController.h"
#import "Singleton.h"
#import "User.h"
@implementation LogOutConventionViewController

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
    
}

-(IBAction)backButtonAction
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)LogOutConventionAction:(id)sender
{
	if (!mapper) {
        mapper = [[ConventionMapper alloc]init];
        mapper.target=self;
        [mapper checkOutConvention:[Singleton sharedSingleton].appUser.token Code:@""];
    }
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
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
    [LogOutConventionTextView release];
    LogOutConventionTextView = nil;
    [mapper release];
    mapper = nil;
    [super dealloc];
}
-(void)checkOutConventionSucceeded:(Result *)result{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)checkOutConventionFailed:(Result *)result{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
