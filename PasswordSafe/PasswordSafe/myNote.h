//
//  Note.h
//  PasswordSafe
//
//  Created by CSSE Department on 12/20/12.
//  Copyright (c) 2012 Software Security Consultants Incorporated. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Note : NSManagedObject{
@private
    NSMutableString* title;
    NSMutableString* text;
}
-(id)initWithValues: (NSMutableString*) newTitle: (NSMutableString*) newText;

-(NSMutableString*) getTitle;
-(NSMutableString*) getText;
-(void) setTitle: (NSMutableString*) newTitle;
-(void) setText: (NSMutableString*) newText;
-(void) saveNote;

@end
