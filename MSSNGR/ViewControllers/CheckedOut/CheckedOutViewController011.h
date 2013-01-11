//
//  CheckedOutViewController011.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/20/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckedOutViewController011 : UIViewController{
    IBOutlet UITextView *txtHotelInfo;
    IBOutlet UIWebView *webView;
    IBOutlet UIButton *btnYes;
    IBOutlet UIButton *btnNo;
    
}
-(IBAction)goToParticipatingHotels:(id)sender;
-(IBAction)goToMessages:(id)sender;
@end
