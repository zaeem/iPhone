//
//  LogOutConvention.h
//  MSSNGR
//
//  Created by uraan on 11/22/11.
//  Copyright 2011 Coeus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConventionMapper.h"

@interface LogOutConventionViewController : UIViewController<ConventionMapperCallBacks>
{
	IBOutlet UITextView *LogOutConventionTextView;
    ConventionMapper *mapper;
}

-(IBAction)LogOutConventionAction:(id)sender;
-(IBAction)backButtonAction;

@end
