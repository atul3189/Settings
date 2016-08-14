//
//  PKTheme.m
//  settings
//
//  Created by Atul M on 11/08/16.
//  Copyright © 2016 CARLOS CABANERO. All rights reserved.
//

#import "PKTheme.h"

NSMutableArray *Themes;

static NSURL *DocumentsDirectory = nil;
static NSURL *ThemesURL = nil;

@implementation PKTheme

- (id)initWithCoder:(NSCoder *)coder
{
    _name = [coder decodeObjectForKey:@"name"];
    _filepath = [coder decodeObjectForKey:@"filepath"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:_filepath forKey:@"filepath"];
}

+ (void)initialize
{
    [PKTheme loadThemes];
}

+ (instancetype)withTheme:(NSString *)athemeName
{
    for (PKTheme *theme in Themes) {
        if ([theme->_name isEqualToString:athemeName]) {
            return theme;
        }
    }
    return nil;
}

+ (NSMutableArray *)all
{
    return Themes;
}

+ (NSInteger)count
{
    return [Themes count];
}

+ (BOOL)saveHosts
{
    // Save IDs to file
    return [NSKeyedArchiver archiveRootObject:Themes toFile:ThemesURL.path];
}

+ (void)loadThemes
{
    if (DocumentsDirectory == nil) {
        DocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
        ThemesURL = [DocumentsDirectory URLByAppendingPathComponent:@"hosts"];
    }
    
    // Load IDs from file
    if ((Themes = [NSKeyedUnarchiver unarchiveObjectWithFile:ThemesURL.path]) == nil) {
        // Initialize the structure if it doesn't exist
        Themes = [[NSMutableArray alloc] init];
    }
}

@end
