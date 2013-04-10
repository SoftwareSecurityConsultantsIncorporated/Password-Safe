//
//  XMLParserDelegate.h
//  PasswordSafe1
//
//  Created by CSSE Department on 3/28/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLParserDelegate : NSObject <NSXMLParserDelegate> {
    NSString *currentElement;
    NSString *timestamp;
}

- (double) getTimestamp;

@end