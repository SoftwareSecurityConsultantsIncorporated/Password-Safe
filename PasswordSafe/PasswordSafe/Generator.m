//
//  Generator.m
//  PasswordSafe
//
//  Created by CSSE Department on 12/13/12.
//  Copyright (c) 2012 Software Security Consultants Incorporated. All rights reserved.
//

#import "Generator.h"
// Tyler was here
@implementation Generator

- (id)init {
    self = [super init];
    return self;
}

-(NSString*)generateWithLength:(int)length andCaps:(int)numCaps andLowers:(int)numLowers andSpecials:(int)numSpecials andNums:(int)numNums{
    NSString *password = [[NSString alloc] init];
    password = @"PASSWORD";
    return password;
}
@end
