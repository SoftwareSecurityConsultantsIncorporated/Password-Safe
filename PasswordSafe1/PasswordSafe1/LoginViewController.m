//
//  LoginViewController.m
//  PasswordSafe1
//
//  Created by CSSE Department on 3/28/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize usernameField = __usernameField;
@synthesize passwordField = __passwordField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)theCreateButtonOnTheAddLoginViewControllerWasTapped:(AddLoginViewController *)controller{
    [controller.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^(void){
        NSLog(@"Dismissed");
    }];
}



@end
