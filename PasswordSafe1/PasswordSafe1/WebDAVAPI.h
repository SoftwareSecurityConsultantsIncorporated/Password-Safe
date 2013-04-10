//
//  WebDAVAPI.h
//  PasswordSafe
//
//  Created by CSSE Department on 1/24/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebDAVAPI : NSObject{
    NSMutableData *receivedData;
    NSString *filepath;
    NSOutputStream *fileStream;
    NSURLConnection *connection;
}

- (void) download;
- (void) upload;

@end
