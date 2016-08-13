//
//  PKDefaults.m
//  settings
//
//  Created by Atul M on 11/08/16.
//  Copyright © 2016 CARLOS CABANERO. All rights reserved.
//

#import "PKDefaults.h"

static NSURL *DocumentsDirectory = nil;
static NSURL *KeysURL = nil;
PKDefaults *defaults;
@implementation PKDefaults


#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)coder
{
    _keyboardMaps = [coder decodeObjectForKey:@"keyboardMaps"];
    _themeName = [coder decodeObjectForKey:@"themeName"];
    _fontName = [coder decodeObjectForKey:@"fontName"];
    _fontSize = [coder decodeObjectForKey:@"fontSize"];
    _defaultUser = [coder decodeObjectForKey:@"defaultUser"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_keyboardMaps forKey:@"keyboardMaps"];
    [encoder encodeObject:_themeName forKey:@"themeName"];
    [encoder encodeObject:_fontName forKey:@"fontName"];
    [encoder encodeObject:_fontSize forKey:@"fontSize"];
    [encoder encodeObject:_defaultUser forKey:@"defaultUser"];
}

+ (void)initialize
{
    [PKDefaults loadHosts];
}
+ (void)loadHosts
{
    if (DocumentsDirectory == nil) {
        //Hosts = [[NSMutableArray alloc] init];
        DocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
        KeysURL = [DocumentsDirectory URLByAppendingPathComponent:@"hosts"];
    }
    
    // Load IDs from file
    if ((defaults = [NSKeyedUnarchiver unarchiveObjectWithFile:KeysURL.path]) == nil) {
        // Initialize the structure if it doesn't exist
        defaults = [[PKDefaults alloc]init];
    }
}

+ (void)setModifer:(NSString*)modifier forKey:(NSString*)key{
    
}

@end
