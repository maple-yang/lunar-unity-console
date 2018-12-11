//
//  LUCVarTableViewCell+Inheritance.h
//  LunarConsoleFull
//
//  Created by Alex Lementuev on 12/4/18.
//  Copyright © 2018 Space Madness. All rights reserved.
//

#import "LUCVarTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LUCVarTableViewCell (Inheritance)

- (void)updateUI NS_REQUIRES_SUPER;
- (void)notifyWillStartEditing;
- (void)notifyDidStopEditing;

@end

NS_ASSUME_NONNULL_END
