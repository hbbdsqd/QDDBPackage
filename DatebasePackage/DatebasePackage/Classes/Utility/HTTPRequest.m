//
//  HTTPRequest.m
//  01-网络请求的封装
//
//  Created by vera on 15/9/21.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "HTTPRequest.h"

@interface HTTPRequest ()
{
    /**
     *  成功回调
     */
    HTTPRequestFinishBlock _requestFinishBlock;
    /**
     *  失败回调
     */
    HTTPRequestErrorBlock _requestErrorBlock;
    
    /**
     *  进度回调
     */
    HTTPRequestDidReceiveProgessBlock _progessBlock;
    
    //请求的url
    NSURL *_url;
    
    //文件总大小
    long long _fileSize;
}

/**
 *  保存请求数据
 */
@property (nonatomic, strong) NSMutableData *requestData;

@end

@implementation HTTPRequest

#pragma mark - 初始化
/**
 *  🐶造方法
 *
 *  @param url <#url description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithUrl:(NSURL *)url
{
    if (self = [super init])
    {
        _url = url;
    }
    
    return self;
}

#pragma mark - 发送异步请求
/**
 *  发送异步请求
 */
- (void)startHttpRequest
{
    if (!_url)
    {
        return;
    }
    
    //发送异步请求
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - getter方法
- (NSMutableData *)requestData
{
    if (!_requestData)
    {
        _requestData = [NSMutableData data];
    }
    
    return _requestData;
}

#pragma mark - setter方法
/**
 *  设置回调
 *
 *  @param block <#block description#>
 */
- (void)setHTTPRequestFinishBlock:(HTTPRequestFinishBlock)block
{
    //赋值
    _requestFinishBlock = block;
}

/**
 *  设置进度回调
 *
 *  @param progess <#progess description#>
 */
- (void)setRecevieProgessBlock:(HTTPRequestDidReceiveProgessBlock)progess
{
    _progessBlock = progess;
}

//- (void)setXXX
//{
//    
//}

/**
 *  get请求
 *
 *  @param urlString urlString
 *  @param success   成功的回调
 *  @param failure   失败回调
 */
- (void)GET:(NSString *)urlString success:(HTTPRequestFinishBlock)success failure:(HTTPRequestErrorBlock)failure
{
    _requestFinishBlock = success;
    _requestErrorBlock = failure;
    
    _url = [NSURL URLWithString:urlString];
    [self startHttpRequest];
}



#pragma mark - 代理方法
//#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //清空数据
    self.requestData.length = 0;
    
    //获取文件总大小
    _fileSize = [response expectedContentLength];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   
    //1.追加数据
    [self.requestData appendData:data];
    
    //2.计算进度
    float progess = (float)self.requestData.length / _fileSize;
    
    //3.回调
    if (_progessBlock)
    {
        _progessBlock(progess);
    }
    
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //赋值
    self.responseData = self.requestData;
    self.responseString = [[NSString alloc] initWithData:self.requestData encoding:NSUTF8StringEncoding];
    
    //block对象不为空
    if (_requestFinishBlock)
    {
        //回调
        _requestFinishBlock(self);
    }
    
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_requestErrorBlock)
    {
        //失败回调
        _requestErrorBlock(error);
    }
}

@end
