//
//  detailParticipatingHotels.h
//  MSSNGR
//
//  Created by uraan on 11/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hotel.h"
#import "AsynchronousImageView.h"
@interface HotelDetailViewController : UIViewController<UIAlertViewDelegate> 
{
	IBOutlet UIWebView *participatingHotelsDetailWebView;
    IBOutlet UIButton *btnWeb;
    IBOutlet UIButton *btnCall;
    IBOutlet UIButton *btnMap;
    IBOutlet UIView *backView;
    IBOutlet AsynchronousImageView *asyncImage;
}
@property (nonatomic,retain)Hotel *hotelObj;
-(IBAction)callHotelButtonAction:(id)sender;
-(IBAction)goToWebsiteButtonAction:(id)sender;
-(IBAction)mapButtonAction:(id)sender;
-(IBAction)backButtonAction:(id)sender;
-(IBAction)nextButtonAction:(id)sender;
-(void) makeCall;
@end
