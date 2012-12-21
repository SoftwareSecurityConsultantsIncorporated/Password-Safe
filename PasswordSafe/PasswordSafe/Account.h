//
//  Account.h
//  PasswordSafe
//
//  Created by CSSE Department on 12/20/12.
//  Copyright (c) 2012 Software Security Consultants Incorporated. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject {
@private
    NSMutableString* password;
    NSMutableString* name;
    NSMutableString* site;
    NSMutableString* description;
}
-(id)init;
-(id)init: (NSMutableString*) newPassword: (NSMutableString*) newName: (NSMutableString*) newSite: (NSMutableString*) newDescription;

-(NSMutableString*) getPassword;
-(NSMutableString*) getName;
-(NSMutableString*) getSite;
-(NSMutableString*) getDescription;
-(void) setPassword: (NSMutableString*) newPassword;
-(void) setName: (NSMutableString*) newName;
-(void) setSite: (NSMutableString*) newSite;
-(void) setDescription: (NSMutableString*) newDescription;

@end