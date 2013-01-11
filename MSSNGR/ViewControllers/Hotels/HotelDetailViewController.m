//
//  detailParticipatingHotels.m
//  MSSNGR
//
//  Created by uraan on 11/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HotelDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Utility.h"
@implementation HotelDetailViewController
@synthesize hotelObj;
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


-(IBAction)callHotelButtonAction:(id)sender
{
    [Utility showCallAlertBox:hotelObj.phone :self];
}

-(IBAction)goToWebsiteButtonAction:(id)sender
{
	NSString *url=self.hotelObj.website;
	NSURL *webURL = [NSURL URLWithString:url];
    [[UIApplication sharedApplication] openURL: webURL];
}

-(IBAction)mapButtonAction:(id)sender
{
    NSString *url = [Utility mapLink:hotelObj.name Lat:hotelObj.lat Lng:hotelObj.lng];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

-(IBAction)backButtonAction:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)nextButtonAction:(id)sender
{

}
-(void)viewWillAppear:(BOOL)animated{
}
-(void)viewDidAppear:(BOOL)animated{
    [Utility addHtml:self.hotelObj.description onWebView:participatingHotelsDetailWebView];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [Utility setNavigationBar:self addNextButton:NO addBackButton:YES addSearchButton:NO title:hotelObj.name];
    if (hotelObj.phone == nil || [hotelObj.phone isEqualToString:@""]) {
        btnCall.enabled = FALSE;
    }
    if (hotelObj.website == nil || [hotelObj.website isEqualToString:@""]) {
        btnWeb.enabled = FALSE;
    }
    if (!hotelObj.validCoordinates) {
        btnMap.enabled = FALSE;
    }
    self.title = hotelObj.name;
/*    if (hotelObj.lat == nil || hotelObj.lng == nil || hotelObj.lat == 0 || hotelObj.lng == 0) {
        btnMap.enabled = FALSE;
    }
 */
    backView.layer.borderWidth = 1.0f;
    backView.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    if (hotelObj.image != nil && ![hotelObj.image isEqualToString:@""]) {
        [asyncImage loadImageFromURLString:hotelObj.image];
    }else{
        [participatingHotelsDetailWebView setFrame:CGRectMake(0,44, 320,334)];
    }
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:NSLocalizedString(@"Call",@"Call")])
    {
        [self makeCall];
    }
}
-(void) makeCall{
    NSString *phone=[NSString stringWithFormat:@"tel:%@",[hotelObj.phone stringByReplacingOccurrencesOfString:@" " withString:@"-"]];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
}
-(IBAction)backButtonAction
{
	[self.navigationController popViewControllerAnimated:YES];
}
-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}
@end
