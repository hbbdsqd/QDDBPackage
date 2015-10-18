//
//  Utility.m
//  DatebasePackage
//
//  Created by Mac on 15/10/18.
//  Copyright (c) 2015年 hbbdsqd. All rights reserved.
//

#import "Utility.h"
#import "Reachability.h"

@implementation Utility

/**
 *  判断是否有网络,YES表示有
 *
 *  @return <#return value description#>
 */
+ (BOOL)isNetWorkReachility
{
    //域名
    Reachability *reachability = [Reachability reachabilityWithHostname:@"www.baidu.com"];

    //获取当前网络的状态
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    //没有网络
    if (status == NotReachable)
    {
        return NO;
    }
    
    return YES;
}

@end
