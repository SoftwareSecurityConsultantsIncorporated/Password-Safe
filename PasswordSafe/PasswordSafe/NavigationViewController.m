//
//  NavigationViewController.m
//  PasswordSafe
//
//  Created by CSSE Department on 2/12/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIStoryboard *us = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
        NavigationViewController *fvc = [us instantiateViewControllerWithIdentifier:@"MainView"];
    }
    
    return self;
}

@end
