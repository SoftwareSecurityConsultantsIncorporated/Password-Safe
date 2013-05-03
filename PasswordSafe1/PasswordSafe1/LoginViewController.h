//
//  LoginViewController.h
//  PasswordSafe1
//
//  Created by CSSE Department on 3/28/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddLoginViewController.h"
#import "AppDelegate.h"
#import <Foundation/Foundation.h>
@class LoginViewController;

@protocol LoginControllerDelegate

- (void)loginWasSuccessful:(LoginViewController *)controller;

@end

@interface LoginViewController : UIViewController <AddLoginControllerDelegate>

@property (nonatomic, weak) id <LoginControllerDelegate> delegate;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)login:(id)sender;

@end
