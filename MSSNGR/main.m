//
//  main.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/11/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char *argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil,  NSStringFromClass([AppDelegate class]));
    [pool release];
    return retVal;
}
