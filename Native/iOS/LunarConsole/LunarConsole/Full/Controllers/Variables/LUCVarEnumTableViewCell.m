//
//  LUCVarEnumTableViewCell.m
//  LunarConsoleFull
//
//  Created by Alex Lementuev on 11/30/18.
//  Copyright © 2018 Space Madness. All rights reserved.
//

#import "LUCVarEnumTableViewCell.h"

#import "Lunar-Full.h"

@interface LUCVarEnumTableViewCell () <LUConsolePopupControllerDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *valueButton;

@end

@implementation LUCVarEnumTableViewCell

#pragma mark -
#pragma mark Actions

- (IBAction)valueButtonPress:(id)sender
{
}

#pragma mark -
#pragma mark LUConsolePopupControllerDelegate

- (void)popupControllerDidDismiss:(LUConsolePopupController *)controller
{
	[controller dismissAnimated:YES];
}

@end
