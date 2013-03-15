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
@synthesize capitalSwitch = __capitalSwitch;
@synthesize lowerSwitch = __lowerSwitch;
@synthesize specialSwitch = __specialSwitch;
@synthesize numberSwitch = __numberSwitch;


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

}

- (IBAction)generateButton:(id)sender {
    self->generator = [[Generator alloc] init];
    self.passwordTextField.text = [generator generatePassword
                                   :self.lengthSlider.value :self.capitalsSlider.value :self.lowersSlider.value
                                   :self.specialsSlider.value :self.numbersSlider.value
                                   :self.capitalSwitch.on :self.lowerSwitch.on
                                   :self.specialSwitch.on :self.numberSwitch.on];
}

-(IBAction)updateLengthSlider:(id)sender{
    self.lengthLabel.text = [[NSString alloc] initWithFormat:@"%i",(int) self.lengthSlider.value];
    self.capitalsSlider.maximumValue = self.lengthSlider.value;
    self.lowersSlider.maximumValue = self.lengthSlider.value;
    self.specialsSlider.maximumValue = self.lengthSlider.value;
    self.numbersSlider.maximumValue = self.lengthSlider.value;
    [self updateCapitalSlider:self.lengthSlider];
    [self updateLowerSlider:self.lengthSlider];
    [self updateSpecialSlider:self.lengthSlider];
    [self updateNumbersSlider:self.lengthSlider];
}
- (IBAction)updateCapitalSlider:(id)sender{
    self.capitalLabel.text = [[NSString alloc] initWithFormat:@"%i",(int) self.capitalsSlider.value];
}
- (IBAction)updateLowerSlider:(id)sender{
     self.lowerLabel.text = [[NSString alloc] initWithFormat:@"%i",(int) self.lowersSlider.value];
}
- (IBAction)updateSpecialSlider:(id)sender{
     self.specialLabel.text = [[NSString alloc] initWithFormat:@"%i",(int) self.specialsSlider.value];
}
- (IBAction)updateNumbersSlider:(id)sender{
     self.numberLabel.text = [[NSString alloc] initWithFormat:@"%i",(int) self.numbersSlider.value];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
