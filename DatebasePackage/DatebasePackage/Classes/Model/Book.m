//
//  Book.m
//  DatebasePackage
//
//  Created by Mac on 15/10/18.
//  Copyright (c) 2015年 hbbdsqd. All rights reserved.
//

#import "Book.h"

@implementation Book

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"images"])
    {
        self.large = [value valueForKey:@"large"];
    }
    else
    {
       [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

//valueForKey:如果key存在会触发这个方法
- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end
