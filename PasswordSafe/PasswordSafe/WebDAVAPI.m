//
//  WebDAVAPI.m
//  PasswordSafe
//
//  Created by CSSE Department on 1/24/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "WebDAVAPI.h"

@implementation WebDAVAPI

-(void) download: (id) sender
{
    receivedData = [[NSMutableData alloc] initWithLength:0];
    
    //Create the request
    NSURL* url = [NSURL URLWithString:@"https://sync.omnigroup.com/passwordsync"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection){
        //connection();//TODO fill out this call
    }
    else {
        //connection failed
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [receivedData setLength:0];
}

-(void)connection:(NSURLConnection *)connection
    didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if([challenge previousFailureCount] == 0){
        NSURLCredential *credential = [NSURLCredential credentialWithUser:@"passwordsync"
                                                                 password:@"password"
                                                              persistence:NSURLCredentialPersistenceNone];
        
        [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
    }else{
        [[challenge sender] cancelAuthenticationChallenge:challenge];
        // Display error message: incorrect credentials
    }
}

-(void)connection: (NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

@end
