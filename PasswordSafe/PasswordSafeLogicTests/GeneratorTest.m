//
//  GeneratorTest.m
//  PasswordSafe
//
//  Created by CSSE Department on 1/19/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//
#import <SenTestingKit/SenTestingKit.h>
#import "GeneratorTest.h"
#import "Generator.h"



@implementation GeneratorTest

- (void)setUp
{    
    test = [[Generator alloc] init];
    password = [[NSMutableString alloc] init];
    
}

- (void)tearDown
{
    free(&test);
    free(&password);
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
    int i;
    for(i=0; i<9999; i++){
        length = arc4random_uniform(20);
        numCaps =  arc4random_uniform(length);
        numLowers = arc4random_uniform(length-numCaps);
        numSpecials = arc4random_uniform(length-numCaps-numLowers);
        numNums = arc4random_uniform(length-numCaps-numLowers-numSpecials);
    
        [password setString:[test generatePassword: length: numCaps: numLowers: numSpecials: numNums: TRUE: TRUE: TRUE: TRUE]];
        if(numCaps>[test countUpperCaseCharacters:password]){
            STFail(@"Password generated did not contain at least the number specified of capitals");
        }
        if(length != [password length]){
            STFail(@"Password generated did not contain at least the number specified of length");
        }if(numLowers>[test countLowerCaseCharacters:password]){
            STFail(@"Password generated did not contain at least the number specified of low case");
        }if(numSpecials>[test countSpecialCaseCharacters:password]){
            STFail(@"Password generated did not contain at least the number specified of special characters");
        }if(numNums>[test countNumbers:password]){
            STFail(@"Password generated did not contain at least the number specified of numbers");
        }
    }

    [self tearDown];
}



@end

