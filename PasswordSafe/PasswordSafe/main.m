//
//  main.m
//  PasswordSafe
//
//  Created by CSSE Department on 12/12/12.
//  Copyright (c) 2012 Software Security Consultants Incorporated. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "Generator.h"

int main(int argc, char *argv[])
{
    Generator *test = [[Generator alloc] init];
    [test generateWithLength:5 andCaps:3 andLowers:2 andSpecials:0 andNums:0];
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
