//
//  PKHost.m
//  settings
//
//  Created by Atul M on 11/08/16.
//  Copyright © 2016 CARLOS CABANERO. All rights reserved.
//

#import "PKHost.h"

@implementation PKHost

- (id)initWithCoder:(NSCoder *)coder
{
    _host = [coder decodeObjectForKey:@"host"];
    _hostName = [coder decodeObjectForKey:@"hostName"];
    _port = [coder decodeObjectForKey:@"port"];
    _user = [coder decodeObjectForKey:@"user"];
    _password = [coder decodeObjectForKey:@"password"];
    _key = [coder decodeObjectForKey:@"key"];
    _moshPort = [coder decodeObjectForKey:@"moshPort"];
    _moshStartup = [coder decodeObjectForKey:@"moshStartup"];
    _prediction = [coder decodeObjectForKey:@"prediction"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_host forKey:@"host"];
    [encoder encodeObject:_hostName forKey:@"hostName"];
    [encoder encodeObject:_port forKey:@"port"];
    [encoder encodeObject:_user forKey:@"user"];
    [encoder encodeObject:_password forKey:@"password"];
    [encoder encodeObject:_key forKey:@"key"];
    [encoder encodeObject:_moshPort forKey:@"moshPort"];
    [encoder encodeObject:_moshStartup forKey:@"moshStartup"];
    [encoder encodeObject:_prediction forKey:@"prediction"];
}

@end
