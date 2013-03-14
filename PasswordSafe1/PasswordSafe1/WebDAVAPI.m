//
//  WebDAVAPI.m
//  PasswordSafe
//
//  Created by CSSE Department on 1/24/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "WebDAVAPI.h"

@implementation WebDAVAPI

-(void) download
{
    receivedData = [[NSMutableData alloc] initWithLength:0];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    filepath = [cachesDirectory stringByAppendingPathComponent:@"password.txt"];
    
    fileStream = [NSOutputStream outputStreamToFileAtPath:filepath append:NO];
    assert(fileStream != nil);
    
    [fileStream open];
    
    //Create the request
    NSURL* url = [NSURL URLWithString:@"https://sync.omnigroup.com/passwordsync/passwordSync/password.txt"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.];
    
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection){
        //connection();//TODO fill out this call
    }
    else {
        //connection failed
    }
}

-(void) upload
{
    
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

-(void)connection: (NSURLConnection *)conn didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
    NSInteger       dataLength;
    const uint8_t * dataBytes;
    NSInteger       bytesWritten;
    NSInteger       bytesWrittenSoFar;
    
    assert(conn == connection);
    
    dataLength = [data length];
    dataBytes  = [data bytes];
    
    bytesWrittenSoFar = 0;
    do {
        bytesWritten = [fileStream write:&dataBytes[bytesWrittenSoFar] maxLength:dataLength - bytesWrittenSoFar];
        assert(bytesWritten != 0);
        if (bytesWritten == -1) {
            break;
        } else {
            bytesWrittenSoFar += bytesWritten;
        }
    } while (bytesWrittenSoFar != dataLength);
    NSString* content = [NSString stringWithContentsOfFile:filepath
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSLog(@"Data: %@", content);

}

- (IBAction)down:(id)sender
{
    NSLog(@"Downloading");
    
    [self download];
}

@end
