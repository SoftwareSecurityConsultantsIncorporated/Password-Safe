//
//  GeneratorTests.m
//  GeneratorTests
//
//  Created by CSSE Department on 1/17/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "GeneratorTests.h"
#import <SenTestingKit/SenTestingKit.h>
#import "Generator.h"
#import "AppDelegate.h"
#import "Note.h"
#import "Password.h"


@implementation GeneratorTests

- (void)setUp
{
    [super setUp];
    
    test = [[Generator alloc] init];
    password = [[NSMutableString alloc] init];
    
    }

- (void)tearDown
{
    free(&test);
    free(&password);
    [super tearDown];
}

- (void)testBlank
{
    [self setUp];
    length = 0;
    numCaps = 0;
    numLowers = 0;
    numSpecials = 0;
    numNums = 0;
    
    [password setString:[test generatePassword: length: numCaps: numLowers: numSpecials: numNums: TRUE: TRUE: TRUE: TRUE]];
    
    STAssertEqualObjects(password, @"", @"The generator did not return a blank string.");
    [self tearDown];
}

- (void)testVarious
{
    [self setUp];
    length = 20;
    numCaps =  arc4random_uniform(20);
    numLowers = 0;
    numSpecials = 0;
    numNums = 0;
    
    
    
    [password setString:[test generatePassword: length: numCaps: numLowers: numSpecials: numNums: TRUE: TRUE: TRUE: TRUE]];

    [self tearDown];
}


@end
