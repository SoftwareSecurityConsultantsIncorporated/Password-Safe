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
    int actualCaps;
    int actualLowers;
    int actualSpecials;
    int actualNums;
    length = 20;
    for (int i=0; i<=10000; i++) {
        numCaps =  arc4random_uniform(20);
        numLowers = arc4random_uniform(length-numCaps);
        numSpecials = arc4random_uniform(length-numCaps-numLowers);
        numNums = arc4random_uniform(length-numCaps-numLowers-numSpecials);
        [password setString:[test generatePassword: length: numCaps: numLowers: numSpecials: numNums: TRUE: TRUE: TRUE: TRUE]];
        actualCaps = [self countUpperCaseCharacters:password :test];
        actualLowers = [self countLowerCaseCharacters:password :test];
        actualSpecials= [self countSpecialCaseCharacters:password :test];
        actualNums = [self countNumbers:password :test];
        STAssertTrue((actualCaps >= numCaps), @"The caps atribute did not work");
        STAssertTrue((actualLowers >= numLowers), @"The caps atribute did not work");
        STAssertTrue((actualSpecials >= numSpecials), @"The caps atribute did not work");
        STAssertTrue((actualNums >= numNums), @"The caps atribute did not work");
    }
    
    
    [self tearDown];
}

-(int)countUpperCaseCharacters: (NSMutableString*)string: (Generator*) gen{
    int count=0;
    int i=0;
    for (i = 0; i < [string length]; i++) {
        if ([gen isCapital:[string characterAtIndex:i]])
            count++;
    }
    return count;
}
-(int)countLowerCaseCharacters: (NSMutableString*)string: (Generator*) gen{
    int count=0;
    int i=0;
    for (i = 0; i < [string length]; i++) {
        if ([gen isLower:[string characterAtIndex:i]])
            count++;
    }
    return count;
}

-(int)countSpecialCaseCharacters: (NSMutableString*)string: (Generator*) gen{
    int count = 0;
    int i = 0;
    for(i=0; i<[string length]; i++){
        if([gen isSpecial: [string characterAtIndex:i]]){
            count++;
        }
    }
    return count;
}
-(int)countNumbers: (NSMutableString*)string: (Generator*) gen{
    int count = 0;
    int i = 0;
    for(i=0; i<[string length]; i++){
        if([gen isNumber: [string characterAtIndex:i]]){
            count++;
        }
    }
    return count;
}


@end
