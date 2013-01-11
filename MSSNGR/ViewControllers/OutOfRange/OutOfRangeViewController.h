//
//  OutOfRangeViewController.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/20/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
@interface OutOfRangeViewController : UIViewController<UITextFieldDelegate,SingletonNotification>{
    IBOutlet UIScrollView *scrollView;
    IBOutlet UITextField *cityName;
    IBOutlet UITextField *countryName;
    IBOutlet UIWebView *webView;
    IBOutlet UITextView *lblSorry;
    IBOutlet UITextView *lblInstructions;
    IBOutlet UILabel *lblHotelName;
    IBOutlet UILabel *lblCountry;    
    IBOutlet UILabel *lblCity;
    IBOutlet UIButton *btnShowAll;
    IBOutlet UIButton *btnSendToMSSNGR;
    CGPoint svos;
}
-(IBAction)goToParticipatingHotels:(id)sender;
-(IBAction)goToThankYouForUsingMSSNGRScreen:(id)sender;
-(IBAction)proposeHotel:(id)sender;
@end
