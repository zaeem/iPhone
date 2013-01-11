//
//  AppDelegate.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/11/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@class UserMapper;
@class StartScreenViewController;
@interface AppDelegate : NSObject <UIApplicationDelegate,CLLocationManagerDelegate>
{
    UINavigationController *_mainNavigationController;
    Boolean runningFirstTime;
    CLLocationManager *locationManager;
    UserMapper *mapper;
    StartScreenViewController *start;
}
@property(nonatomic,assign) UINavigationController *mainNavigationController;
@property (nonatomic, retain) IBOutlet UIWindow *window;
-(void)startApp;
-(void)registerPushNotifications;
-(void)reloadOnForeGround;
-(void)resetBadges;
-(void)setWindowSize;
@end
