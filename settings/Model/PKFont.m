//
//  PKFont.m
//  settings
//
//  Created by Atul M on 11/08/16.
//  Copyright © 2016 CARLOS CABANERO. All rights reserved.
//

#import "PKFont.h"

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

@end
