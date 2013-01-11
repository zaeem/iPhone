//
//  ImageTableRow.m
//  MSSNGR
//
//  Created by Simon Brückner on 14.12.11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "ImageTableRow.h"
#import "AsynchronousImageView.h"
@implementation ImageTableRow

@synthesize textLabel;
@synthesize thumbImage;
@synthesize url;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization codel
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
