//
//  PKFont.m
//  settings
//
//  Created by Atul M on 11/08/16.
//  Copyright © 2016 CARLOS CABANERO. All rights reserved.
//

#import "PKFont.h"

NSMutableArray *Fonts;

static NSURL *DocumentsDirectory = nil;
static NSURL *FontsURL = nil;

@implementation PKFont

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
    [PKFont loadFonts];
}

+ (instancetype)withFont:(NSString *)aFontName
{
    for (PKFont *font in Fonts) {
        if ([font->_name isEqualToString:aFontName]) {
            return font;
        }
    }
    return nil;
}

+ (NSMutableArray *)all
{
    return Fonts;
}

+ (NSInteger)count
{
    return [Fonts count];
}

+ (BOOL)saveFonts
{
    // Save IDs to file
    return [NSKeyedArchiver archiveRootObject:Fonts toFile:FontsURL.path];
}
+ (void)loadFonts
{
    if (DocumentsDirectory == nil) {
        DocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
        FontsURL = [DocumentsDirectory URLByAppendingPathComponent:@"fonts"];
    }
    
    // Load IDs from file
    if ((Fonts = [NSKeyedUnarchiver unarchiveObjectWithFile:FontsURL.path]) == nil) {
        // Initialize the structure if it doesn't exist
        Fonts = [[NSMutableArray alloc] init];
    }
}

@end
