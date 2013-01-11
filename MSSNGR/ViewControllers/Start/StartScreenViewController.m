//
//  StartScreen.m
//  MSSNGR
//
//  Created by uraan on 11/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StartScreenViewController.h"
#import "User.h"
#import "UserMapper.h"
#import "DefineInterestsViewController.h"
#import "OutOfRangeViewController.h"
#import "CheckedOutViewController011.h"
#import "Utility.h"
#import "ParticipatingHotelsViewController.h"
#import "Helper.h"
#import "InterestMapper.h"
#import "Result.h"
@implementation StartScreenViewController
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
-(void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    [Singleton sharedSingleton].target=self;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];    
    [Singleton sharedSingleton].appUser.token = [userDefaults stringForKey:@"token"];
    [Singleton sharedSingleton].appUser.returningUser = [userDefaults boolForKey:@"returningUser"];
    NSDictionary *lastCheckedInHotel = [Helper readFileFromDisk:@"checkedInHotel"];
    if (lastCheckedInHotel != nil) {
        [Singleton sharedSingleton].checkedInHotel = [Hotel dictionaryToObject:lastCheckedInHotel];
    }else
    {
        [Singleton sharedSingleton].checkedInHotel = nil;
    }
    if ([Singleton sharedSingleton].appUser.token == nil || ![Singleton sharedSingleton].appUser.returningUser) {
        mapper = [[UserMapper alloc]init];
        mapper.target = self;
        [mapper newUser];
    }else{
        [[Singleton sharedSingleton].locationManager startUpdatingLocation];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [Singleton sharedSingleton].target=nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)nextScreen{
    //[[MySingleton sharedSingleton] getAddress];
    [loader stopAnimating];
	if (![Singleton sharedSingleton].appUser.returningUser) {
		
        DefineInterestsViewController *controller=[[DefineInterestsViewController alloc]init];
        controller.navigationItem.hidesBackButton = YES;
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];

	}else{
        if ([Utility findDistance]>50) {
            if ([[Singleton sharedSingleton].nearByHotels count] == 0) {
                OutOfRangeViewController *controller = [[OutOfRangeViewController alloc]init];
                [self.navigationController pushViewController:controller animated:YES];
                [controller release];
            }else{
                ParticipatingHotelsViewController *controller = [[ParticipatingHotelsViewController alloc]init];
                controller.loadData=FALSE;
                controller.navigationItem.hidesBackButton = YES;
                [self.navigationController pushViewController:controller animated:YES];
                [controller release];
            }
        }else{
            if ([Singleton sharedSingleton].appNotUsedForLAst2Days && [Singleton sharedSingleton].checkedInHotel !=nil) {
                // user is near to last checked in location and is not checked out and has not used app for 2 days. so we ask him are you still in same hotel
                CheckedOutViewController011 *controller = [[CheckedOutViewController011 alloc]init];
                [self.navigationController pushViewController:controller animated:YES];
                [controller release];
            }else{
                UITabBarController *tabBarController = [Utility configureMessagesTabBArController];
                [Utility pushAtRootViewControllerOfMainViewController:tabBarController];
            }
        }
    }
    [Singleton sharedSingleton].enableApplicationActivityDataLoading=TRUE;
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
-(void)createNewUserSucceeded:(Result *)result{
    [result retain];
    User *user = (User *)result.object;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults]; 
    [userDefaults setObject:user.token forKey:@"token"];
    [userDefaults setBool:FALSE forKey:@"returningUser"];
	[Singleton sharedSingleton].appUser.token=user.token;
    [Singleton sharedSingleton].appUser.returningUser=FALSE;
    [result release];
    //[[MySingleton sharedSingleton].locationManager startUpdatingLocation];
    [userDefaults synchronize];
    [self nextScreen];
}
-(void)createNewUserFailed:(Result *)result{
   // [[MySingleton sharedSingleton].locationManager startUpdatingLocation];
}


- (void)dealloc {
    [mapper release];
    [super dealloc];
}
-(void)reloadOnNearHotels{
   [self nextScreen]; 
}
-(void)reloadOnLocationUpdate{
    [[Singleton sharedSingleton] getNearByHotels];
}
@end
