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
@synthesize passwordCopyButton = __passwordCopyButton;
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
    [self sliderAdjustment:self.lengthSlider];
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

- (IBAction)copyToClipboard:(id)sender{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    pasteboard.persistent = YES;
    [pasteboard setString:self.passwordTextField.text];
}

- (IBAction)setCapitalSliderToZero:(id)sender{
    self.capitalsSlider.value = 0;
    [self updateCapitalSlider:self.lengthSlider];
}

- (IBAction)setLowerSliderToZero:(id)sender{
    self.lowersSlider.value = 0;
    [self updateLowerSlider:self.lengthSlider];
}

- (IBAction)setSpecialSliderToZero:(id)sender{
    self.specialsSlider.value = 0;
    [self updateSpecialSlider:self.lengthSlider];
}

- (IBAction)setNumberSliderToZero:(id)sender{
    self.numbersSlider.value = 0;
    
}

- (IBAction)sliderAdjustment:(id)sender{

    if (self.capitalSwitch.on && self.capitalsSlider.value >= 0){
    self.capitalsSlider.maximumValue = self.lengthSlider.value - self.lowersSlider.value - self.specialsSlider.value - self.numbersSlider.value;
        
    } else {
        self.capitalsSlider.maximumValue = 0;
    }
    
    if (self.lowerSwitch.on && self.lowersSlider.value >= 0){
    self.lowersSlider.maximumValue = self.lengthSlider.value - self.capitalsSlider.value - self.specialsSlider.value - self.numbersSlider.value;
    } else {
        self.lowersSlider.maximumValue = 0;
    }
    
    if (self.specialSwitch.on && self.specialsSlider.value >= 0){
    self.specialsSlider.maximumValue = self.lengthSlider.value - self.capitalsSlider.value - self.lowersSlider.value - self.numbersSlider.value;
    } else {
        self.specialsSlider.maximumValue = 0;
    }

    if (self.numberSwitch.on && self.numbersSlider.value >= 0){
    self.numbersSlider.maximumValue = self.lengthSlider.value - self.capitalsSlider.value - self.lowersSlider.value - self.specialsSlider.value;
    } else {
        self.numbersSlider.maximumValue = 0;
    }
    
    [self updateCapitalSlider:self.lengthSlider];
    [self updateLowerSlider:self.lengthSlider];
    [self updateSpecialSlider:self.lengthSlider];
    [self updateNumbersSlider:self.lengthSlider];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
