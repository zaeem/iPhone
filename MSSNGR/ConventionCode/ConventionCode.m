//
//  ConventionCode.m
//  MSSNGR
//
//  Created by uraan on 11/22/11.
//  Copyright 2011 Coeus Solutions. All rights reserved.
//

#import "ConventionCode.h"


@implementation ConventionCode

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
	self.navigationController.navigationBar.hidden=NO;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *butImage = [[UIImage imageNamed:@"back.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [button setBackgroundImage:butImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 48, 30);
    UIBarButtonItem *backButton = [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.title=@"Convention Code";
}

-(IBAction)backButtonAction
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Cannot recognize code. Please enter again" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok",nil];
	[alertView show];
	[alertView release];
	
	lostConventionCodeTextView.hidden = NO;
	return YES;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	lostConventionCodeTextView.hidden = YES;
	[ConventionCodeTextField becomeFirstResponder];
	
	
	appDel = [[UIApplication sharedApplication]delegate];
	mapper=[[ConventionMapper alloc]init];
	mapper.target=self;
    [mapper showUserConvention:appDel.userToken];
	
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
    [super dealloc];
}


- (void)getConventionSucceeded:(Result *)result
{
	[result retain];
	NSLog(@"Result %@",result);
	[result release];
}


- (void)getConventionFailed:(Result *)result
{
	NSLog(@"getConventionFailed ");
}

@end
