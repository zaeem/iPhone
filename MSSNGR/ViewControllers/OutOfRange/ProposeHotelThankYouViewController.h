//
//  ProposeHotelThankYouViewController.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/20/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProposeHotelThankYouViewController : UIViewController{
    IBOutlet UIWebView *webView;
    IBOutlet UIButton *showMore;
}
-(IBAction)goToParticipatingHotels:(id)sender;
@end
