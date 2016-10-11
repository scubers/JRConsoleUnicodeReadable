//
//  NSDictionary+Log.h
//  GameGuess_CN
//
//  Created by J on 2016/10/11.
//  Copyright © 2016年 gaoqi. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *generateStringForDictionary(NSDictionary *dict, int level);
NSString *generateStringForArray(NSArray *array, int level);
NSString *generateStringForSet(NSSet *set, int level);

@interface NSDictionary (JRReadable)

@end

@interface NSArray (JRReadable)

@end

@interface NSSet (JRReadable)

@end
