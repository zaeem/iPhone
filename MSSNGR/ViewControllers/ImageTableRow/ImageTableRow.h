//
//  ImageTableRow.h
//  MSSNGR
//
//  Created by Simon Brückner on 14.12.11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AsynchronousImageView;
@interface ImageTableRow : UITableViewCell {
  IBOutlet AsynchronousImageView *thumbImage;
  IBOutlet UILabel *textLabel;
  NSString* url;
}

@property (nonatomic,retain) IBOutlet AsynchronousImageView *thumbImage;
@property (nonatomic,retain) IBOutlet UILabel *textLabel;
@property (nonatomic,retain) NSString* url;

@end

