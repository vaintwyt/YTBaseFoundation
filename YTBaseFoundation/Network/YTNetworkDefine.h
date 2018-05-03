//
//  YTNetworkDefine.h
//  YTBaseFoundation
//
//  Created by YT on 16/8/28.
//  Copyright © 2016年 YT. All rights reserved.
//

#ifndef YTNetworkDefine_h
#define YTNetworkDefine_h


#define YTRetCode @"retcode"
#define YTRetMsg  @"retmsg"

// 本地错误码和错误信息

#define YTRetCode_ResDataError @"100001"
#define YTRetMsg_ResDataError  @"数据解析异常"

#define YTRetCode_NetworkError @"100002"
#define YTRetMsg_ReqTimeout    @"网络请求超时"
#define YTRetMsg_ReqLost       @"网络连接丢失"
#define YTRetMsg_ReqCancle     @"网络请求已取消"
#define YTRetMsg_ReqInvalid    @"请求的网络资源无效"

#define YTRetCode_NoNetwork    @"100003"
#define YTRetMsg_NoNetwork     @"网络连接失败，请检查网络设置。"


#endif /* YTNetworkDefine_h */
