//
//  PreferenceViewController310.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/20/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConventionMapper.h"
#import "UserMapper.h"
#import <MessageUI/MFMailComposeViewController.h>
@interface PreferenceViewController310 : UIViewController <UITableViewDelegate, UITableViewDataSource, ConventionMapperCallBacks,UserMapperCallBacks,MFMailComposeViewControllerDelegate>
{
	IBOutlet UITableView *preferencesTableView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
	ConventionMapper *mapper;
    UserMapper *userMapper;
    Boolean resetPosition;
}
-(void)checkOut;
-(void)rateMSSNGR;
-(void)recommendMSSNGR;
- (void) displayComposerSheet;
-(void)launchMailAppOnDevice;
@end
