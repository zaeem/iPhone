//
//  ConventionsViewController.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 12/14/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConventionMapper.h"
@interface ConventionsViewController : UIViewController<ConventionMapperCallBacks>{
    IBOutlet UITextField *ConventionCodeTextField;
	ConventionMapper *mapper;
    NSArray *_conventions;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIView *backView;
    IBOutlet UIActivityIndicatorView *loader;
    IBOutlet UILabel *lblAdditionalCode;
    IBOutlet UILabel *lblConventionCode;
    IBOutlet UIButton *btnSubmit;
}
@property(nonatomic,retain) NSArray *conventions;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *loader;
-(void)loginToConvention;
@end
