//
//  PropertyCell.h
//  MSSNGR
//
//  Created by uraan on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParticipatingHotelsViewController.h"
#import "Hotel.h"


@interface PropertyCell : UITableViewCell {
	IBOutlet UILabel *cell_Text;
	IBOutlet UIButton *checkIn;
	IBOutlet UIButton *detail;
    Hotel *_hotel;
}
@property (nonatomic,retain)IBOutlet UILabel *cell_Text;
@property (nonatomic,retain)IBOutlet UIButton *checkIn;
@property (nonatomic,retain)IBOutlet UIButton *detail;
@property (nonatomic,retain)ParticipatingHotelsViewController *parent;
@property (nonatomic,assign)Hotel *hotel;
-(IBAction)hotelDetails:(id)sender;
-(IBAction)checkInDetails:(id)sender;

@end
