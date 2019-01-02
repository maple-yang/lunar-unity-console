//
//  LUCVarTableViewCell.m
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

#import "LUCVarTableViewCell+Inheritance.h"

#import "Lunar-Full.h"

@interface LUCVarTableViewCell () <LUCVarObserver, LUConsolePopupControllerDelegate>

@property (nonatomic, weak) IBOutlet UILabel  * titleLabel;
@property (nonatomic, weak) IBOutlet UIButton * resetButton;

@property (nonatomic, weak) LUCVar *variable;

@end

@implementation LUCVarTableViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self createCellView];
    }
    return self;
}

#pragma mark -
#pragma mark Cell UI

- (void)createCellView
{
    UIView *view = [[NSBundle mainBundle] loadNibNamed:self.cellNibName owner:self options:nil].firstObject;
    view.frame = self.contentView.bounds;
    view.backgroundColor = [UIColor clearColor];
    view.opaque = YES;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.contentView addSubview:view];
}

- (void)prepareForReuse
{
	[super prepareForReuse];
	[_variable unregisterObserver:self];
}

- (NSString *)cellNibName
{
    return NSStringFromClass([self class]);
}

- (void)updateUI
{
	[self updateResetButton];
}

#pragma mark -
#pragma mark Variable

- (void)setupVariable:(LUCVar *)variable atIndexPath:(NSIndexPath *)indexPath
{
    _variable = variable;
	_indexPath = indexPath;
    
    LUTheme *theme = [LUTheme mainTheme];
	_titleLabel.text = variable.name;
    _titleLabel.textColor = [variable hasFlag:LUCVarFlagsNoArchive] ? theme.variableVolatileTextColor : theme.variableTextColor;
    _titleLabel.font = theme.actionsFont;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.opaque = YES;
	
	[_variable registerObserver:self];
	
	LU_SET_ACCESSIBILITY_IDENTIFIER(_resetButton, @"Variable Reset Button");
}

#pragma mark -
#pragma mark Reset button

- (void)updateResetButton
{
	_resetButton.hidden = self.variable.isDefaultValue;
	[self layoutIfNeeded];
}

#pragma mark -
#pragma mark Actions

- (IBAction)onResetButton:(id)sender
{
	[self.variable resetToDefaultValue];
}

#pragma mark -
#pragma mark Editing

- (void)notifyWillStartEditing
{
	if ([_delegate respondsToSelector:@selector(cellWillBeginEditing:)]) {
		[_delegate cellWillBeginEditing:self];
	}
}

- (void)notifyDidStopEditing
{
	if ([_delegate respondsToSelector:@selector(cellDidEndEditing:)]) {
		[_delegate cellDidEndEditing:self];
	}
}

#pragma mark -
#pragma mark LUCvarObserver

- (void)cvarValueDidChange:(LUCVar *)cvar
{
	[self updateUI];
}

#pragma mark -
#pragma mark LUConsolePopupControllerDelegate

- (void)popupControllerDidDismiss:(LUConsolePopupController *)controller
{
	[controller dismissAnimated:YES];
}

#pragma mark -
#pragma mark Properties

- (int)variableId
{
    return _variable.actionId;
}

@end
