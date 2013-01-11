//
//  CheckedOutCurrentHotel.h
//  MSSNGR
//
//  Created by uraan on 11/22/11.
//  Copyright 2011 Coeus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserMapper.h"

@interface CheckOutViewController : UIViewController <UserMapperCallBacks>
{
	UserMapper *mapper;
	NSInteger p_id;
	IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UIWebView *webView;
}

@property(nonatomic,readwrite) NSInteger p_id;

-(IBAction)CheckedOutButtonAction:(id)sender;
-(IBAction)cancelButtonAction:(id)sender;

@end
