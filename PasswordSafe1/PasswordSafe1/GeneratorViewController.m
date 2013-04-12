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
    
    NSArray *sliders = [NSArray arrayWithObjects:self.capitalsSlider, self.lowersSlider, self.specialsSlider, self.numbersSlider, nil];
    
    self.capitalsSlider.maximumValue = [self getMaxValue:self.capitalsSlider withSliders:[self filter:sliders withSlider:self.capitalsSlider] withSwitch:self.capitalSwitch];
    
    self.lowersSlider.maximumValue = [self getMaxValue:self.lowersSlider withSliders:[self filter:sliders withSlider:self.lowersSlider] withSwitch:self.lowerSwitch];
    
    self.specialsSlider.maximumValue = [self getMaxValue:self.specialsSlider withSliders:[self filter:sliders withSlider:self.specialsSlider] withSwitch:self.specialSwitch];
    
    self.numbersSlider.maximumValue = [self getMaxValue:self.numbersSlider withSliders:[self filter:sliders withSlider:self.capitalsSlider] withSwitch:self.numberSwitch];
    
    [self updateCapitalSlider:self.lengthSlider];
    [self updateLowerSlider:self.lengthSlider];
    [self updateSpecialSlider:self.lengthSlider];
    [self updateNumbersSlider:self.lengthSlider];
}

- (int) getMaxValue:(UISlider *)slider withSliders:(NSArray *)sliders withSwitch:(UISwitch *)sw {
    if (sw.on && slider.value >= 0 ) {
        int value = self.lengthSlider.value;
        for (UISlider *sl in sliders) {
            value -= sl.value;
        }
        return value;
    } else {
        return 0;
    }
}

- (NSArray *) filter:(NSArray *)sliders withSlider:(UISlider *)slider {
    NSMutableArray *newArray = [NSMutableArray array];
    
    for (UISlider *sl in sliders) {
        if (sl != slider) {
            [newArray addObject:sl];
        }
    }
    
    return [newArray copy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
