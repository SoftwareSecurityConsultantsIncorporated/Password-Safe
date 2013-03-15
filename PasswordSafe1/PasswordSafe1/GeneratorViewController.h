//
//  GeneratorViewController.h
//  PasswordSafe1
//
//  Created by CSSE Department on 2/13/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Generator.h"
@interface GeneratorViewController : UITableViewController {
    Generator *generator;
}
@property (strong, nonatomic) IBOutlet UISlider *lengthSlider;
@property (strong, nonatomic) IBOutlet UISlider *capitalsSlider;
@property (strong, nonatomic) IBOutlet UISlider *lowersSlider;
@property (strong, nonatomic) IBOutlet UISlider *specialsSlider;
@property (strong, nonatomic) IBOutlet UISlider *numbersSlider;
@property (strong, nonatomic) IBOutlet UILabel *lengthLabel;
@property (strong, nonatomic) IBOutlet UILabel *capitalLabel;
@property (strong, nonatomic) IBOutlet UILabel *lowerLabel;
@property (strong, nonatomic) IBOutlet UILabel *specialLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *generateButton;
@property (strong, nonatomic) IBOutlet UIButton *makeNewPasswordButton;
@property (strong, nonatomic) IBOutlet UISwitch *capitalSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *lowerSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *specialSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *numberSwitch;

- (IBAction)generateButton:(id)sender;
- (IBAction)updateLengthSlider:(id)sender;
- (IBAction)updateCapitalSlider:(id)sender;
- (IBAction)updateLowerSlider:(id)sender;
- (IBAction)updateSpecialSlider:(id)sender;
- (IBAction)updateNumbersSlider:(id)sender;

@end
