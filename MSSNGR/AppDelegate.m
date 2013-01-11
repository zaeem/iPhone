//
//  AppDelegate.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/11/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "AppDelegate.h"
#import "StartScreenViewController.h"
#import "Singleton.h"
#import "Utility.h"
#import "HomScreenViewController.h"
#import "WhatsGoingOnViewController110.h"
#import <AudioToolbox/AudioServices.h>
#import "ParticipatingHotelsViewController.h"
#import "UAirship.h"
#import "UAPush.h"
@implementation UINavigationBar (UINavigationBarCategory)

- (void)drawRect:(CGRect)rect
{
	UIImage *image = [UIImage imageNamed:@"nav-bg"];
	[image drawInRect:rect];
}

@end
@implementation AppDelegate

@synthesize window = _window;
@synthesize mainNavigationController=_mainNavigationController;
- (void)dealloc
{
    [_window release];
    [super dealloc];
}

#import <BugSense-iOS/BugSenseCrashController.h>


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    // Bugsense tracking
    BugSenseCrashController *crashController = [BugSenseCrashController sharedInstanceWithBugSenseAPIKey:@"9ea0993e"];
    
    [Singleton sharedSingleton].enableApplicationActivityDataLoading =FALSE;
    runningFirstTime = TRUE;
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [self setWindowSize];
    // Override point for customization after application launch.
    HomScreenViewController *home=[[HomScreenViewController alloc]init];
    self.window.rootViewController=home;
    [home release];
    [self.window makeKeyAndVisible];
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    [[Singleton sharedSingleton] logUserActivityTime];
    
    
    //Init Airship launch options
    NSMutableDictionary *takeOffOptions = [[[NSMutableDictionary alloc] init] autorelease];
    [takeOffOptions setValue:launchOptions forKey:UAirshipTakeOffOptionsLaunchOptionsKey];
    
    // Create Airship singleton that's used to talk to Urban Airship servers.
    // Please replace these with your info from http://go.urbanairship.com
    [UAirship takeOff:takeOffOptions];
    
    [[UAPush shared] enableAutobadge:YES];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[UAPush shared] resetBadge];
    // Register for notifications through UAPush for notification type tracking
    /*[[UAPush shared] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeSound |
                                                         UIRemoteNotificationTypeAlert)];
    */
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSDate date] forKey:@"lastUsedDate"];
    [userDefaults synchronize];
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    [[Singleton sharedSingleton] logUserActivityTime];
    [self reloadOnForeGround];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    if ([UIApplication sharedApplication].applicationIconBadgeNumber > 0) {
        if ([_mainNavigationController.topViewController isKindOfClass:[UITabBarController class]]) {
            UINavigationController * controller= (UINavigationController *)[((UITabBarController *)_mainNavigationController.topViewController).viewControllers objectAtIndex:0];
            [controller popToRootViewControllerAnimated:NO];
            WhatsGoingOnViewController110 *obj = (WhatsGoingOnViewController110 *) [controller topViewController];
            
            [obj reloadOnPushNotification];
            ((UITabBarController *)_mainNavigationController.topViewController).selectedIndex = 0;
        }else{
            
        }
    }
    [self resetBadges];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [UAirship land];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSDate date] forKey:@"lastUsedDate"];
    [userDefaults synchronize];
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken 
{ 
    NSString *token = [[NSString stringWithFormat:@"%@",deviceToken] stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"-" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    [Singleton sharedSingleton].device_token = token;
    [[UAPush shared] registerDeviceToken:deviceToken];
    [self resetBadges];
    [self startApp];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err 
{ 
    [NSString stringWithFormat:@"%@",err];
    UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Denial of Push Messages:",@"Denial of Push Messages:") message:NSLocalizedString(@"This app informs you about exclusive deals around your stay in hotels. If push messages are not allowed, you will not get noticed immediately about the latest offering. To always receive the best deals immediately, please allow this app to send push messages.",@"Message that informs the user about the consequences of push denial") delegate:self cancelButtonTitle:NSLocalizedString(@"OK",@"OK") otherButtonTitles:nil];
    servicesDisabledAlert.tag=2000;
    [servicesDisabledAlert show];
    [servicesDisabledAlert release]; 
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    if (application.applicationState == UIApplicationStateActive) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"MSSNGR"
                                                            message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"OK",@"OK")
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        if ([_mainNavigationController.topViewController isKindOfClass:[UITabBarController class]]) {
            UINavigationController * controller= (UINavigationController *)[((UITabBarController *)_mainNavigationController.topViewController).viewControllers objectAtIndex:0];
            [controller popToRootViewControllerAnimated:NO];
            WhatsGoingOnViewController110 *obj = (WhatsGoingOnViewController110 *) [controller topViewController];
            
            [obj reloadOnPushNotification];
            ((UITabBarController *)_mainNavigationController.topViewController).selectedIndex = 0;
        }
        [self resetBadges];
    }
}
-(void)registerPushNotifications{
    [[UAPush shared] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeSound |
                                                         UIRemoteNotificationTypeAlert)];
    /*[[UIApplication sharedApplication] 
     registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeAlert | 
      UIRemoteNotificationTypeBadge | 
      UIRemoteNotificationTypeSound)];*/
}
-(void)startApp{
    if (runningFirstTime) {
        runningFirstTime = FALSE;
        if (start==nil) {
            start=[[StartScreenViewController alloc]init];
        }
        _mainNavigationController=[[UINavigationController alloc]initWithRootViewController:start];  
        _mainNavigationController.navigationBarHidden = YES;
        self.window.rootViewController=_mainNavigationController;
        [self.window makeKeyAndVisible];
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{ 
    [locationManager stopUpdatingLocation];
    locationManager.delegate=nil;
    [Singleton sharedSingleton].currentLat = newLocation.coordinate.latitude;
    [Singleton sharedSingleton].currentLng = newLocation.coordinate.longitude;
    [self registerPushNotifications];

    // MySingleton *singleTon = [MySingleton sharedSingleton];
    //   if ([Utility findDistance] > 50 && singleTon.checkedInHotel!=nil) {
    //       [[MySingleton sharedSingleton] releaseCheckInHotel];
    //       if (mapper == nil) {
    //           mapper = [[UserMapper alloc]init];
    //           mapper.target=nil;
    //       }
    //       [mapper checkOut:singleTon.appUser.token :singleTon.checkedInHotel.Id];
    //       [_mainNavigationController popToRootViewControllerAnimated:NO];
    //       /*ParticipatingHotelsViewController *controller = [[ParticipatingHotelsViewController alloc]init];
    //       controller.loadData=TRUE;
    //       [MySingleton sharedSingleton].target = nil;
    //       controller.navigationItem.hidesBackButton=YES;
    //       controller.hidesBottomBarWhenPushed=TRUE;
    //       [_mainNavigationController pushViewController:controller animated:YES];
    //       [controller release];*/
    //   }
  
}
- (void) locationManager: (CLLocationManager *) manager
        didFailWithError: (NSError *) error {
    [locationManager stopUpdatingLocation];
    locationManager.delegate = nil;
    if (locationManager.locationServicesEnabled == NO) {
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Location Services Disabled",@"Location Services Disabled") message:NSLocalizedString(@"You currently have all location services for this device disabled.This app must be supported by the geo location function of this device. If you would like to use the MSSNGR service, please allow this app to access your geo location. Thank you.",@"Message that informs user that geo location is disabled") delegate:self cancelButtonTitle:NSLocalizedString(@"OK",@"OK") otherButtonTitles:nil];
        servicesDisabledAlert.tag=1999;
        [servicesDisabledAlert show];
        [servicesDisabledAlert release];
    }else{
        @try {
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (status == kCLAuthorizationStatusNotDetermined) {
                [self registerPushNotifications];
            }else{
                if (status != kCLAuthorizationStatusAuthorized) {
                    UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Denial of Geo Location:",@"Denial of Geo Location:") message:NSLocalizedString(@"This app must be supported by the geo location function of this device. If you would like to use the MSSNGR service, please allow this app to access your geo location. Thank you.",@"Message informing the user about denial of geolocation") delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    servicesDisabledAlert.tag=1999;
                    [servicesDisabledAlert show];
                    [servicesDisabledAlert release];
                }else{
                    [self registerPushNotifications];
                }
            }
        }@catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        }
    }
    //[manager release];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    switch (alertView.tag) {
        case 1999:{
            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs://"]];
            [self registerPushNotifications];
            break;
        }
        case 2000:{
            [self startApp];
            //[UAPush openApnsSettings:_mainNavigationController animated:YES];
            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs://"]];
            break;
        }
        default:
            break;
    }
}
-(void)reloadOnForeGround{
    NSLog(@"reload on foreground called");
    id top = _mainNavigationController.topViewController;
    if ([top isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabController = (UITabBarController *)top;
        UINavigationController * controller= (UINavigationController *)[(tabController).viewControllers objectAtIndex:tabController.selectedIndex];
        //[controller popToRootViewControllerAnimated:NO];
        [controller.topViewController viewDidAppear:NO];
        NSLog(@"reload tab bar top view controller");
    }else{
        if ([top isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navController = (UINavigationController *)top;
            NSLog(@"reload navigation controller top view controller");
            [navController.topViewController viewDidAppear:NO];
        }else{
            if ([top isKindOfClass:[UIViewController class]]) {
                NSLog(@"reload view controller top view controller");
                [top viewDidAppear:NO];
            }
        }
    }
}
-(void)resetBadges{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[UAPush shared] resetBadge];
    [API activateUser];
}
- (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame 
{
    [self setWindowSize];
}
-(void)setWindowSize{
    UIApplication *application = [UIApplication sharedApplication];
    [self.window setFrame:CGRectMake(0,application.statusBarFrame.size.height,320,480-application.statusBarFrame.size.height)];
}
@end
