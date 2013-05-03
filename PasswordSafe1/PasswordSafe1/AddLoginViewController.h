//
//  AddLoginViewController.h
//  PasswordSafe1
//
//  Created by CSSE Department on 5/1/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "AppDelegate.h"
#import <Foundation/Foundation.h>
@class AddLoginViewController;

@protocol AddLoginControllerDelegate

- (void)theCreateButtonOnTheAddLoginViewControllerWasTapped:(AddLoginViewController *)controller;

@end

@interface AddLoginViewController : UIViewController

@property (nonatomic, weak) id <AddLoginControllerDelegate> delegate;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordCheckTextField;

- (IBAction)save:(id)sender;

@end
