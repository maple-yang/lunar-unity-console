//
//  LUPlayerPrefs.m
//  LunarConsole
//
//  Created by Alex Lementuev on 8/29/17.
//  Copyright © 2017 Space Madness. All rights reserved.
//

#import "LUPlayerPrefs.h"

@implementation LUPlayerPrefsEntry

- (instancetype)initWithInt:(NSInteger)value
{
	self = [super init];
	if (self)
	{
		_type = LUPlayerPrefsEntryTypeInteger;
		_intValue = value;
	}
	return self;
}

- (instancetype)initWithFloat:(float)value
{
	self = [super init];
	if (self)
	{
		_type = LUPlayerPrefsEntryTypeFloat;
		_floatValue = value;
	}
	return self;
}

- (instancetype)initWithString:(NSString *)value
{
	self = [super init];
	if (self)
	{
		_type = LUPlayerPrefsEntryTypeString;
		_stringValue = [value copy];
	}
	return self;
}

@end

@interface LUPlayerPrefs ()
{
	NSMutableArray * _entries;
}

@end

@implementation LUPlayerPrefs

- (instancetype)initWithPath:(NSString *)filepath
{
	self = [super init];
	if (self)
	{
		if (filepath.length == 0)
		{
			NSLog(@"Can't init %@: file path is nil or empty", NSStringFromClass([self class]));
			return nil;
		}
		
		_filepath = [filepath copy];
		_entries = [NSMutableArray new];
	}
	return self;
}

- (BOOL)load
{
	[_entries removeAllObjects];
	NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:_filepath];
	if (plist == nil)
	{
		return NO;
	}
	
	for (id key in plist)
	{
		id value = [plist objectForKey:key];
		if ([value isKindOfClass:[NSString class]])
		{
			[_entries addObject:[[LUPlayerPrefsEntry alloc] initWithString:value]];
		}
		else if ([value isKindOfClass:[NSNumber class]])
		{
			NSNumber *number = (NSNumber *)value;
			const char *type = [number objCType];
			if (strcmp(type, @encode(long)) == 0)
			{
				[_entries addObject:[[LUPlayerPrefsEntry alloc] initWithInt:[number integerValue]]];
			}
			else if (strcmp(type, @encode(float)) == 0)
			{
				[_entries addObject:[[LUPlayerPrefsEntry alloc] initWithFloat:[number floatValue]]];
			}
			else
			{
				NSLog(@"Unexpected property '%@' type: %s", key, type);
			}
		}
		else
		{
			NSLog(@"Unexpected property '%@' type: %@", key, NSStringFromClass([value class]));
		}
	}
	return YES;
}

- (BOOL)save
{
	return NO;
}

@end
