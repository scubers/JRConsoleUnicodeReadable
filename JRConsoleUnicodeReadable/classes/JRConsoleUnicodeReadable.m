//
//  NSDictionary+JRReadable.m
//  GameGuess_CN
//
//  Created by J on 2016/10/11.
//  Copyright © 2016年 gaoqi. All rights reserved.
//

#import "JRConsoleUnicodeReadable.h"

#define RepeatString @"\t"
#define RepeatString1 @"="
#define RepeatString2 @"+"

NSString *repeatStringWithLevel(int level, NSString *string) {
    NSMutableString *tabs = [NSMutableString string];
    for (int i = 0; i < level; i++) {
        [tabs appendFormat:@"%@", string];
    }
    return tabs.copy;
}

NSString *generateStringForDictionary(NSDictionary *dict, int level) {
    
    NSMutableString *string = [NSMutableString string];
    
    [string appendFormat:@"%@%@{\n", level?@"":@"\t", repeatStringWithLevel(level, RepeatString)];
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            [string appendFormat:@"%@%@ = %@;\n", repeatStringWithLevel(level + 1, RepeatString), key, generateStringForArray(obj, level + 1)];
        }
        else if ([obj isKindOfClass:[NSSet class]]) {
            [string appendFormat:@"%@%@ = %@,\n", repeatStringWithLevel(level + 1, RepeatString), key, generateStringForSet(obj, level + 1)];
        }
        else if ([obj isKindOfClass:[NSDictionary class]]) {
            [string appendFormat:@"%@%@ = %@;\n", repeatStringWithLevel(level + 1, RepeatString), key, generateStringForDictionary(obj, level + 1)];
        }
        else {
            BOOL flag = [obj isKindOfClass:[NSString class]];
            [string appendFormat:@"%@%@ = %@%@%@;\n", repeatStringWithLevel(level + 1, RepeatString), key, flag?@"\"":@"", obj, flag?@"\"":@""];
        }
    }];

    string = [string substringToIndex:string.length - 2].mutableCopy;
    [string appendFormat:@"\n%@}", repeatStringWithLevel(level, RepeatString)];
    return string.copy;
    
    
    return nil;
}

NSString *generateStringForArray(NSArray *array, int level) {
    
    NSMutableString *string = [NSMutableString string];
    
    [string appendFormat:@"%@%@(\n", level?@"":@"\n" ,repeatStringWithLevel(level, RepeatString)];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([obj isKindOfClass:[NSArray class]]) {
            [string appendFormat:@"%@%@,\n", repeatStringWithLevel(level + 1, RepeatString), generateStringForArray(obj, level + 1)];
        }
        else if ([obj isKindOfClass:[NSSet class]]) {
            [string appendFormat:@"%@%@,\n", repeatStringWithLevel(level + 1, RepeatString), generateStringForSet(obj, level + 1)];
        }
        else if ([obj isKindOfClass:[NSDictionary class]]) {
            [string appendFormat:@"%@%@,\n", repeatStringWithLevel(level + 1, RepeatString), generateStringForDictionary(obj, level + 1)];
        }
        else {
            BOOL flag = [obj isKindOfClass:[NSString class]];
            [string appendFormat:@"%@%@%@%@,\n", repeatStringWithLevel(level + 1, RepeatString), flag?@"\"":@"", obj, flag?@"\"":@""];
        }
        
    }];
    string = [string substringToIndex:string.length - 2].mutableCopy;
    [string appendFormat:@"\n%@)", repeatStringWithLevel(level, RepeatString)];
    return string.copy;
}

NSString *generateStringForSet(NSSet *set, int level) {
    NSMutableString *string = [NSMutableString string];
    
    [string appendFormat:@"%@%@{(\n", level?@"":@"\n" ,repeatStringWithLevel(level, RepeatString)];
    
    [set enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            [string appendFormat:@"%@%@,\n", repeatStringWithLevel(level + 1, RepeatString), generateStringForArray(obj, level + 1)];
        }
        else if ([obj isKindOfClass:[NSSet class]]) {
            [string appendFormat:@"%@%@,\n", repeatStringWithLevel(level + 1, RepeatString), generateStringForSet(obj, level + 1)];
        }
        else if ([obj isKindOfClass:[NSDictionary class]]) {
            [string appendFormat:@"%@%@,\n", repeatStringWithLevel(level + 1, RepeatString), generateStringForDictionary(obj, level + 1)];
        }
        else {
            BOOL flag = [obj isKindOfClass:[NSString class]];
            [string appendFormat:@"%@%@%@%@,\n", repeatStringWithLevel(level + 1, RepeatString), flag?@"\"":@"", obj, flag?@"\"":@""];
        }
        
    }];
    string = [string substringToIndex:string.length - 2].mutableCopy;
    [string appendFormat:@"\n%@)}", repeatStringWithLevel(level, RepeatString)];
    return string.copy;
}

@implementation NSDictionary (JRReadable)

- (NSString *)descriptionWithLocale:(id)locale {
    return generateStringForDictionary(self, 0);
}


@end

@implementation NSArray (JRReadable)

- (NSString *)descriptionWithLocale:(id)locale {
    return generateStringForArray(self, 0);
}

@end

@implementation NSSet (JRReadable)

- (NSString *)descriptionWithLocale:(id)locale {
    return generateStringForSet(self, 0);
}

@end
