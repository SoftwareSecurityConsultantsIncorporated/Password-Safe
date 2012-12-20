//
//  Generator.h
//  PasswordSafe
//
//  Created by CSSE Department on 12/13/12.
//  Copyright (c) 2012 Software Security Consultants Incorporated. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Generator : NSObject {
    @public
    NSArray* charPool;
}
-(id)init;

-(NSString*) generatePassword: (int) length: (int) numCaps: (int) numLowers: (int) numSpecials: (int) numNums;

-(NSMutableArray*) knuthShuffle: (NSMutableArray*) password: (int)length;

@end
