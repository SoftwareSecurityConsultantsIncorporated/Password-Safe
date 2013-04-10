//
//  Password.m
//  PasswordSafe
//
//  Created by CSSE Department on 1/19/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "Password.h"
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@implementation Password

@dynamic title;
@dynamic username;
@dynamic password;
@dynamic site;
@dynamic pwDescription;

//- (NSString*) description{
//    //return @"Title: " + title + @" Username: " username + @" Password: " password + @" Site: " + site + @" Description: " + pwDescription;
//    return [NSString stringWithFormat:@"Title: %@ Username: %@ Password: %@ Site: %@ Description: %@", title, username, password, site, pwDescription];
//}


@end
