//
//  User.h
//  PasswordSafe1
//
//  Created by CSSE Department on 5/1/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * masterUsername;
@property (nonatomic, retain) NSString * masterPassword;
@property (nonatomic, retain) NSString * serverURL;
@property (nonatomic, retain) NSString * serverUsername;
@property (nonatomic, retain) NSString * serverPassword;

@end
