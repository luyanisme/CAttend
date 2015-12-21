//
//  ServerConfig.h
//  xiaoshutong
//
//  Created by wangkai on 15/4/9.
//  Copyright (c) 2015年 wangkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerConfig : NSObject

AS_SINGLETON(ServerConfig)

@property(nonatomic, strong) NSString* host;
@property(nonatomic, strong) NSString* url;

@end
