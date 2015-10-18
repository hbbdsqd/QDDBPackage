//
//  HTTPRequest.h
//  01-网络请求的封装
//
//  Created by vera on 15/9/21.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTTPRequest;

//请求成功的回调
typedef void(^HTTPRequestFinishBlock)(HTTPRequest *request);
//请求失败的回调
typedef void(^HTTPRequestErrorBlock)(NSError *error);
//进度的回调
typedef void(^HTTPRequestDidReceiveProgessBlock)(float progess);

@interface HTTPRequest : NSObject


@property (nonatomic, strong) NSData *responseData;
@property (nonatomic, copy) NSString *responseString;


/**
 *  🐶造方法
 *
 *  @param url <#url description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithUrl:(NSURL *)url;

/**
 *  发送异步请求
 */
- (void)startHttpRequest;

/**
 *  设置回调
 *
 *  @param block <#block description#>
 */
- (void)setHTTPRequestFinishBlock:(HTTPRequestFinishBlock)block;

/*
 void(^b)(HTTPRequest *request) == > void(^)(HTTPRequest *request)
 int a
 */
//- (void)setHTTPRequestFinishBlock2:(void(^)(HTTPRequest *request))block;

/**
 *  get请求
 *
 *  @param urlString urlString
 *  @param success   成功的回调
 *  @param failure   失败回调
 */
- (void)GET:(NSString *)urlString success:(HTTPRequestFinishBlock)success failure:(HTTPRequestErrorBlock)failure;

/**
 *  设置进度回调
 *
 *  @param progess <#progess description#>
 */
- (void)setRecevieProgessBlock:(HTTPRequestDidReceiveProgessBlock)progess;

@end
