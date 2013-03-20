//
//  WebDAVAPI.m
//  PasswordSafe
//
//  Created by CSSE Department on 1/24/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "WebDAVAPI.h"
#import "AppDelegate.h"

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
    NSURL *url = [[AppDelegate sharedAppDelegate] getServerURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.];
    
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection){
        //connection();//TODO fill out this call
        NSLog(@"Connecting");
    }
    else {
        //connection failed
        NSLog(@"Connection failed");
    }
}

-(void) upload
{
    // TODO  Fix this method
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    filepath = [cachesDirectory stringByAppendingPathComponent:@"password.txt"];
    
    NSData* fileData = [[NSData alloc] initWithContentsOfFile:filepath];
    //NSInputStream *fileStream = [NSInputStream inputStreamWithFileAtPath:filePath];
    
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
    NSURL *url = [[AppDelegate sharedAppDelegate] getServerURL];
    [request setHTTPMethod:@"PUT"];
    [request setURL:url];
    NSUInteger fileSize = [[[[NSFileManager defaultManager] attributesOfItemAtPath:filepath error:nil] objectForKey:NSFileSize] unsignedIntegerValue];
    [request setValue:[NSString stringWithFormat:@"%u", fileSize] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    //[request setHTTPBodyStream:fileStream];
    [request setHTTPBody:fileData];
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (connection){
        //connection();//TODO fill out this call
        NSLog(@"Connecting");
    }
    else {
        //connection failed
        NSLog(@"Connection failed");
    }
    
    
    // One method of uploading; can't get to work
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *cachesDirectory = [paths objectAtIndex:0];
//    filepath = [cachesDirectory stringByAppendingPathComponent:@"password.txt"];
//    NSURL* url = [NSURL URLWithString:@"https://sync.omnigroup.com/passwordsync/passwordSync/password.txt"];
//    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
//    [request setURL:url];
//    [request setHTTPMethod:@"POST"];
//    NSString *boundary = @"---------------------------14737809831466499882746641449";
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
//    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
//    NSMutableData *postbody = [NSMutableData data];
//    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@.jpg\"\r\n", @"password.txt"] dataUsingEncoding:NSUTF8StringEncoding]];
//    [postbody appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//    NSData* fileData = [[NSData alloc] initWithContentsOfFile:filepath];
//    [postbody appendData:[NSData dataWithData:fileData]];
//    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [request setHTTPBody:postbody];
//    
//    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
//    assert(connection != nil);
//    
//    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//    NSLog(@"Return string: %@", returnString);
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"Received response");
    
    [receivedData setLength:0];
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    assert( [httpResponse isKindOfClass:[NSHTTPURLResponse class]] );
    if ((httpResponse.statusCode / 100) != 2) {
        NSLog(@"HTTP error %zd", (ssize_t) httpResponse.statusCode);
    } else {
        NSString *fileType;
        
        fileType = [[httpResponse MIMEType] lowercaseString];
        if (fileType == nil) {
            NSLog(@"No content type");
        } else if ([fileType isEqual:@"text/plain"]) {
            NSLog(@"Unsupported Content type: %@", fileType);
        } else {
            NSLog(@"Response OK");
        }
    }
}

-(void)connection:(NSURLConnection *)connection
    didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSLog(@"Received Authentication Challenge");
    
    if([challenge previousFailureCount] == 0){
        NSURLCredential *credential = [NSURLCredential credentialWithUser:@"passwordsync"
                                                                 password:@"password"
                                                              persistence:NSURLCredentialPersistenceNone];
        
        [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
    }else{
        [[challenge sender] cancelAuthenticationChallenge:challenge];
        // Display error message: incorrect credentials
        NSLog(@"Authentication failed");
    }
}

-(void)connection: (NSURLConnection *)conn didReceiveData:(NSData *)data
{
    if(![[[conn originalRequest] HTTPMethod] isEqualToString:@"POST"]) {
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
                NSLog(@"File write error");
                break;
            } else {
                bytesWrittenSoFar += bytesWritten;
            }
        } while (bytesWrittenSoFar != dataLength);
        NSString* content = [NSString stringWithContentsOfFile:filepath
                                                      encoding:NSUTF8StringEncoding
                                                         error:NULL];
        NSLog(@"Get data: %@", content);
    } else {
        // TODO  Figure out what to do here if it is a post
    }

}

- (void)connection:(NSURLConnection *)conn didFailWithError:(NSError *)error
{    
    NSLog(@"didFailWithError %@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn
{
    NSLog(@"connectionDidFinishLoading");
}

@end
