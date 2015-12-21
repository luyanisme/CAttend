//
//  ServerConfig.m
//  xiaoshutong
//
//  Created by wangkai on 15/4/9.
//  Copyright (c) 2015年 wangkai. All rights reserved.
//

#import "ServerConfig.h"

@implementation ServerConfig

DEF_SINGLETON(ServerConfig)
@synthesize host = _host;
@synthesize url = _url;

-(id)init
{
    self = [super init];
    if(self)
    {
#ifdef DEBUG

//        self.host =  @"192.168.1.111:8080";
        self.host =  @"121.42.213.205:8080";
        
#else
        self.host = @"112.124.6.219:58080";
#endif
        self.url = [NSString stringWithFormat:@"http://%@/CAttendWeb/rest/", self.host];
    }
    return self;
}


@end
