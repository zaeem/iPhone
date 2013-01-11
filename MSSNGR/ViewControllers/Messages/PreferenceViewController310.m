//
//  PreferenceViewController310.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/20/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "PreferenceViewController310.h"
#import "DefineInterestsViewController.h"
#import "ParticipatingHotelsViewController.h"
#import "TermsOfServiceViewController.h"
#import "CheckedOutViewController011.h"
#import "ConventionCodeViewController.h"
#import "AboutViewController.h"
#import "LogOutConventionViewController.h"
#import "Singleton.h"
#import "CheckOutViewController.h"
#import "SearchViewController500.h"
#import "Utility.h"
#import "ASIHTTPRequest.h"
#import "ConventionsViewController.h"
#import "Utility.h"
@implementation PreferenceViewController310

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Preferences",@"Preferences") image:[UIImage imageNamed:@"tab-03-preferences"] tag:2];
        [self setTabBarItem:item];
        [item release];
		self.title = NSLocalizedString(@"Preferences", @"Preferences") ;
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
-(void)viewWillAppear:(BOOL)animated
{
    [preferencesTableView deselectRowAtIndexPath:preferencesTableView.indexPathForSelectedRow animated:YES];
    if (resetPosition) {
        [preferencesTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    }
    resetPosition = TRUE;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [Utility setNavigationBar:self addNextButton:NO addBackButton:NO addSearchButton:YES title:NSLocalizedString(@"Preferences", @"Preferences")];
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
-(void)dealloc{
    [preferencesTableView release];
    if (userMapper) {
        userMapper.target = nil;
        [userMapper release];
    }
    userMapper = nil;
    if (mapper) {
        mapper.target = nil;
        [mapper release];
    }
    mapper = nil;
    preferencesTableView = nil;
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark UITableVIew Delegate Functions

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
	switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 5;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellStyle style = UITableViewCellStyleDefault;
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [aTableView
                dequeueReusableCellWithIdentifier:@"RedCell"];
        if (!cell){
            cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"RedCell"] autorelease];
            [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
    }else{
        cell = [aTableView
                dequeueReusableCellWithIdentifier:@"BaseCell"];
        if (!cell){
            cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"BaseCell"] autorelease];
            [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
        }
        if (indexPath.section == 3) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else{
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
    }
    switch (indexPath.section) {
        case 0:{
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.text = NSLocalizedString(@"Check out of current hotel", @"Check out of current hotel");
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
            cell.backgroundColor = [UIColor colorWithRed:0.73 green:0 blue:0 alpha:1.0];
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            break;
        }
        case 1:{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            switch (indexPath.row) {
                case 0:{
                    cell.textLabel.text = NSLocalizedString(@"Define interests",@"Define interests");
                    break;
                }
                case 1:{
                    cell.textLabel.text = NSLocalizedString(@"Conventions",@"Convention");
                    break;
                }
                case 2:{
                    cell.textLabel.text = NSLocalizedString(@"Participating hotels",@"Participating hotels");
                    break;
                }
                case 3:{
                    cell.textLabel.text = NSLocalizedString(@"Terms of service & Privacy",@"Terms of service & Privacy");
                    break;
                }
                case 4:{
                    cell.textLabel.text = NSLocalizedString(@"About MSSNGR",@"About MSSNGR");
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 2:{
            cell.accessoryType = UITableViewCellAccessoryNone;
            switch (indexPath.row) {
                case 0:{
                    cell.textLabel.text = NSLocalizedString(@"Rate MSSNGR",@"Rate MSSNGR");
                    cell.textLabel.textAlignment = UITextAlignmentCenter;
                    break;
                }
                case 1:{
                    cell.textLabel.text = NSLocalizedString(@"Recommend MSSNGR",@"Recommend MSSNGR");
                    cell.textLabel.textAlignment = UITextAlignmentCenter;
                    break;
                }
            }
            break;
        }
        case 3:{
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
            NSString* version = [infoDict objectForKey:@"CFBundleVersion"];
            cell.textLabel.text = [NSString stringWithFormat:@"Version %@",version];
            break;
        }
        default:
            break;
    }
	return cell;
}

-(void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    resetPosition = FALSE;
    switch (indexPath.section) {
        case 0:{
            [self checkOut];
            break;
        }
        case 1:{
            switch (indexPath.row) {
                case 0:{
                    DefineInterestsViewController *defineInterestObject = [[DefineInterestsViewController alloc] initWithNibName:@"DefineInterestsViewController" bundle:nil];
                    [self.navigationController pushViewController:defineInterestObject animated:YES];
                    [defineInterestObject release];
                    break;
                }
                case 1:{
                    if (mapper == nil) {
                        mapper = [[ConventionMapper alloc]init];
                        mapper.target = self;
                    }
                    [activityIndicator startAnimating];
                    [preferencesTableView setUserInteractionEnabled:FALSE];
                    [mapper showUserConvention:[Singleton sharedSingleton].appUser.token];
                    break;
                }
                case 2:{
                    ParticipatingHotelsViewController *controller = [[ParticipatingHotelsViewController alloc] initWithNibName:@"ParticipatingHotelsViewController" bundle:nil];
                    controller.loadData=TRUE;
                    controller.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:controller animated:YES];
                    [controller release];
                    break;
                }
                case 3:{
                    TermsOfServiceViewController *termsObj = [[TermsOfServiceViewController alloc] initWithNibName:@"TermsOfServiceViewController" bundle:nil];
                    [self.navigationController pushViewController:termsObj animated:YES];
                    [termsObj release];
                    break;
                }
                case 4:{
                    AboutViewController *aboutMSSNGR_Obj = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
                    [self.navigationController pushViewController:aboutMSSNGR_Obj animated:YES];
                    [aboutMSSNGR_Obj release];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 2:{
            switch (indexPath.row) {
                case 0:{
                    [self rateMSSNGR];
                    break;
                }
                case 1:{
                    [self recommendMSSNGR];
                    break;
                }
            }
            break;
        }
        default:
            break;
    }
}


#pragma mark ConventionMapper

-(void)showUserConventionSucceeded:(Result *)result
{
	[result retain];
    ConventionsViewController *controller = [[ConventionsViewController alloc]init];
    controller.conventions = (NSArray *)result.object;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
	[result release];
    
    [activityIndicator stopAnimating];
    [preferencesTableView setUserInteractionEnabled:TRUE];
}

-(void)showUserConventionFailed:(Result *)result
{
	ConventionCodeViewController *conventionObject = [[ConventionCodeViewController alloc] initWithNibName:@"ConventionCodeViewController" bundle:nil];
	[self.navigationController pushViewController:conventionObject animated:YES];
	[conventionObject release];
    
    [activityIndicator stopAnimating];
    [preferencesTableView setUserInteractionEnabled:TRUE];
}
-(void)checkOut{
    [activityIndicator startAnimating];
    if (userMapper == nil) {
        userMapper = [[UserMapper alloc]init];
        userMapper.target = self;
    }
    [userMapper checkOut:[Singleton sharedSingleton].appUser.token :[Singleton sharedSingleton].checkedInHotel.Id];
    [[Singleton sharedSingleton] releaseCheckInHotel];
}
- (void)checkOutUserSucceeded:(Result *)result
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
-(void)rateMSSNGR{
	NSURL *webURL = [NSURL URLWithString:@"http://itunes.apple.com/us/app/mssngr/id485696540?l=de&ls=1&mt=8"];
    [[UIApplication sharedApplication] openURL: webURL];
    [preferencesTableView deselectRowAtIndexPath:preferencesTableView.indexPathForSelectedRow animated:YES];
}
-(void)recommendMSSNGR{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil){
        // We must always check whether the current device is configured for sending emails
        if ([mailClass canSendMail]){
            [self displayComposerSheet];
        }else{
            [self launchMailAppOnDevice];
        }
    }else{
        [self launchMailAppOnDevice];
    }
}
// Displays an email composition interface inside the application. Populates all the Mail fields.
- (void) displayComposerSheet{
    
    MFMailComposeViewController *tempMailCompose = [[MFMailComposeViewController alloc] init];
    tempMailCompose.mailComposeDelegate = self;
    [tempMailCompose setSubject:NSLocalizedString(@"MSSNGR - Hotel information, the way I want it",@"Heading for recommendation mail")];
    [tempMailCompose setMessageBody:NSLocalizedString(@"Hey there!\nI've been using the MSSNGR app for some time now and thought you might like it. It's a free and easy App that informs you about what is happening in your hotel. You decide about what, when and where you want to be informed.\n\nCheck out the free app in the app store:\nhttp://itunes.apple.com/us/app/mssngr/id485696540?l=de&ls=1&mt=8\n\nHave a happy vacation with MSSNGR!",@"Body for recommendation mail") isHTML:NO];
    [self presentModalViewController:tempMailCompose animated:YES];
    [tempMailCompose release];
}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error { 
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Result: canceled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Result: saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Result: sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Result: failed");
            break;
        default:
            NSLog(@"Result: not sent");
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}

// Launches the Mail application on the device. Workaround
-(void)launchMailAppOnDevice{
    NSString *recipients = [NSString stringWithFormat:@"mailto:%@?subject=%@", @"test@mail.com", @"Recommend MSSNGR"];
    NSString *mailBody = [NSString stringWithFormat:@"&amp;body=%@",@"Mail Test"];
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, mailBody];
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}
@end
