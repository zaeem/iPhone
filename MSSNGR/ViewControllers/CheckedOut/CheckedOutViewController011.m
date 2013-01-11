//
//  CheckedOutViewController011.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/20/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "CheckedOutViewController011.h"
#import "ParticipatingHotelsViewController.h"
#import "Utility.h"
#import "Singleton.h"
#import "Hotel.h"
#import "Helper.h"
@implementation CheckedOutViewController011

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
-(void)viewDidAppear:(BOOL)animated{
    [Utility addHtml:NSLocalizedString(@"You have not logged in for 2 days. Are you still checked in at the following hotel?",@"You have not logged in for 2 days. Are you still checked in at the following hotel?") onWebView:webView];
}
#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated
{
	txtHotelInfo.text= [NSString stringWithFormat:@"%@",[Singleton sharedSingleton].checkedInHotel.name];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [Utility setNavigationBar:self addNextButton:NO addBackButton:NO addSearchButton:NO title:NSLocalizedString(@"Welcome to MSSNGR", @"Welcome to MSSNGR")];
    [btnYes setTitle:NSLocalizedString(@"Yes",@"Yes") forState:UIControlStateNormal];
    [btnYes setTitle:NSLocalizedString(@"No", @"No") forState:UIControlStateNormal];    
    // Do any additional setup after loading the view from its nib.
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
-(IBAction)goToParticipatingHotels:(id)sender{
    [[Singleton sharedSingleton] releaseCheckInHotel];
    ParticipatingHotelsViewController *controller = [[ParticipatingHotelsViewController alloc]init];
    controller.loadData=TRUE;
    controller.navigationItem.hidesBackButton = YES;
    controller.hidesBottomBarWhenPushed=TRUE;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}
-(IBAction)goToMessages:(id)sender
{
	UITabBarController *tabBarController = [Utility configureMessagesTabBArController];
    [Utility pushAtRootViewControllerOfMainViewController:tabBarController];
}
-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}
@end
