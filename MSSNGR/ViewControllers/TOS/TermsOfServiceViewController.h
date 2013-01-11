//
//  termsOfService.h
//  MSSNGR
//
//  Created by uraan on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface TermsOfServiceViewController : UIViewController<SingletonNotification> {
    IBOutlet UIButton *btnAccept;
    IBOutlet UIView *backView;
    IBOutlet UIWebView *webView;
}

-(IBAction)acceptTermsAction:(id)sender;
-(IBAction)nextButtonAction:(id)sender;
@end
