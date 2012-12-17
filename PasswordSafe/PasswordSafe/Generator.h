//
//  Generator.h
//  PasswordSafe
//
//  Created by CSSE Department on 12/13/12.
//  Copyright (c) 2012 Software Security Consultants Incorporated. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Generator : NSObject {
}

-(NSString*) generateWithLength: (int) length
                andCaps: (int) numCaps
                andLowers: (int) numLowers
                andSpecials: (int) numSpecials
                andNums: (int) numNums;

@end
