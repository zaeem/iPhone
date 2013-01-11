//
//  PropertyCell.h
//  MSSNGR
//
//  Created by uraan on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConventionsViewController.h"
#import "Convention.h"
#import "ConventionMapper.h"

@interface ConventionCell : UITableViewCell<ConventionMapperCallBacks> {
	IBOutlet UILabel *_cell_Text;
	IBOutlet UIButton *logOut;
    Convention *_convention;
    ConventionMapper *mapper;
    ConventionsViewController *_parent;
}
@property (nonatomic,retain)IBOutlet UILabel *cell_Text;
@property (nonatomic,retain)ConventionsViewController *parent;
@property (nonatomic,assign)Convention *convention;
-(IBAction)logOut:(id)sender;
@end
