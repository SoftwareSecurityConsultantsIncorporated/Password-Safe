//
//  TabBarViewController.h
//  PasswordSafe1
//
//  Created by CSSE Department on 2/13/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface TabBarViewController : UITabBarController <LoginControllerDelegate>

-(void)LoginScreePopUp;

@end
