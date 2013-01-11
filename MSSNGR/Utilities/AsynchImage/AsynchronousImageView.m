//
//  AsynchronousImageView.m
//  webconsumer
//
//  Created by Muzammil Hussain on 7/27/11.
//  Copyright 2011 Coeus Solutions. All rights reserved.
//

#import "AsynchronousImageView.h"
#import "ASIDownloadCache.h"
#import <CommonCrypto/CommonDigest.h>
@implementation AsynchronousImageView
@synthesize activityIndicator;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //[self setContentMode:UIViewContentModeScaleAspectFit];
    }
    return self;
}
-(void)dealloc{
    if (requestLocal) {
        [requestLocal clearDelegatesAndCancel];
    }
    requestLocal = nil;
    activityIndicator = nil;
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
-(void) showLoader{
    if(activityIndicator == nil){
        activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:activityIndicator];
        activityIndicator.frame = CGRectMake(self.bounds.size.width / 2.0f - activityIndicator.frame.size.width /2.0f, self.bounds.size.height / 2.0f - activityIndicator.frame.size.height /2.0f, activityIndicator.frame.size.width, activityIndicator.frame.size.height);
        [activityIndicator release];
    }
    [activityIndicator startAnimating];
}
-(void) stopLoader{
    if(activityIndicator){
        [activityIndicator stopAnimating];
        [activityIndicator removeFromSuperview];
        activityIndicator = nil;
    }
}
- (void)loadImageFromFile:(NSString *)filePath{
    [self setImage:[UIImage imageNamed:filePath]];
    //[self stopLoader];
}
- (void)loadImageFromURLString:(NSString *)theUrlString
{
    if (![theUrlString isEqualToString:@""] && ![theUrlString isKindOfClass:[NSNull class]]) {
        [self showLoader];
        theUrlString = [theUrlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSURL *url = [NSURL URLWithString:theUrlString];
        [self loadImageFromNSURL:url];
    }
}

- (void)loadImageFromNSURL:(NSURL *)theUrl
{
    UIImage *cahcedImage = [[AsynchronousImageView cachedInMemoryImages] valueForKey:[self returnMD5Hash:[theUrl path]]];
    if (cahcedImage) {
        [self stopLoader];
        self.image = cahcedImage;
    }else{
 
        requestLocal = nil;
        requestLocal = [ASIHTTPRequest requestWithURL:theUrl];
        [requestLocal setDelegate:self];
        [requestLocal setDidFailSelector:@selector(requestFailed:)];
        [requestLocal setDownloadCache:[ASIDownloadCache sharedCache]];
        [requestLocal setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
        [requestLocal setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
        [requestLocal startAsynchronous];
}
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    requestLocal = nil;
    [self stopLoader];
    @try {
        [[AsynchronousImageView cachedInMemoryImages] setObject:[UIImage imageWithData:[request responseData]] forKey:[self returnMD5Hash:[request.url path]]];
        self.image = [[AsynchronousImageView cachedInMemoryImages] valueForKey:[self returnMD5Hash:[request.url path]]];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    requestLocal = nil;
    [self stopLoader];
}
//generate md5 hash from string
-(NSString *) returnMD5Hash:(NSString*)concat {
    const char *concat_str = [concat UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(concat_str, strlen(concat_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}
+(NSMutableDictionary *)cachedInMemoryImages{
    static  NSMutableDictionary *cachedImages;
    if (cachedImages == nil) {
        cachedImages = [[NSMutableDictionary alloc]init];
    }
    if ([cachedImages allKeys].count > 100) {
        [cachedImages removeAllObjects];
    }
    return cachedImages;
}
@end
