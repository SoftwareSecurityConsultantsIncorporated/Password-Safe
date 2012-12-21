//
//  Account.m
//  PasswordSafe
//
//  Created by CSSE Department on 12/20/12.
//  Copyright (c) 2012 Software Security Consultants Incorporated. All rights reserved.
//

#import "Account.h"

@implementation Account
- (id)init {
    self = [super init];
    if (self){
        password = NULL;
        name = NULL;
        site = NULL;
        description = NULL;
    }
    return self;
}

- (id)init: (NSMutableString*) newPassword: (NSMutableString*) newName: (NSMutableString*) newSite: (NSMutableString*) newDescription {
    self = [super init];
    if (self){
        [self setPassword:newPassword];
        [self setName:newName];
        [self setSite:newSite];
        [self setDescription:newDescription];
    }
    return self;
}

-(NSString*) getPassword{
    return password;
}
-(NSString*) getName{
    return name;
}
-(NSString*) getSite{
    return site;
}
-(NSString*) getDescription{
    return description;
}
-(void) setPassword: (NSString*) newPassword{
    [password setString:newPassword];
}
-(void) setName: (NSString*) newName{
    [name setString:newName];
}
-(void) setSite: (NSString*) newSite{
    [site setString:newSite];
}
-(void)setDescription: (NSString*) newDescription{
    [description setString:newDescription];
}
@end
