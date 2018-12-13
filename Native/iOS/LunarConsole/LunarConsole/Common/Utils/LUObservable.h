//
//  LUObservable.h
//  LunarConsole
//
//  Created by Alex Lementuev on 12/8/18.
//  Copyright © 2018 Space Madness. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LUObserver<NSObject>

- (void)valueDidChage:(nullable id)value;

@end

@interface LUBlockObserver : NSObject<LUObserver>

+ (instancetype)observerWithBlock:(void(^)(id value))block;
- (instancetype)initWithBlock:(void(^)(id value))block;

@end

@interface LUObservable<Target> : NSObject

@property (nonatomic, strong, nullable) Target target;

+ (instancetype)observableWithTarget:(nullable Target)target;
- (instancetype)initWithTarget:(nullable Target)target;

- (void)addObserver:(id<LUObserver>)observer;
- (void)removeObserver:(id<LUObserver>)observer;

@end

NS_ASSUME_NONNULL_END
