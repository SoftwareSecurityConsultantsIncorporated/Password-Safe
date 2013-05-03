//
//  ServerViewController.m
//  PasswordSafe1
//
//  Created by CSSE Department on 4/12/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "ServerViewController.h"
#import "WebDAVAPI.h"
#import "AppDelegate.h"

@interface ServerViewController ()

@end

@implementation ServerViewController

@synthesize URLTextField = __URLTextField;
@synthesize UsernameTextField = __UsernameTextField;
@synthesize PasswordTextField = __PasswordTextField;

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

-(IBAction)saveData:(id)sender{
    NSString *previousURL = [[[AppDelegate sharedAppDelegate] getServerURL] absoluteString];
    NSString *previousUsername = [[AppDelegate sharedAppDelegate] getUsername];
    NSString *previousPassword = [[AppDelegate sharedAppDelegate] getPassword];
    
    [[AppDelegate sharedAppDelegate] setServerURL:self.URLTextField.text];
    [[AppDelegate sharedAppDelegate] setUsername:self.UsernameTextField.text];
    [[AppDelegate sharedAppDelegate] setPassword:self.PasswordTextField.text];
    WebDAVAPI *api = [[WebDAVAPI alloc] init];
    [api download];
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];
    while (![api connectionDone] && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    if([api validCredentials]){
        [[AppDelegate sharedAppDelegate] getUser].serverURL = self.URLTextField.text;
        [[AppDelegate sharedAppDelegate] getUser].serverUsername = self.UsernameTextField.text;
        [[AppDelegate sharedAppDelegate] getUser].serverPassword = self.PasswordTextField.text;
        [[AppDelegate sharedAppDelegate] syncFiles];
        
        [self SaveIsValidPopup];
    } else {        
        [[AppDelegate sharedAppDelegate] setServerURL:previousURL];
        [[AppDelegate sharedAppDelegate] setUsername:previousUsername];
        [[AppDelegate sharedAppDelegate] setPassword:previousPassword];
        [self SaveIsInvalidPopup];
    }
}

- (void)SaveIsValidPopup{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Successful"
                                                    message:@"Settings have been saved"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)SaveIsInvalidPopup{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection was Unsuccessful"
                                                    message:@"Settings have not been saved"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


@end
