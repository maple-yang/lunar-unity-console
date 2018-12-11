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

inline static float clampf(float value, float min, float max)
{
	if (value < min) return min;
	if (value > max) return max;
	return value;
}

@interface LUCVarInputTableViewCell ()

@property (nonatomic, weak) IBOutlet UITextField * inputField;
@property (nonatomic, weak) IBOutlet LUSlider    * rangeSlider;

@end

@implementation LUCVarInputTableViewCell

#pragma mark -
#pragma mark Variable

- (void)setupVariable:(LUCVar *)variable atIndexPath:(NSIndexPath *)indexPath
{
    [super setupVariable:variable atIndexPath:indexPath];
	
	self.rangeSlider.hidden = YES;
	if ([variable hasRange])
	{
		self.rangeSlider.minimumValue = variable.range.min;
		self.rangeSlider.maximumValue = variable.range.max;
	}
	
    LU_SET_ACCESSIBILITY_IDENTIFIER(_inputField, @"Variable Input Field");
}

- (void)updateUI
{
	[super updateUI];
	
	_inputField.text = self.variable.value;
	if ([self.variable hasRange])
	{
		self.rangeSlider.value = clampf(self.variable.floatValue, self.variable.range.min, self.variable.range.max);
	}
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
	[self setRangeSliderVisible:YES];
	[self notifyWillStartEditing];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
	NSString *text = LUStringTrim(textField.text);
	BOOL valid = [self.variable isValidValue:text];
	if (valid)
	{
		[self setRangeSliderVisible:NO];
		[self notifyDidStopEditing];
		self.variable.value = textField.text;
	}
	return valid;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return NO;
}

#pragma mark -
#pragma mark Helpers

- (void)setRangeSliderVisible:(BOOL)visible
{
	if ([self.variable hasRange])
	{
		self.rangeSlider.hidden = !visible;
		self.titleLabel.hidden = visible;
	}
}

@end
