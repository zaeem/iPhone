//
//  Helper.h
//  GridCab
//
//  Created by Ahsan on 3/7/11.
//  Copyright 2011 Uraan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject {

}

+ (BOOL) isFileExists:(NSString *)fileName;

+ (NSString *) filePath:(NSString *)fileName;
+(BOOL) deleteFile:(NSString *)fileName;
+ (BOOL) writeFileToDisk:(NSDictionary *)data :(NSString *)fileName;
+ (NSDictionary *) readFileFromDisk:(NSString *)fileName;
+(NSMutableArray *)readStarMessages;
+ (BOOL) writeMessagesToDisk:(NSMutableArray *)data;
+(NSMutableArray *)readStarPages;
+ (BOOL) writePagesToDisk:(NSMutableArray *)data;
+(NSString *)readStringDataFromFile:(NSString *)fileName :(NSString *)type;
@end
