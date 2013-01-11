//
//  CallReceptionViewController400.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/20/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsynchronousImageView.h"
@interface CallReceptionViewController400 : UIViewController
{
	IBOutlet UIWebView *webView;
    IBOutlet UIButton *btnWeb;
    IBOutlet UIButton *btnCall;
    IBOutlet UIButton *btnMap;
    IBOutlet UIView *backView;
    IBOutlet AsynchronousImageView *asyncImage;
}
-(IBAction)callToReception:(id)sender;
-(IBAction)openMapView:(id)sender;
-(IBAction)openWebAddress:(id)sender;
-(void) makeCall;
@end
