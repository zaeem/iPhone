//
//  CallReceptionViewController400.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/20/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "CallReceptionViewController400.h"
#import "SearchViewController500.h"
#import <QuartzCore/QuartzCore.h>
#import "Singleton.h"
#import "Hotel.h"
#import "Utility.h"
@implementation CallReceptionViewController400
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Call us", @"Call us") image:[UIImage imageNamed:@"tab-04-call-us"] tag:3];
        [self setTabBarItem:item];
        [item release];
        self.title=NSLocalizedString(@"Call us", @"Call us");
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(IBAction) callToReception:(id)sender{
	 [Utility showCallAlertBox:[Singleton sharedSingleton].checkedInHotel.phone :self];
}
-(IBAction)openMapView:(id)sender{
    NSString *latlong=[NSString stringWithFormat:@"%@@%@,%@",[Singleton sharedSingleton].checkedInHotel.name,[Singleton sharedSingleton].checkedInHotel.lat,[Singleton sharedSingleton].checkedInHotel.lng];

    NSString *url = [NSString stringWithFormat: @"http://maps.google.com/maps?q=%@",
					 [latlong stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
-(IBAction)openWebAddress:(id)sender{
    NSString *url=[Singleton sharedSingleton].checkedInHotel.website;
	NSURL *webURL = [NSURL URLWithString:url];
    [[UIApplication sharedApplication] openURL: webURL];
}
-(void)viewDidAppear:(BOOL)animated{
    Hotel *checkedInHotel = [Singleton sharedSingleton].checkedInHotel;
    [Utility addHtml:checkedInHotel.description onWebView:webView];
}

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated
{
    Hotel *checkedInHotel = [Singleton sharedSingleton].checkedInHotel;
    if (checkedInHotel) {
        if (checkedInHotel.phone == nil || [checkedInHotel.phone isEqualToString:@""]) {
            btnCall.enabled = FALSE;
        }
        if (checkedInHotel.website == nil || [checkedInHotel.website isEqualToString:@""]) {
            btnWeb.enabled = FALSE;
        }
        if (!checkedInHotel.validCoordinates) {
            btnMap.enabled = FALSE;
        }
       /* if (checkedInHotel.lat == nil ||checkedInHotel.lng == nil || checkedInHotel.lat == 0 || checkedInHotel.lng  == 0) {
            btnMap.enabled = FALSE;
        }
        */
    }else{
        btnCall.enabled = FALSE;
        btnWeb.enabled = FALSE;
        btnMap.enabled = FALSE;
    }
    
    if (checkedInHotel.image != nil && ![checkedInHotel.image isEqualToString:@""]) {
        [asyncImage loadImageFromURLString:checkedInHotel.image];
    }else{
        [webView setFrame:CGRectMake(0,44, 320,288)];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [Utility setNavigationBar:self addNextButton:NO addBackButton:NO addSearchButton:YES title:NSLocalizedString(@"Call us", @"Call us")];
    backView.layer.borderWidth = 1.0f;
    backView.layer.borderColor = [[UIColor darkGrayColor] CGColor];
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:NSLocalizedString(@"Call",@"Call")])
    {
        [self makeCall];
    }
}
-(void) makeCall{
    NSString *phone=[NSString stringWithFormat:@"tel:%@",[[Singleton sharedSingleton].checkedInHotel.phone stringByReplacingOccurrencesOfString:@" " withString:@"-"]];
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
