//
//  Book.h
//  DatebasePackage
//
//  Created by Mac on 15/10/18.
//  Copyright (c) 2015年 hbbdsqd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

/**
 *  图书标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  大图
 */
@property (nonatomic, copy) NSString *large;

/**
 *  出版社
 */
@property (nonatomic, copy) NSString *publisher;

@end
