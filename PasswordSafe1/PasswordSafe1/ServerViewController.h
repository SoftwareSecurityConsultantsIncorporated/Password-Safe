//
//  ServerViewController.h
//  PasswordSafe1
//
//  Created by CSSE Department on 3/29/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServerViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITextField *ipAddressField;
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)checkSaveIsValid:(id)sender;

@end
