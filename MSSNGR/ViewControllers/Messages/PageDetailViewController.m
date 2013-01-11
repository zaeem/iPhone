//
//  PageDetailViewController.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/21/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "PageDetailViewController.h"
#import "Page.h"
#import "SearchViewController500.h"
#import "Helper.h"
#import "Utility.h"
#import <QuartzCore/QuartzCore.h>
@implementation PageDetailViewController
@synthesize pageDetails=_pageDetails;
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
-(void)viewWillAppear:(BOOL)animated{
     self.navigationItem.title=_pageDetails.title;
}
-(void)viewDidAppear:(BOOL)animated{
    [Utility addHtml:_pageDetails.text onWebView:webView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [Utility setNavigationBar:self addNextButton:NO addBackButton:YES addSearchButton:YES title:_pageDetails.title];
    backView.layer.borderWidth = 1.0f;
    backView.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    if (_pageDetails.phone == nil || [_pageDetails.phone isEqualToString:@""]) {
        btnCall.enabled = FALSE;
    }
    if (_pageDetails.website == nil || [_pageDetails.website isEqualToString:@""]) {
        btnWeb.enabled = FALSE;
    }
    
    if (![_pageDetails validCoordinates]) {
        btnMap.enabled = FALSE;
    }
    if (_pageDetails.image != nil && ![_pageDetails.image isEqualToString:@""]) {
        [asyncImage loadImageFromURLString:_pageDetails.image];
    }else{
        [webView setFrame:CGRectMake(0,44, 320, 287)];
    }
    btnMark.hidden = _pageDetails.favouriteMarked;
    btnUnMark.hidden = !_pageDetails.favouriteMarked;
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
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)callHotelButtonAction:(id)sender
{
    [Utility showCallAlertBox:_pageDetails.phone :self];
}

-(IBAction)goToWebsiteButtonAction:(id)sender
{
	NSURL *webURL = [NSURL URLWithString:_pageDetails.website];
    [[UIApplication sharedApplication] openURL: webURL];
}

-(IBAction)mapButtonAction:(id)sender
{
	NSString *url = [Utility mapLink:_pageDetails.title Lat:_pageDetails.lat Lng:_pageDetails.lng];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
-(IBAction)markClicked:(id)sender{
    NSMutableArray *starIds = [Helper readStarPages];
    [starIds retain];
    Boolean alreadyAdded=FALSE;
    for(NSString *messageId in starIds){
        if ([messageId intValue] == [_pageDetails.Id intValue]) {
            alreadyAdded = TRUE;
            break;
        }
    }
    if (!alreadyAdded) {
        [starIds addObject:_pageDetails.Id];
        [Helper writePagesToDisk:starIds];
        [[Singleton sharedSingleton] resetStarPages];
        _pageDetails.favouriteMarked = TRUE;
        btnMark.hidden = _pageDetails.favouriteMarked;
        btnUnMark.hidden = !_pageDetails.favouriteMarked;
    }
    [starIds release];
}
-(IBAction)unMarkClicked:(id)sender{
    NSMutableArray *starIds = [Helper readStarPages];
    [starIds retain];
    [starIds removeObject:_pageDetails.Id];
    [Helper writePagesToDisk:starIds];
    [[Singleton sharedSingleton] resetStarPages];
    _pageDetails.favouriteMarked = FALSE;
    btnMark.hidden = _pageDetails.favouriteMarked;
    btnUnMark.hidden = !_pageDetails.favouriteMarked;
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
    NSString *phone=[NSString stringWithFormat:@"tel:%@",[_pageDetails.phone stringByReplacingOccurrencesOfString:@" " withString:@"-"]];
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
