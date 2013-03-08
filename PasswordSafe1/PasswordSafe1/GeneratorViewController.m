//
//  GeneratorViewController.m
//  PasswordSafe1
//
//  Created by CSSE Department on 2/13/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "GeneratorViewController.h"

@interface GeneratorViewController ()

@end

@implementation GeneratorViewController

@synthesize lengthSlider = __lengthSlider;
@synthesize capitalsSlider = __captialsSlider;
@synthesize lowersSlider = __lowersSlider;
@synthesize specialsSlider = __specialsSlider;
@synthesize numbersSlider = __numbersSlider;
@synthesize lengthLabel = __lengthLabel;
@synthesize capitalLabel = __capitalLabel;
@synthesize lowerLabel = __lowerLabel;
@synthesize specialLabel = __specialLabel;
@synthesize numberLabel = __numberLabel;
@synthesize passwordTextField = __passwordTextField;
@synthesize generateButton = __generateButton;
@synthesize makeNewPasswordButton = __makeNewPasswordButton;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)valueChanged:(UISlider *) sender: (UILabel *) label{
    label.text = [NSString stringWithFormat:@"%f", sender.value];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
