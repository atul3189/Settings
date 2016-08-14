//
//  PKFont.h
//  settings
//
//  Created by Atul M on 11/08/16.
//  Copyright © 2016 CARLOS CABANERO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKFont : NSObject<NSCoding>

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *filepath;

+ (void)initialize;
+ (instancetype)withFont:(NSString *)fontName;
+ (BOOL)saveFonts;
+ (instancetype)saveFont:(NSString*)fontName withFilePath:(NSString*)filePath;
+ (NSMutableArray *)all;
+ (NSInteger)count;


@end
