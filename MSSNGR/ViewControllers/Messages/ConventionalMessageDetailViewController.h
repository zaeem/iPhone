//
//  ConventionalMessageDetails112.h
//  MSSNGR
//
//  Created by uraan on 11/23/11.
//  Copyright 2011 Coeus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsynchronousImageView.h"
@class MSSNMessage;

@interface ConventionalMessageDetailViewController : UIViewController {
    IBOutlet UIButton *btnWeb;
    IBOutlet UIButton *btnCall;
    IBOutlet UIButton *btnMap;
    IBOutlet UIButton *btnMark;
    IBOutlet UIButton *btnUnMark;
	IBOutlet UIWebView *webView;
    IBOutlet UIView *backView;
    IBOutlet UILabel *lblTime;
    IBOutlet UILabel *lblNoBookingPossible;
    IBOutlet AsynchronousImageView *asyncImage;
    IBOutlet UIView *contentView;
    MSSNMessage *_message;
}
@property(nonatomic,retain) MSSNMessage *message;
-(IBAction)callHotelButtonAction:(id)sender;
-(IBAction)goToWebsiteButtonAction:(id)sender;
-(IBAction)mapButtonAction:(id)sender;
-(IBAction)markClicked:(id)sender;
-(IBAction)unMarkClicked:(id)sender;
-(void) makeCall;
@end
