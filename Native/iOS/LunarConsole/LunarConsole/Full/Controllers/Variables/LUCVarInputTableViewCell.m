//
//  LUCVarInputTableViewCell.m
//
//  Lunar Unity Mobile Console
//  https://github.com/SpaceMadness/lunar-unity-console
//
//  Copyright 2018 Alex Lementuev, SpaceMadness.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "LUCVarInputTableViewCell.h"
#import "LUCVarTableViewCell+Inheritance.h"

#import "Lunar-Full.h"

@interface LUCVarInputTableViewCell () <LUConsolePopupControllerDelegate, LUCVarEditControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextField * inputField;

@end

@implementation LUCVarInputTableViewCell

#pragma mark -
#pragma mark Variable

- (void)setupVariable:(LUCVar *)variable
{
    [super setupVariable:variable];
	
    LU_SET_ACCESSIBILITY_IDENTIFIER(_inputField, @"Variable Input Field");
}

- (void)updateUI
{
	[super updateUI];
	_inputField.text = self.variable.value;
}

#pragma mark -
#pragma mark Text Validation

- (BOOL)isValidInputText:(NSString *)text
{
    LU_SHOULD_IMPLEMENT_METHOD
    return NO;
}

#pragma mark -
#pragma mark Cell loading

- (NSString *)cellNibName
{
    return NSStringFromClass([LUCVarInputTableViewCell class]);
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    LUCVarEditController *controller = [[LUCVarEditController alloc] initWithVariable:self.variable];
    controller.delegate = self;
    
    LUConsolePopupController *popupController = [[LUConsolePopupController alloc] initWithContentController:controller];
    popupController.popupDelegate = self;
    [popupController presentFromController:self.presentingController animated:YES];
    
    return NO;
}

#pragma mark -
#pragma mark LUConsolePopupControllerDelegate

- (void)popupControllerDidDismiss:(LUConsolePopupController *)controller
{
    [controller dismissAnimated:YES];
}

#pragma mark -
#pragma mark LUCVarEditControllerDelegate

- (void)editController:(LUCVarEditController *)controller didChangeValue:(NSString *)value
{
    [self setVariableValue:value];
}

@end
