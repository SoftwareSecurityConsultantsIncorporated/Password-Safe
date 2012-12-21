//
//  Note.m
//  PasswordSafe
//
//  Created by CSSE Department on 12/20/12.
//  Copyright (c) 2012 Software Security Consultants Incorporated. All rights reserved.
//

#import "Note.h"

@implementation Note
- (id)init {
    self = [super init];
    if (self){
        title = NULL;
        text = NULL;
    }
    return self;
}

- (id)init: (NSMutableString*) newTitle: (NSMutableString*) newText {
    self = [super init];
    if (self){
        [self setTitle:newTitle];
        [self setText:newText];
    }
    return self;
}

-(NSMutableString*) getTitle{
    return title;
}
-(NSMutableString*) getText{
    return text;
}
-(void) setTitle: (NSString*) newTitle{
    [title setString:newTitle];
}
-(void)setText: (NSString*) newText{
    [text setString:newText];
}

-(void) saveNote{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"note.txt"];
    
    
    NSMutableString *str = [[NSMutableString alloc] initWithString:@"title"];
    [str appendString:@"\n"];
    [str appendString:@"text"];
    [str appendString:@"\n"];
    
    [str writeToFile:filePath atomically:TRUE encoding:NSUTF8StringEncoding error:NULL];
}

@end
