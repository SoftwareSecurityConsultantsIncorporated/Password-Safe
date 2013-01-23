//
//  Password.m
//  PasswordSafe
//
//  Created by CSSE Department on 12/20/12.
//  Copyright (c) 2012 Software Security Consultants Incorporated. All rights reserved.
//

#import "Password.h"

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

-(NSMutableString*) getPassword{
    return password;
}
-(NSMutableString*) getName{
    return name;
}
-(NSMutableString*) getSite{
    return site;
}
-(NSMutableString*) getDescription{
    return description;
}
-(void) setPassword: (NSMutableString*) newPassword{
    [password setString:newPassword];
}
-(void) setName: (NSMutableString*) newName{
    [name setString:newName];
}
-(void) setSite: (NSMutableString*) newSite{
    [site setString:newSite];
}
-(void)setDescription: (NSMutableString*) newDescription{
    [description setString:newDescription];
}
@end
