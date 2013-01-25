//
//  GeneratorTest.h
//  PasswordSafe
//
//  Created by CSSE Department on 1/19/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//
#import "Generator.h"
#ifndef PasswordSafe_GeneratorTest_h
#define PasswordSafe_GeneratorTest_h
@interface GeneratorTest : SenTestCase {
@private
    Generator *test;
    NSMutableString *password;
    int length;
    int numCaps;
    int numLowers;
    int numSpecials;
    int numNums;
    
}
@end


#endif
