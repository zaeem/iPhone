//
//  ConventionsViewController.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 12/14/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "ConventionsViewController.h"
#import "Singleton.h"
#import "ConventionCell.h"
#import <QuartzCore/QuartzCore.h>
#import "Utility.h"
@implementation ConventionsViewController
@synthesize conventions=_conventions,loader;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated
{
    [lblAdditionalCode setText:NSLocalizedString(@"Enter an additional convention code below!",@"Enter an additional convention code below!")];
    [lblConventionCode setText:NSLocalizedString(@"Convention Code:",@"Convention Code")];
    [btnSubmit setTitle:NSLocalizedString(@"Log into convention",@"Log into convention") forState:UIControlStateNormal];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //[textField resignFirstResponder];
    [self loginToConvention];
	return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [Utility setNavigationBar:self addNextButton:NO addBackButton:YES addSearchButton:NO title:NSLocalizedString(@"Conventions",@"Conventions")];
    backView.layer.borderWidth = 1.0f;
    backView.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(IBAction)backButtonAction
{
	[self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)dealloc {
    [mapper release];
    [ConventionCodeTextField release];
    ConventionCodeTextField = nil;
    mapper = nil;
    [super dealloc];
}

-(void)joiningConventionSucceeded:(Result *)result
{
    //UINavigationController *nav = self.navigationController;
    [self.navigationController popViewControllerAnimated:YES];
    //nav.tabBarController.selectedIndex=0;
    [loader stopAnimating];
}

-(void)joiningConventionFailed:(Result *)result
{
    [loader stopAnimating];
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Cannot recognize code. Please enter again!",@"Cannot recognize code") delegate:nil cancelButtonTitle:NSLocalizedString(@"Cancel",@"Cancel") otherButtonTitles:NSLocalizedString(@"Ok",@"OK"),nil];
	[alertView show];
	[alertView release];
}


/*- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)] autorelease];
    [headerView setBackgroundColor:[UIColor darkGrayColor]];
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10,2, tableView.bounds.size.width,22)] autorelease];
    label.text =NSLocalizedString(@"Your conventions",@"your conventions");
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label];
    return headerView;
}
*/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
	if(section==0)
	{
		return NSLocalizedString(@"Your conventions",@"Your conventions");
	}
	return @"";
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if (section==0) {
		return [_conventions count];	
	}
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.section==0)
	{
		ConventionCell *cell=(ConventionCell *)[tableView dequeueReusableCellWithIdentifier:@"ConventionCell"];
		if(cell==nil)
		{
			cell= [[[NSBundle mainBundle] loadNibNamed:@"ConventionCell" owner:self options:nil]objectAtIndex:0];	
			cell.parent=self;
		}
		Convention *convention=[_conventions objectAtIndex:indexPath.row];
		cell.convention=convention;
		cell.cell_Text.text=convention.title;
		return cell;
	}
	return nil;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField { //Keyboard becomes visible
    scrollView.frame = CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y, 
                                  scrollView.frame.size.width, scrollView.frame.size.height - 215 + 50); //resize
}
-(void)textFieldDidEndEditing:(UITextField *)textField { //keyboard will hide
    scrollView.frame = CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y,
                                  scrollView.frame.size.width, scrollView.frame.size.height + 215 - 50); //resize
}
-(IBAction)joinConvention:(id)sender{

}
-(void)loginToConvention{
    [loader startAnimating];
    if (!mapper) {
        mapper=[[ConventionMapper alloc]init];
        mapper.target=self;
    }
	[mapper joiningConvention:[Singleton sharedSingleton].appUser.token :ConventionCodeTextField.text];
}
@end
