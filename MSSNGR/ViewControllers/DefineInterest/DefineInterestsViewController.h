//
//  DefineIntrests.h
//  MSSNGR
//
//  Created by uraan on 11/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InterestMapper.h"
@interface DefineInterestsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,InterestMapperCallBacks> {
	NSMutableArray *_all_interest_groups;
	NSString *userToken;
	IBOutlet UITableView *tblInterest;
	NSMutableArray *_userInterest;
    InterestMapper *mapper;
    IBOutlet UIActivityIndicatorView *loader;
    IBOutlet UILabel *lblPleaseDefine;
}
@property (nonatomic,retain) NSMutableArray *all_interest_groups;
@property (nonatomic,retain) NSMutableArray *userInterest;
@property (nonatomic,retain)NSString *userToken;
-(IBAction)nextButtonAction;
-(IBAction)backButtonAction;
@end
