//
//  LUPlayerPrefs.h
//  LunarConsole
//
//  Created by Alex Lementuev on 8/29/17.
//  Copyright © 2017 Space Madness. All rights reserved.
//



#import "LUObject.h"

typedef enum : NSUInteger {
	LUPlayerPrefsEntryTypeInteger,
	LUPlayerPrefsEntryTypeFloat,
	LUPlayerPrefsEntryTypeString,
} LUPlayerPrefsEntryType;

@interface LUPlayerPrefsEntry : NSObject

@property (nonatomic, readonly) LUPlayerPrefsEntryType type;
@property (nonatomic, assign) NSInteger intValue;
@property (nonatomic, assign) float floatValue;
@property (nonatomic, copy) NSString *stringValue;

- (instancetype)initWithInt:(NSInteger)value;
- (instancetype)initWithFloat:(float)value;
- (instancetype)initWithString:(NSString *)value;

@end

@interface LUPlayerPrefs : LUObject

@property (nonatomic, readonly) NSString *filepath;
@property (nonatomic, readonly) NSArray<LUPlayerPrefsEntry *> *entries;

- (instancetype)initWithPath:(NSString *)filepath;

- (BOOL)load;
- (BOOL)save;

@end
