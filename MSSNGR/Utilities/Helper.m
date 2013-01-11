//
//  Helper.m
//  GridCab
//
//  Created by Ahsan on 3/7/11.
//  Copyright 2011 Uraan. All rights reserved.
//

#import "Helper.h"
#import "Hotel.h"

@implementation Helper

+ (NSString *) filePath:(NSString *)fileName{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    if ([paths count] > 0)
    {
        NSString *docPath = [paths objectAtIndex:0];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",docPath,fileName];
        return filePath;
    }
    return nil;
}
+ (BOOL) isFileExists:(NSString *)fileName{
	NSFileManager *fm =[NSFileManager defaultManager];
	return [fm fileExistsAtPath:[self filePath:fileName]];
	
}
+(BOOL) deleteFile:(NSString *)fileName{
    if([self isFileExists:fileName]){
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error;
        BOOL success = [fileManager removeItemAtPath:[self filePath:fileName] error:&error];
        if (!success) NSLog(@"Error: %@", [error localizedDescription]);
        return success;
    }else{
        return false;
    }
}
+ (BOOL) writeFileToDisk:(NSDictionary *)data :(NSString *)fileName{
	return [data writeToFile:[self filePath:fileName]atomically:NO];
}
+ (NSDictionary *) readFileFromDisk:(NSString *)fileName{
    if(![self isFileExists:fileName])
        return nil;
	return [NSDictionary dictionaryWithContentsOfFile:[self filePath:fileName]];
}
+ (BOOL) writeMessagesToDisk:(NSMutableArray *)data{
	return [data writeToFile:[self filePath:@"star_messages.plist"]atomically:NO];
}

+(NSMutableArray *)readStarMessages{
    if(![self isFileExists:@"star_messages.plist"])
        return [[[NSMutableArray alloc]init]autorelease];
	return [NSMutableArray arrayWithContentsOfFile:[self filePath:@"star_messages.plist"]];
}
+ (BOOL) writePagesToDisk:(NSMutableArray *)data{
	return [data writeToFile:[self filePath:@"star_pages.plist"]atomically:NO];
}

+(NSMutableArray *)readStarPages{
    if(![self isFileExists:@"star_pages.plist"])
        return [[[NSMutableArray alloc]init]autorelease];
	return [NSMutableArray arrayWithContentsOfFile:[self filePath:@"star_pages.plist"]];
}
+(NSString *)readStringDataFromFile:(NSString *)fileName :(NSString *)type{
    NSString* path = [[NSBundle mainBundle] pathForResource:fileName 
                                                     ofType:type];
	NSStringEncoding encoding;
   return [NSString stringWithContentsOfFile:path usedEncoding:&encoding error:nil];
}
@end
