//
//  GeneratorTests.h
//  GeneratorTests
//
//  Created by CSSE Department on 1/17/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "Generator.h"

#import "AppDelegate.h"
#import "Note.h"
#import "Password.h"

@interface GeneratorTests : SenTestCase{
    @public
    int length;
    int numCaps;
    int numLowers;
    int numSpecials;
    int numNums;
    Generator *test;
    NSMutableString *password;
}

@end
