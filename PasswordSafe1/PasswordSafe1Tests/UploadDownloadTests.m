//
//  UploadDownloadTests.m
//  PasswordSafe1
//
//  Created by CSSE Department on 3/24/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "UploadDownloadTests.h"

@implementation UploadDownloadTests

- (void)setUp
{
    [super setUp];
    
    test = [[WebDAVAPI alloc] init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    filepath = [cachesDirectory stringByAppendingPathComponent:@"password.txt"];
}

- (void)tearDown
{
    free(&test);
    free(&filepath);
    [super tearDown];
}

- (void) testUploadAndDownload {
    [self setUp];
    
    NSString *server = @"server";
    NSString *local = @"local";
    NSString *content;

    [server writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    [test upload];
    
    [local writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    [test download];
    
    content = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:NULL];
    
    STAssertEqualObjects(server, content, @"Did not upload then download correctly");
    
    [self tearDown];
}

@end
