//
//  Utility.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/20/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface Utility : NSObject{
    
}
+(UITabBarController *)configureMessagesTabBArController;
+(CLLocationDistance)findDistance;
+(void)pushAtRootViewController:(UINavigationController *)navController :(UIViewController *)controller;
+(void)pushAtRootViewControllerOfMainViewController:(UIViewController *)controller;
+(void)setNavigationBar:(UIViewController *)controller addNextButton:(BOOL)addNext addBackButton:(BOOL)addBack addSearchButton:(BOOL)addSearch title:(NSString *)title;
+(Boolean)isPushedOnSearchViewController:(UINavigationController *)navController;
+(void)showCallAlertBox:(NSString *)phone :(UIViewController *)target;
+(NSString *)checkNullValues :(NSString *)value;
+(NSNumber *)checkNSnumberValue :(NSNumber *)value;
+(NSDate *)stringToDate :(NSString *)date;
+(NSString *)DateToString :(NSDate *)date :(NSString *)format;

+(NSDate *)timeTillNextDayMidNight;
+(NSDate *)dayEndTime;
+(void)downLoadImage :(NSString *)image_url;
+(void)addHtml :(NSString *)data onWebView:(UIWebView *)webView;
+(void)addNavigationAnimation :(UILabel *)label;
+(NSString *) returnMD5Hash:(NSString*)concat;
+(NSString *)htmlEntityDecode:(NSString *)string;
+(NSString *)htmlEntityEncode:(NSString *)string;
+(NSString *)mapLink :(NSString *)title Lat:(NSNumber *)lat Lng:(NSNumber *)lng;
@end
