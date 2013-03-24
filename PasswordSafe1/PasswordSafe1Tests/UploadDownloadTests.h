//
//  UploadDownloadTests.h
//  PasswordSafe1
//
//  Created by CSSE Department on 3/24/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "WebDAVAPI.h"

@interface UploadDownloadTests : SenTestCase {
    @public
    WebDAVAPI *test;
    NSString *filepath;
}

@end
