//
//  ServerViewController.h
//  PasswordSafe1
//
//  Created by CSSE Department on 4/12/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServerViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *URLTextField;
@property (strong, nonatomic) IBOutlet UITextField *UsernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *PasswordTextField;

- (IBAction)saveData:(id)sender;
- (void)SaveIsValidPopup;
- (void)SaveIsInvalidPopup;

@end
