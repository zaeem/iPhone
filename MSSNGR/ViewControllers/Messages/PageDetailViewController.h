//
//  PageDetailViewController.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/21/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsynchronousImageView.h"
@class Page;
@interface PageDetailViewController : UIViewController{
    Page *_pageDetails;
    IBOutlet UIWebView *webView;
    IBOutlet UIButton *btnMap;
    IBOutlet UIButton *btnWeb;
    IBOutlet UIButton *btnCall;
    IBOutlet UIButton *btnMark;
    IBOutlet UIButton *btnUnMark;
    IBOutlet UIView *backView;
    IBOutlet AsynchronousImageView *asyncImage;
}
@property(nonatomic,retain)Page *pageDetails;
-(IBAction)callHotelButtonAction:(id)sender;
-(IBAction)goToWebsiteButtonAction:(id)sender;
-(IBAction)mapButtonAction:(id)sender;
-(IBAction)backButtonAction;
-(IBAction)markClicked:(id)sender;
-(IBAction)unMarkClicked:(id)sender;
-(void) makeCall;
@end
