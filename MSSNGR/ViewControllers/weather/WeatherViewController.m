//
//  WeatherViewController.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/29/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "WeatherViewController.h"
#import "ForecastConditions.h"
#import "Singleton.h"
#import <QuartzCore/QuartzCore.h>
@implementation WeatherViewController
@synthesize reloadWeatherData;
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    mapper =[[WeatherMapper alloc]init];
    reloadWeatherData = TRUE;
    mapper.target=self;
    backView.layer.cornerRadius = 5.0f;
    backView.layer.borderWidth = 0.5f;
    backView.layer.borderColor = [[UIColor grayColor] CGColor];
    // Do any additional setup after loading the view from its nib.
}
-(void)dealloc{
    mapper.target=nil;
    [mapper release];
    mapper=nil;
    [loader release];
    loader = nil;
    [lblDay1 release];
    lblDay1 = nil;
    
    [lblDay2 release];
    lblDay2 = nil;
    
    [lblDay3 release];
    lblDay3 = nil;
    
    [lblLow1 release];
    lblLow1 = nil;
    
    [lblLow2 release];
    lblLow2 = nil;
    
    [lblLow3 release];
    lblLow3 = nil;
    
    [lblHigh1 release];
    lblHigh1 = nil;
    
    [lblHigh2 release];
    lblHigh2 = nil;
    
    [lblHigh3 release];
    lblHigh3 = nil;
    
    [imgIcon1 release];
    imgIcon1 = nil;
    
    [imgIcon2 release];
    imgIcon2 = nil;
    
    [imgIcon3 release];
    imgIcon3 = nil;
    
    [backView release];
    backView=nil;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)reloadWeather{
    if (reloadWeatherData) {
        [loader startAnimating];
    }
    [mapper getWeatherForecast:[Singleton sharedSingleton].curent_city];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)getWeatherSucceeded:(WeatherForecast *)weatherforecast{
    reloadWeatherData = FALSE;
    [weatherforecast retain];
    imgIcon1.image = [UIImage imageNamed:weatherforecast.day1.icon];
    imgIcon2.image = [UIImage imageNamed:weatherforecast.day2.icon];
    imgIcon3.image = [UIImage imageNamed:weatherforecast.day3.icon];
    lblDay1.text=NSLocalizedString(@"Today",@"Today");
    lblDay2.text=weatherforecast.day2.day;
    lblDay3.text=weatherforecast.day3.day;
    
    lblHigh1.text=[NSString stringWithFormat:@"%0.f°",weatherforecast.day1.high];
    lblHigh2.text=[NSString stringWithFormat:@"%0.f°",weatherforecast.day2.high];
    lblHigh3.text=[NSString stringWithFormat:@"%0.f°",weatherforecast.day3.high];
    
    lblLow1.text=[NSString stringWithFormat:@"%0.f°",weatherforecast.day1.low];
    lblLow2.text=[NSString stringWithFormat:@"%0.f°",weatherforecast.day2.low];
    lblLow3.text=[NSString stringWithFormat:@"%0.f°",weatherforecast.day3.low];
    [weatherforecast release];
    [loader stopAnimating];
}
-(void)getWeatherFailed:(NSString *)message{
    [loader stopAnimating];
}
@end
