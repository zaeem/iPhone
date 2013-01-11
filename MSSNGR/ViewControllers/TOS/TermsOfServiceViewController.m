//
//  termsOfService.m
//  MSSNGR
//
//  Created by uraan on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TermsOfServiceViewController.h"
#import "ParticipatingHotelsViewController.h"
#import "Singleton.h"
#import "User.h"
#import "Utility.h"
#import "OutOfRangeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Helper.h"
@implementation TermsOfServiceViewController

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
-(void)viewWillAppear:(BOOL)animated{
}
-(void)viewDidAppear:(BOOL)animated{
    [Singleton sharedSingleton].target=self;
    NSString *html = [Helper readStringDataFromFile:@"tos" :@"html"];
    [Utility addHtml:html onWebView:webView];
}
-(void)viewWillDisappear:(BOOL)animated{
    [Singleton sharedSingleton].target=nil;
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
    [Utility setNavigationBar:self addNextButton:NO addBackButton:!self.navigationItem.hidesBackButton addSearchButton:NO title:NSLocalizedString(@"Terms of service & Privacy",@"Terms of service & Privacy")];
    if ([Singleton sharedSingleton].appUser.returningUser) {
        btnAccept.hidden = YES;
        [backView setFrame:CGRectMake(-1,-1,322, 461)];
        [webView setFrame:CGRectMake(0,44,320,460)];
    }else{
        [btnAccept setTitle:NSLocalizedString(@"I accept the above terms of service",@"I accept the above terms of service") forState:UIControlStateNormal];
        btnAccept.hidden = NO;
        [webView setFrame:CGRectMake(0,44,320,339)];
        [backView setFrame:CGRectMake(-1,-1,322,385)];
    }
    backView.layer.borderWidth = 1.0f;
    backView.layer.borderColor = [[UIColor darkGrayColor] CGColor];
}
-(IBAction)backButtonAction
{
	[self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)nextButtonAction:(id)sender
{

}

-(IBAction)acceptTermsAction:(id)sender
{
    [[Singleton sharedSingleton].locationManager startUpdatingLocation];
}

#pragma mark TableView Delegate functions




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

-(void)reloadOnNearHotels{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:TRUE forKey:@"returningUser"];
    [Singleton sharedSingleton].appUser.returningUser = TRUE;
    if ([[[Singleton sharedSingleton] nearByHotels] count] == 0) {
        OutOfRangeViewController *controller = [[OutOfRangeViewController alloc]init];
        controller.hidesBottomBarWhenPushed=TRUE;
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }else{
        ParticipatingHotelsViewController *controller = [[ParticipatingHotelsViewController alloc]init];
        controller.hidesBottomBarWhenPushed=TRUE;
        controller.navigationItem.hidesBackButton = TRUE;
        controller.loadData=FALSE;
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }
    [userDefaults synchronize];
}
-(void)reloadOnLocationUpdate{
    [[Singleton sharedSingleton] getNearByHotels];
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}
@end
