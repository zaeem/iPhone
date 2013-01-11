//
//  DefineInterestCutomCell.h
//  MSSNGR
//
//  Created by uraan on 11/18/11.
//  Copyright 2011 Coeus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interest.h"
@class DefineInterestsViewController;
@interface DefineInterestCutomCell : UITableViewCell {

}
@property (nonatomic,assign) DefineInterestsViewController *parent;
@property (nonatomic,assign) Interest *interest;
@property (nonatomic,retain) IBOutlet UILabel *interestText;
@property (nonatomic,retain) IBOutlet UISwitch *interestSwitch;
-(IBAction)valueChanged:(id)sender;
@end
