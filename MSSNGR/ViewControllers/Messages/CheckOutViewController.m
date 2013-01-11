//
//  CheckedOutCurrentHotel.m
//  MSSNGR
//
//  Created by uraan on 11/22/11.
//  Copyright 2011 Coeus Solutions. All rights reserved.
//

#import "CheckOutViewController.h"
#import "ParticipatingHotelsViewController.h"
#import "Helper.h"
#import "Utility.h"
@implementation CheckOutViewController


@synthesize p_id;
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

-(void)viewDidAppear:(BOOL)animated{
    NSString *text = @"If you would like to stop receiving news by MSSNGR please check out of this hotel.";
    [Utility addHtml:text onWebView:webView];
}
-(void)viewWillAppear:(BOOL)animated
{
	activityIndicator.hidden = YES;
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{	
    [super viewDidLoad];
    mapper = [[UserMapper alloc]init];
	mapper.target=self;
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


- (void)dealloc 
{
	[mapper release];
    [super dealloc];
}


-(IBAction)CheckedOutButtonAction:(id)sender
{
	[activityIndicator startAnimating];
    [mapper checkOut:[Singleton sharedSingleton].appUser.token :[Singleton sharedSingleton].checkedInHotel.Id];
    [[Singleton sharedSingleton] releaseCheckInHotel];
}

-(IBAction)cancelButtonAction:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}


- (void)checkOutUserSucceeded:(Result *)result
{
	[activityIndicator stopAnimating];
	ParticipatingHotelsViewController *controller = [[ParticipatingHotelsViewController alloc]init];
    controller.loadData=TRUE;
    controller.navigationItem.hidesBackButton = YES;
    [Singleton sharedSingleton].target = nil;
    controller.hidesBottomBarWhenPushed=TRUE;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}


- (void)checkOutUserFailed:(Result *)result
{
	[activityIndicator stopAnimating];
	ParticipatingHotelsViewController *controller = [[ParticipatingHotelsViewController alloc]init];
    controller.loadData=TRUE;
    controller.navigationItem.hidesBackButton = YES;
    [Singleton sharedSingleton].target = nil;
    [[Singleton sharedSingleton].hotelMessages removeAllObjects];
    controller.hidesBottomBarWhenPushed=TRUE;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}
-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}
@end
