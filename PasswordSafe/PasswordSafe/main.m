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
    for (int i = 0; i < 5; i++) {
    NSString *testString = [test generatePassword:8 :1 :3 :2 :2];
    NSLog(testString);
    }
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
