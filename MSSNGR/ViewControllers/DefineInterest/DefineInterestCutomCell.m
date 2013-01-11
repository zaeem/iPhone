//
//  DefineInterestCutomCell.m
//  MSSNGR
//
//  Created by uraan on 11/18/11.
//  Copyright 2011 Coeus Solutions. All rights reserved.
//

#import "DefineInterestCutomCell.h"
#import "DefineInterestsViewController.h"
#import "InterestGroup.h"
@implementation DefineInterestCutomCell
@synthesize interestText;
@synthesize interestSwitch;
@synthesize interest;
@synthesize parent;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}
-(IBAction)valueChanged:(id)sender{
    self.interest.selected = self.interestSwitch.on;
}
@end
