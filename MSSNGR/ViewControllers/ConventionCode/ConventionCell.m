//
//  PropertyCell.m
//  MSSNGR
//
//  Created by uraan on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ConventionCell.h"
#import "Singleton.h"
@implementation ConventionCell
@synthesize cell_Text=_cell_Text;
@synthesize parent=_parent;
@synthesize convention=_convention;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}
-(IBAction)logOut:(id)sender{
    [_parent.loader startAnimating];
    if (!mapper) {
        mapper = [[ConventionMapper alloc]init];
        mapper.target=self;
    }
    [mapper checkOutConvention:[Singleton sharedSingleton].appUser.token Code:_convention.code];
}
- (void)dealloc {
    mapper.target = nil;
	[logOut release];
	[_cell_Text release];
    [mapper release];
    [super dealloc];
}
-(void)checkOutConventionSucceeded:(Result *)result{
    [_parent.loader stopAnimating];
    [_parent.navigationController popViewControllerAnimated:YES];
}
-(void)checkOutConventionFailed:(Result *)result{
    [_parent.loader stopAnimating];
    [_parent.navigationController popViewControllerAnimated:YES];
}
@end
