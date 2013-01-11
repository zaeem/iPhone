//
//  ThankYouViewController.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/20/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "ThankYouViewController.h"
#import "ParticipatingHotelsViewController.h"
#import "Utility.h"
@implementation ThankYouViewController

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
}
-(void)viewDidAppear:(BOOL)animated{
    [Utility addHtml:@"Thank you for using the MSSNGR service. You will not be informed by our service until you check in with the MSSNGR app in the future." onWebView:webView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
        [Utility setNavigationBar:self addNextButton:NO addBackButton:NO addSearchButton:NO title:NSLocalizedString(@"Thank you for using MSSNGR!",@"Thank you for using MSSNGR!")];
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
    controller.navigationItem.hidesBackButton = YES;
    controller.hidesBottomBarWhenPushed=TRUE;
    controller.loadData=TRUE;
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
