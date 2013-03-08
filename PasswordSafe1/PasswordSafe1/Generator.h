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

-(NSMutableString*) generatePassword: (int) length: (int) numCaps: (int) numLowers: (int) numSpecials: (int) numNums:
(Boolean) caps: (Boolean) lowers: (Boolean) specs: (Boolean) nums;

-(NSMutableArray*)knuthShuffle: (NSMutableArray *)password: (int)length;

-(Boolean)isCapital: (int)ascii;

-(Boolean)isLower: (int)ascii;

-(Boolean)isSpecial: (int)ascii;

-(Boolean)isNumber: (int)ascii;
-(int)countUpperCaseCharacters: (NSMutableString*)string;
-(int)countLowerCaseCharacters: (NSMutableString*)string;
-(int)countSpecialCaseCharacters: (NSMutableString*)string;
-(int)countNumbers: (NSMutableString*)string;

@end


