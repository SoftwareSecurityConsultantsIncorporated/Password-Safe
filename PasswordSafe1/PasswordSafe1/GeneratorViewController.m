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
    [self makeSliderValueAnInt:self.lengthSlider];
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
     self.lowerLabel.text = [[NSString alloc] initWithFormat:@"%i", (int) self.lowersSlider.value];
}
- (IBAction)updateSpecialSlider:(id)sender{
     self.specialLabel.text = [[NSString alloc] initWithFormat:@"%i", (int)self.specialsSlider.value];
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
    NSArray *switches = [NSArray arrayWithObjects:self.capitalSwitch, self.lowerSwitch, self.specialSwitch, self.numberSwitch, nil];
    int maxVals[4] = {0, 0, 0, 0};

    for (int i = 0; i < [sliders count]; i++) {
        UISlider *slider = ((UISlider *) [sliders objectAtIndex:i]);
        UISwitch *sw = ((UISwitch *) [switches objectAtIndex:i]);
        maxVals[i] = [self getMaxValue:slider withSliders: [self filter:sliders withSlider:slider] withSwitch:sw];
    }
    
    self.capitalsSlider.maximumValue = maxVals[0];
    self.lowersSlider.maximumValue = maxVals[1];
    self.specialsSlider.maximumValue = maxVals[2];
    self.numbersSlider.maximumValue = maxVals[3];
    
    
    [self updateCapitalSlider:self.lengthSlider];
    [self updateLowerSlider:self.lengthSlider];
    [self updateSpecialSlider:self.lengthSlider];
    [self updateNumbersSlider:self.lengthSlider];
}

- (int) getMaxValue:(UISlider *)slider withSliders:(NSArray *)sliders withSwitch:(UISwitch *)sw {
    if (sw.on && slider.value >= 0 ) {
        int value = self.lengthSlider.value;
        for (UISlider *sl in sliders) {
            [self makeSliderValueAnInt:sl];
            if(sl.value <= value){
                value -= sl.value;
            }
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

-(void)makeSliderValueAnInt:(UISlider *)slider
{
    int sliderValue;
    sliderValue = lroundf(slider.value);
    [slider setValue:sliderValue animated:FALSE];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"savePassword"])
    {
        [(AddpasswordViewController *)segue.destinationViewController setPassword:__passwordTextField.text];
    }    
}


@end
