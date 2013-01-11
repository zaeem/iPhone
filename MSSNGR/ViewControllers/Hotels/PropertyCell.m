//
//  PropertyCell.m
//  MSSNGR
//
//  Created by uraan on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PropertyCell.h"
#import "HotelDetailViewController.h"


@implementation PropertyCell
@synthesize checkIn;
@synthesize detail;
@synthesize cell_Text;
@synthesize parent;
@synthesize hotel=_hotel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}
-(IBAction)hotelDetails:(id)sender{
	
	[self.parent detailHotels:_hotel];
}

-(IBAction)checkInDetails:(id)sender
{
	[self.parent checkInHotel:_hotel];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
   }


- (void)dealloc {
	[checkIn release];
	[detail release];
	[cell_Text release];
    [super dealloc];
}


@end
