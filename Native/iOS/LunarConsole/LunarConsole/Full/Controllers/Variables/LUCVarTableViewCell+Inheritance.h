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

- (void)setVariableValue:(NSString *)value;
- (void)updateUI;

@end

NS_ASSUME_NONNULL_END
