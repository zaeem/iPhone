//
//  OutOfRangeViewController.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/20/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "OutOfRangeViewController.h"
#import "ParticipatingHotelsViewController.h"
#import "ThankYouViewController.h"
#import "ProposeHotelThankYouViewController.h"
#import "Utility.h"
@implementation OutOfRangeViewController

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
    [lblHotelName setText:NSLocalizedString(@"Hotel Name:",@"Hotel Name:")];
    [lblCountry setText:NSLocalizedString(@"Country:", @"Country:")];    
    [lblCity setText:NSLocalizedString(@"City:", @"City:")];
    [btnShowAll setTitle:NSLocalizedString(@"Show all hotels", @"Show all hotels") forState:UIControlStateNormal];
    [btnSendToMSSNGR setTitle:NSLocalizedString(@"Send to MSSNGR", @"Send to MSSNGR") forState:UIControlStateNormal];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [Singleton sharedSingleton].target = nil;
}
-(void)reloadOnAddress:(NSArray *)data1{
    BOOL cityFound = false;
    if ([data1 isKindOfClass:[NSArray class]]) {
        if ([data1 count] >=1) {
            if ([data1 isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dict in data1) {
                    if ([dict isKindOfClass:[NSDictionary class]]) {
                        if ([[dict valueForKey:@"types"] isKindOfClass:[NSArray class]]) {
                            if ([[dict valueForKey:@"types"] count]>=1) {
                                if (([[[dict valueForKey:@"types"] objectAtIndex:0] isEqualToString:@"administrative_area_level_3"] || [[[dict valueForKey:@"types"] objectAtIndex:0] isEqualToString:@"administrative_area_level_2"] || [[[dict valueForKey:@"types"] objectAtIndex:0] isEqualToString:@"administrative_area_level_1"]) && !cityFound) {
                                    cityName.text = [dict valueForKey:@"long_name"];
                                    cityFound = TRUE;
                                }else{
                                    if ([[[dict valueForKey:@"types"] objectAtIndex:0] isEqualToString:@"country"]) {
                                        countryName.text = [dict valueForKey:@"long_name"];
                                    } 
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [Utility setNavigationBar:self addNextButton:NO addBackButton:NO addSearchButton:NO title:NSLocalizedString(@"Out of geo range", @"Out of geo range")];
    svos = scrollView.contentOffset;
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated{
    [Singleton sharedSingleton].target = self;
    [[Singleton sharedSingleton] getAddress];
    NSString *html = NSLocalizedString(@"We are sorry! At your current location, no hotel offers MSSNGR services.<br><br><br>If you would like to propose a hotel to participate in MSSNGR for the future, please enter the hotel details below.",@"Text explaining that no hotels are available");
    [Utility addHtml:html onWebView:webView];
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
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}
-(IBAction)goToThankYouForUsingMSSNGRScreen:(id)sender{
    ThankYouViewController *controller = [[ThankYouViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [scrollView setContentOffset:svos animated:YES]; 
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:scrollView];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= 60;
    [scrollView setContentOffset:pt animated:YES];           
}
-(IBAction)proposeHotel:(id)sender{
    ProposeHotelThankYouViewController *controller = [[ProposeHotelThankYouViewController alloc]init];
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
