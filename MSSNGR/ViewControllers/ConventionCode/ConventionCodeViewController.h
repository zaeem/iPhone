//
//  ConventionCode.h
//  MSSNGR
//
//  Created by uraan on 11/22/11.
//  Copyright 2011 Coeus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConventionMapper.h"


@interface ConventionCodeViewController : UIViewController <ConventionMapperCallBacks>
{
	IBOutlet UITextField *ConventionCodeTextField;
    IBOutlet UILabel *lblConventionCode;    
	IBOutlet UITextView *lostConventionCodeTextView;
	IBOutlet UITextView *ConventionIntroTextView;
	
	ConventionMapper *mapper;
}
@end
