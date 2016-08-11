//
//  PKHost.h
//  settings
//
//  Created by Atul M on 11/08/16.
//  Copyright © 2016 CARLOS CABANERO. All rights reserved.
//

#import <Foundation/Foundation.h>

enum PKPrediction{
    PKPredictionAdaptive,
    PKPredictionAlways,
    PKPredictionNever,
    PKPredictionExperimental
};

@interface PKHosts : NSObject<NSCoding>

@property (nonatomic, strong)NSString *host;
@property (nonatomic, strong)NSString *hostName;
@property (nonatomic, strong)NSNumber *port;
@property (nonatomic, strong)NSString *user;
@property (nonatomic, strong)NSString *password;
@property (nonatomic, strong)NSString *key;
@property (nonatomic, strong)NSNumber *moshPort;
@property (nonatomic, strong)NSString *moshStartup;
@property (nonatomic, strong)NSNumber *prediction;

+ (void)initialize;
+ (instancetype)withHost:(NSString *)ID;
+ (BOOL)saveHosts;
+ (instancetype)saveHost:(NSString*)host hostName:(NSString*)hostName sshPort:(NSString*)sshPort user:(NSString*)user password:(NSString*)password hostKey:(NSString*)hostKey moshPort:(NSString*)moshPort startUpCmd:(NSString*)startUpCmd prediction:(NSString*)prediction;
+ (NSMutableArray *)all;
+ (NSInteger)count;


@end
