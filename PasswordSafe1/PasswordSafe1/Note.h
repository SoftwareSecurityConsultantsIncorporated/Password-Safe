//
//  Note.h
//  PasswordSafe
//
//  Created by CSSE Department on 1/19/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * content;

@end
