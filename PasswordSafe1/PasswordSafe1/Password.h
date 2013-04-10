//
//  Password.h
//  PasswordSafe
//
//  Created by CSSE Department on 1/19/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Password : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * site;
@property (nonatomic, retain) NSString * pwDecscription;

@end
