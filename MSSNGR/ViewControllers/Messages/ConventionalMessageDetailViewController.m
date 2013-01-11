//
//  ConventionalMessageDetails112.m
//  MSSNGR
//
//  Created by uraan on 11/23/11.
//  Copyright 2011 Coeus Solutions. All rights reserved.
//

#import "ConventionalMessageDetailViewController.h"
#import "MSSNMessage.h"
#import "SearchViewController500.h"
#import <QuartzCore/QuartzCore.h>
#import "Helper.h"
#import "Utility.h"
@implementation ConventionalMessageDetailViewController
@synthesize message=_message;
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
    [Utility addHtml:_message.text onWebView:webView];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [Utility setNavigationBar:self addNextButton:NO addBackButton:YES addSearchButton:YES title:_message.title];
    self.title = _message.title;
    lblNoBookingPossible.text = NSLocalizedString(@"No booking possible via this app.",@"No booking possible via this app.");
    backView.layer.borderWidth = 1.0f;
    backView.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    if (_message.phone == nil || [_message.phone isEqualToString:@""]) {
        btnCall.enabled = FALSE;
    }
    if (_message.website == nil || [_message.website isEqualToString:@""]) {
        btnWeb.enabled = FALSE;
    }
    if (!_message.validCoordinates) {
        btnMap.enabled = FALSE;
    }
/*    if (_message.lat == nil || _message.lng == nil || [_message.lat floatValue]==0 || [_message.lng floatValue]==0) {
        btnMap.enabled = FALSE;
    }
 */
    if (_message.image != nil && ![_message.image isEqualToString:@""]) {
        [asyncImage loadImageFromURLString:_message.image];
    }else{
        [contentView setFrame:CGRectMake(0,44, 320, 275)];
    }
    btnMark.hidden = _message.favouriteMarked;
    btnUnMark.hidden = !_message.favouriteMarked;
    lblTime.text = [_message getMessageTimeFormattedString];
}

-(IBAction)backButtonAction
{
	[self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)searchButtonAction
{
	SearchViewController500 *searchObject = [[SearchViewController500 alloc] initWithNibName:@"SearchViewController500" bundle:nil];
	searchObject.hidesBottomBarWhenPushed=TRUE;
    [self.navigationController pushViewController:searchObject animated:YES];
	[searchObject release];
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

-(IBAction)callHotelButtonAction:(id)sender
{
    [Utility showCallAlertBox:_message.phone :self];
}

-(IBAction)goToWebsiteButtonAction:(id)sender
{
	NSString *url=_message.website;
	NSURL *webURL = [NSURL URLWithString:url];
    [[UIApplication sharedApplication] openURL: webURL];
}

-(IBAction)mapButtonAction:(id)sender
{
    
	NSString *url = [Utility mapLink:_message.title Lat:_message.lat Lng:_message.lng];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
-(IBAction)markClicked:(id)sender{
    NSMutableArray *starIds = [Helper readStarMessages];
    [starIds retain];
    Boolean alreadyAdded=FALSE;
    for(NSString *messageId in starIds){
        if ([messageId intValue] == [_message.Id intValue]) {
            alreadyAdded = TRUE;
            break;
        }
    }
    if (!alreadyAdded) {
        [starIds addObject:_message.Id];
        [Helper writeMessagesToDisk:starIds];
        [[Singleton sharedSingleton] resetStarMessages];
        _message.favouriteMarked = TRUE;
        btnMark.hidden = _message.favouriteMarked;
        btnUnMark.hidden = !_message.favouriteMarked;
    }
    [starIds release];
}
-(IBAction)unMarkClicked:(id)sender{
    NSMutableArray *starIds = [Helper readStarMessages];
    [starIds retain];
    [starIds removeObject:_message.Id];
    [Helper writeMessagesToDisk:starIds];
    [[Singleton sharedSingleton] resetStarMessages];
    _message.favouriteMarked = FALSE;
    btnMark.hidden = _message.favouriteMarked;
    btnUnMark.hidden = !_message.favouriteMarked;
    [starIds release];
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
    NSString *phone=[NSString stringWithFormat:@"tel:%@",[_message.phone stringByReplacingOccurrencesOfString:@" " withString:@"-"]];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
}
-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}
@end
