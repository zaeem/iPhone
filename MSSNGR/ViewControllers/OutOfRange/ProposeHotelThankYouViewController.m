//
//  ProposeHotelThankYouViewController.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/20/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "ProposeHotelThankYouViewController.h"
#import "ParticipatingHotelsViewController.h"
#import "Utility.h"
@implementation ProposeHotelThankYouViewController

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
    NSString *html = NSLocalizedString(@"Thank you for your proposal! If a relevant number of MSSNGR users share your proposal, chances are good to convince the hotel to also participate in MSSNGR in the future.</br></br>If you would like to see which hotels currently offer the MSSNGR service, please click the button below.", @"");
    [Utility addHtml:html onWebView:webView];
}
-(void)viewWillAppear:(BOOL)animated{

}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [Utility setNavigationBar:self addNextButton:NO addBackButton:NO addSearchButton:NO title:NSLocalizedString(@"Out of geo range", @"Out of geo range")];
    [showMore setTitle:NSLocalizedString(@"Show me all hotels offering MSSNGR service", @"Button for showing all hotels") forState:UIControlStateNormal];
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
    ParticipatingHotelsViewController *controller = [[ParticipatingHotelsViewController alloc]init];
    controller.loadData=TRUE;
    controller.navigationItem.hidesBackButton = YES;
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
