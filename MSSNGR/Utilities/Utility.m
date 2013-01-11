//
//  Utility.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/20/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "Utility.h"
#import "WhatsGoingOnViewController110.h"
#import "DirectoryViewController210.h"
#import "PreferenceViewController310.h"
#import "CallReceptionViewController400.h"
#import "Singleton.h"
#import "SearchViewController500.h"
#import "AppDelegate.h"
#import "API.h"
#import "ASIHTTPRequest.h"
#import <QuartzCore/QuartzCore.h>
#import <CommonCrypto/CommonDigest.h>
@implementation Utility{
    
}
+(UITabBarController *)configureMessagesTabBArController{
    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    WhatsGoingOnViewController110 *controller1=[[WhatsGoingOnViewController110 alloc]init];
    DirectoryViewController210 *controller2=[[DirectoryViewController210 alloc]init];
    PreferenceViewController310 *controller3=[[PreferenceViewController310 alloc]init];
    CallReceptionViewController400 *controller4=[[CallReceptionViewController400 alloc]init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:controller1];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:controller2];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:controller3];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:controller4];
    nav1.navigationBarHidden = YES;
    nav2.navigationBarHidden = YES;
    nav3.navigationBarHidden = YES;
    nav4.navigationBarHidden = YES;
    NSArray *controllers = [[NSArray alloc]initWithObjects:nav1,nav2,nav3,nav4,nil];
    [tabBarController setViewControllers:controllers];
    [controllers release];
    //[tabBarController setViewControllers:[[NSArray alloc]initWithObjects:nav1,nav2,controller3,nav4, nil]];
    [nav1 release];
    [nav2 release];
    [nav3 release];
    [nav4 release];
    [controller1 release];
    [controller2 release];
    [controller3 release];
    [controller4 release];
    return tabBarController;
}
+(CLLocationDistance)findDistance{
    Singleton *instance = [Singleton sharedSingleton];
    if (instance.checkedInHotel) {
        CLLocation *lastCheckedInLocation = [[CLLocation alloc]initWithLatitude:[instance.checkedInHotel.lat floatValue] longitude:[instance.checkedInHotel.lng floatValue]];
        CLLocation *newLocation = [[CLLocation alloc]initWithLatitude:[Singleton sharedSingleton].currentLat longitude:[Singleton sharedSingleton].currentLng];
        CLLocationDistance kilometers = [newLocation distanceFromLocation:lastCheckedInLocation] / 1000;
        [lastCheckedInLocation release];
        [newLocation release];
        return kilometers;
    }else{
        return 10000;
    }
}
+(void)pushAtRootViewController:(UINavigationController *)navController :(UIViewController *)controller{
    NSMutableArray *controllers = [[navController.viewControllers mutableCopy] autorelease];
    [controllers removeAllObjects];
    navController.viewControllers = controllers;
    [navController pushViewController:controller animated:YES];
    [controller release];
}
+(void)pushAtRootViewControllerOfMainViewController:(UIViewController *)controller{
    AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    //NSMutableArray *controllers = [[appDel.mainNavigationController.viewControllers mutableCopy] autorelease];
    //[controllers removeAllObjects];
    //appDel.mainNavigationController.viewControllers = controllers;
    [appDel.mainNavigationController popToRootViewControllerAnimated:NO];
    [appDel.mainNavigationController pushViewController:controller animated:YES];
    [controller release];
}
+(void)setNavigationBar:(UIViewController *)controller addNextButton:(BOOL)addNext addBackButton:(BOOL)addBack addSearchButton:(BOOL)addSearch title:(NSString *)title{
    UINavigationBar *navigationBar;
    UINavigationItem *navigationItem;
    navigationBar = [[UINavigationBar alloc]init];
    [navigationBar setFrame:CGRectMake(0, 0, 320, 44)];
    [controller.view addSubview:navigationBar];
    navigationItem = [[UINavigationItem alloc]initWithTitle:title];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    if (addBack) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *butImage = [UIImage imageNamed:@"back"];
        [button setBackgroundImage:butImage forState:UIControlStateNormal];
        [button addTarget:controller action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0,55,35);
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        navigationItem.leftBarButtonItem = backButton;
        [backButton release];
    }
    if (addNext && !addSearch) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *butImage = [UIImage imageNamed:@"next"];
        [button setBackgroundImage:butImage forState:UIControlStateNormal];
        [button addTarget:controller action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0,55,35);
        UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        navigationItem.rightBarButtonItem = nextButton;
        [nextButton release];
    }
    if (addSearch) {
        if (![Singleton sharedSingleton].hideSearchButton) {
            UIBarButtonItem *searchButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:controller action:@selector(searchButtonAction)];
            if([searchButton respondsToSelector:@selector(setTintColor:)]){
                [searchButton setTintColor:[UIColor darkGrayColor]];
            }else{
                 
            }
            navigationItem.rightBarButtonItem = searchButton;
            [searchButton release];
        }
    }
    if ([[UINavigationBar class]respondsToSelector:@selector(appearance)]) {
        [navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bg"] forBarMetrics:UIBarMetricsDefault];
    }else{
        [navigationBar setTintColor:[UIColor darkGrayColor]];
    }
    
   /* if ([controller isKindOfClass:[WhatsGoingOnViewController110 class]] || [controller isKindOfClass:[DirectoryViewController210 class]]) {
        UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0,0,320,30)];
        [titleView setBackgroundColor:[UIColor clearColor]];
        UILabel *lblMessage = [[UILabel alloc]init];
        [lblMessage setTextAlignment:UITextAlignmentCenter];
        [lblMessage setTextColor:[UIColor whiteColor]];
        [lblMessage setFont:[UIFont boldSystemFontOfSize:20.0]];
        [lblMessage setBackgroundColor:[UIColor clearColor]];
        [lblMessage setText:title];
        [lblMessage setFrame:CGRectMake(250, 0, [title sizeWithFont:[UIFont boldSystemFontOfSize:20.0]].width, 30)];
        [titleView addSubview:lblMessage];
        titleView.clipsToBounds = YES;
        navigationItem.titleView = titleView;
        if ([controller isKindOfClass:[DirectoryViewController210 class]]) {
            DirectoryViewController210 *obj = (DirectoryViewController210 *)controller;
            obj.navTitle = lblMessage;
        }else{
             WhatsGoingOnViewController110 *obj = (WhatsGoingOnViewController110 *)controller;
            obj.navTitle = lblMessage;
        }
        [lblMessage release];
    }*/
    [navigationItem release];
    [navigationBar release];
}

+(void)addNavigationAnimation:(UILabel *)label{
    CABasicAnimation *scrollText;
    scrollText=[CABasicAnimation animationWithKeyPath:@"position.x"];
    scrollText.duration = [label.text sizeWithFont:[UIFont boldSystemFontOfSize:20.0]].width/50;
    scrollText.repeatCount = 100000;
    scrollText.autoreverses = NO;
    float toValue = [label.text sizeWithFont:[UIFont boldSystemFontOfSize:20.0]].width;
    scrollText.toValue = [NSNumber numberWithFloat:-toValue];
    //[[label layer] addAnimation:scrollText forKey:@"scrollTextKey"];
}
+(Boolean)isPushedOnSearchViewController:(UINavigationController *)navController{
    UIViewController *parentViewController = [navController.viewControllers objectAtIndex:navController.viewControllers.count -2];
    return [parentViewController isKindOfClass:[SearchViewController500 class]];
}
+(void)showCallAlertBox:(NSString *)phone :(UIViewController *)target{
    NSString *title = [NSString stringWithFormat:NSLocalizedString(@"Call %@ ?", @"Call %@ ?"),phone];
    UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:title message:NSLocalizedString(@"Roaming charges may apply.",@"Roaming charges may apply.") delegate:target cancelButtonTitle:NSLocalizedString(@"Cancel",@"Cancel") otherButtonTitles:NSLocalizedString(@"Call",@"Call"),nil];
    [servicesDisabledAlert show];
    [servicesDisabledAlert release];
}
+(NSString *)checkNullValues :(NSString *)value{
    if ([value isKindOfClass:[NSNull class]]) {
        return @"";
    }else{
        return value;
    }
}
+(NSNumber *)checkNSnumberValue :(NSString *)value{
    if ([value isKindOfClass:[NSString class]]) {
        if ([value isKindOfClass:[NSNull class]] || [value isEqualToString:@""]) {
            return nil;
        }else{
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
            [formatter setNumberStyle:NSNumberFormatterNoStyle];
            return [formatter numberFromString:value];
        }
    }else{
        if ([value isKindOfClass:[NSDecimalNumber class]]) {
            if ([value isKindOfClass:[NSNull class]]) {
                return nil;
            }else{
                return (NSDecimalNumber *)value;
            }
        }else{
            if ([NSStringFromClass([value class]) isEqualToString:@"__NSCFNumber"]) {
                return (NSDecimalNumber *)value;
            }
        }
    }
    return nil;
}
+(NSDate *)stringToDate:(NSString *)dateString{
    if ([dateString isKindOfClass:[NSNull class]]) {
        return nil;
    }else{
        NSDateFormatter *customFormat = [[NSDateFormatter alloc] init];
        customFormat.dateFormat=@"yyyy-MM-dd'T'HH:mm:ssZ";
        [customFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        NSDate * date = [customFormat dateFromString:dateString];
        [customFormat release];
        return date;
    }
}
+(NSString *)DateToString :(NSDate *)date :(NSString *)format{
    if ([date isKindOfClass:[NSNull class]]) {
        return nil;
    }else{
        NSDateFormatter *customFormat = [[NSDateFormatter alloc] init];
        customFormat.dateFormat=format;
        [customFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        NSString *value = [customFormat stringFromDate:date];
        [customFormat release];
        return value;
    }
}
+(NSDate *)timeTillNextDayMidNight{
    
    // Note i used NScalender and components as you exaplined in review . But issue with them is they use system hour time and never set hour to 23. Thats why i have to go with custom string parsed dates.
    NSDate *now = [NSDate date];
    NSString * year = [Utility DateToString:now :@"yyyy"];
    NSString * month = [Utility DateToString:now :@"MM"];
    int day = [[Utility DateToString:now :@"dd"] intValue];
    NSString *dateStr;
    if (day <= 9) {
        dateStr = [NSString stringWithFormat:@"%@-%@-0%dT23:59:00+0000",year,month,day];
    }else{
        dateStr = [NSString stringWithFormat:@"%@-%@-%dT23:59:00+0000",year,month,day];
    }
    NSDate * date = [Utility stringToDate:dateStr];
    NSDateComponents *components = [[[NSDateComponents alloc] init] autorelease];
    [components setDay:1];
    NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDate *newDate2 = [gregorian dateByAddingComponents:components toDate:date options:0];
    NSLog(@"midnight time : %@", newDate2);
    return date;
}
+(NSDate *)dayEndTime{
    NSDate *now = [NSDate date];
    NSString * year = [Utility DateToString:now :@"yyyy"];
    NSString * month = [Utility DateToString:now :@"MM"];
    int day = [[Utility DateToString:now :@"dd"] intValue];
    NSString *dateStr;
    if (day < 9) {
        dateStr = [NSString stringWithFormat:@"%@-%@-0%dT23:59:59+0000",year,month,day];
    }else{
        dateStr = [NSString stringWithFormat:@"%@-%@-%dT23:59:59+0000",year,month,day];
    }
    NSDate * date = [Utility stringToDate:dateStr];
    return date;
}
+(void)downLoadImage :(NSString *)image_url{
    if (image_url!=nil && ![image_url isEqualToString:@""]) {
        image_url = [image_url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSMutableDictionary *images = [Singleton imagesQueue];
        if (![images valueForKey:[Utility returnMD5Hash:image_url]]) {
            //NSLog(@"Adding new");
             NSURL *url = [NSURL URLWithString:image_url];
            [images setValue:image_url forKey:[Utility returnMD5Hash:image_url]];
            ASIHTTPRequest *requestLocal = [ASIHTTPRequest requestWithURL:url];
            /*[requestLocal setDelegate:[Singleton sharedSingleton]];
            [requestLocal setDidFinishSelector:@selector(imageDownloadeSucceeded:)];
            [requestLocal setDidFailSelector:@selector(imageDownloadFailed:)];
             */
            [requestLocal setDelegate:nil];
            [requestLocal setDownloadCache:[ASIDownloadCache sharedCache]];
            [requestLocal setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
            [requestLocal setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
            [requestLocal startAsynchronous];
        }else{
            //NSLog(@"ALready added");
        }
    }
}
+(void)addHtml :(NSString *)data onWebView:(UIWebView *)webView{
	NSMutableString *pageStr = [[@"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n " mutableCopy] autorelease];
	[pageStr appendString:@"<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"en-US\" xml:lang=\"en-US\">\n"];
	
	[pageStr appendString:@"<head>\n"];
	[pageStr appendString:@"<title>MSSNGR</title>\n"];
	[pageStr appendString:@"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\" />\n"];
	[pageStr appendString:@"<link href=\"default.css\" rel=\"stylesheet\" type=\"text/css\" />\n"];
	[pageStr appendString:@"</head>\n"];
	[pageStr appendString:@"<body>\n"];
    if (![data isKindOfClass:[NSNull class]]) {
        [pageStr appendString:data];
    }
	[pageStr appendString:@"</body>\n"];
	[pageStr appendString:@"</html>\n"];
    NSString *path = [[NSBundle mainBundle] bundlePath];
	NSURL *baseURL = [NSURL fileURLWithPath:path];
    [webView  setBackgroundColor:[UIColor clearColor]];
	[webView  setOpaque:NO];
	[webView loadHTMLString:pageStr baseURL:baseURL];
}
+(NSString *) returnMD5Hash:(NSString*)concat {
    const char *concat_str = [concat UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(concat_str, strlen(concat_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}
+(NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    
    return string;
}
+(NSString *)htmlEntityEncode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
    string = [string stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
    string = [string stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    string = [string stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    string = [string stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    
    return string;
}
+(NSString *)mapLink :(NSString *)title Lat:(NSNumber *)lat Lng:(NSNumber *)lng{
    title = [title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    title = [title stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    NSString *latlong=[NSString stringWithFormat:@"%@@%@,%@&ll=%@,%@",title,lat,lng,lat,lng];
	NSString *url = [NSString stringWithFormat: @"http://maps.google.com/maps?q=%@",latlong];
    return url;
}
@end
