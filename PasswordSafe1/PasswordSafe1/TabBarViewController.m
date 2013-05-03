//
//  TabBarViewController.m
//  PasswordSafe1
//
//  Created by CSSE Department on 2/13/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "TabBarViewController.h"
#import "LoginViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

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
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(![[AppDelegate sharedAppDelegate] getLoggedIn]){
        [self LoginScreePopUp];
    }
    NSLog(@"Fuck you");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginWasSuccessful:(LoginViewController *)controller{
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

-(void)LoginScreePopUp{
    //LoginViewController *LoginScreen = [[LoginViewController alloc] init];
    //LoginScreen.delegate = self;
    //UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:LoginScreen];
//    [self presentViewController:navigationController animated:TRUE completion:nil];
    [self performSegueWithIdentifier:@"showLoginScreen" sender:self];
}
@end
