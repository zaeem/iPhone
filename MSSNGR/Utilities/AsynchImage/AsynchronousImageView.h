//
//  AsynchronousImageView.h
//  webconsumer
//
//  Created by Muzammil Hussain on 7/27/11.
//  Copyright 2011 Coeus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
@interface AsynchronousImageView : UIImageView<ASIHTTPRequestDelegate>{
    UIActivityIndicatorView *activityIndicator;
    NSString *urlString; // key for image cache dictionary
    ASIHTTPRequest *requestLocal;
}
@property(nonatomic,assign) UIActivityIndicatorView *activityIndicator;
- (void)loadImageFromURLString:(NSString *)theUrlString;
- (void)loadImageFromNSURL:(NSURL *)theUrl;
- (void)loadImageFromFile:(NSString *)filePath;
-(void) showLoader;
-(void) stopLoader;
-(NSString *) returnMD5Hash:(NSString*)concat;
+(NSMutableDictionary *)cachedInMemoryImages;
@end
