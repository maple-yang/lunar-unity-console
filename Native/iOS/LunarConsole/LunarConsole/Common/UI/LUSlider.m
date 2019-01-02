//
//  LUSlider.m
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

#import "LUSlider.h"

#import "Lunar.h"

@implementation LUSlider

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.tintColor = [LUTheme mainTheme].switchTintColor;
		[self setup];
    }
    return self;
}

- (instancetype)init
{
	self = [super init];
	if (self)
	{
		self.tintColor = [LUTheme mainTheme].switchTintColor;
		[self setup];
	}
	return self;
}

- (void)setup
{
	[self addTarget:self action:@selector(valueChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
}

- (void)valueChanged:(UISlider *)slider forEvent:(UIEvent *)event
{
	UITouch *touch = [event allTouches].anyObject;
	switch (touch.phase)
	{
		case UITouchPhaseBegan:
			_editing = YES;
			break;
		case UITouchPhaseCancelled:
			_editing = NO;
			break;
		case UITouchPhaseMoved:
			if (_valueChangedCallback) {
				_valueChangedCallback(self, NO);
			}
			break;
		case UITouchPhaseEnded:
			_editing = NO;
			if (_valueChangedCallback) {
				_valueChangedCallback(self, YES);
			}
			break;
		default:
			break;
	}
	
}

@end
