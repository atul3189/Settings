//
//  PKDefaults.m
//  settings
//
//  Created by Atul M on 11/08/16.
//  Copyright © 2016 CARLOS CABANERO. All rights reserved.
//

#import "PKDefaults.h"

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


@end
