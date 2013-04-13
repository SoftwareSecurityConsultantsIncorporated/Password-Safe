//
//  XMLParserDelegate.m
//  PasswordSafe1
//
//  Created by CSSE Department on 3/28/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "XMLParserDelegate.h"
#import "Password.h"
#import "Note.h"
#import "AppDelegate.h"

@implementation XMLParserDelegate

-(void)parserDidStartDocument:(NSXMLParser *)parser {
    passwords = [NSMutableArray array];
    notes = [NSMutableArray array];
}

-(void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"Finished parsing document");
    [parser abortParsing];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    currentElement = elementName;
    
    if([currentElement isEqualToString:@"passwordEntry"]){
        Password *password = [NSEntityDescription insertNewObjectForEntityForName:@"Password"
                                                           inManagedObjectContext:[[AppDelegate sharedAppDelegate] managedObjectContext]];
        [passwords addObject:password];
    }
    if([currentElement isEqualToString:@"noteEntry"]){
        Note *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note"
                                                   inManagedObjectContext:[[AppDelegate sharedAppDelegate] managedObjectContext]];
        [notes addObject:note];
    }
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if([elementName isEqualToString:@"timestamp"]){
        if(justNeedTimestamp){ [self parserDidEndDocument:parser]; }
    }
    currentElement = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([currentElement isEqualToString:@"timestamp"]) {
        timestamp = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if([currentElement isEqualToString:@"passwordTitle"]){
        [[passwords lastObject] setTitle:string];
    }
    if([currentElement isEqualToString:@"username"]){
        [[passwords lastObject] setUsername:string];
    }
    if([currentElement isEqualToString:@"password"]){
        [[passwords lastObject] setPassword:string];
    }
    if([currentElement isEqualToString:@"site"]){
        [[passwords lastObject] setSite:string];
    }
    if([currentElement isEqualToString:@"description"]){
        [[passwords lastObject] setPwDecscription:string];
    }
    if([currentElement isEqualToString:@"noteTitle"]){
        [[notes lastObject] setTitle:string];
    }
    if([currentElement isEqualToString:@"content"]){
        [[notes lastObject] setContent:string];
    }
}

// error handling
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"XMLParser error: %@", [parseError localizedDescription]);
}

-(void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
    NSLog(@"XMLParser error: %@", [validationError localizedDescription]);
}

- (double) getTimestamp
{
    return [timestamp doubleValue];
}

- (void) setJustNeedTimestamp
{
    justNeedTimestamp = TRUE;
}

@end
