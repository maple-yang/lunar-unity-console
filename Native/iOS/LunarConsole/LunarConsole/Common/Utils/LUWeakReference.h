//
//  LUWeakReference.h
//  LunarConsole
//
//  Created by Alex Lementuev on 12/12/18.
//  Copyright © 2018 Space Madness. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LUWeakReference : NSObject

@property (nonatomic, readonly, weak) _Nullable id target;
@property (nonatomic, readonly, getter=isLost) BOOL lost;

+ (instancetype)referenceWithTarget:(id)target;
- (instancetype)initWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
