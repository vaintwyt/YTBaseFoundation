//
//  YTSystemUtil.m
//  YTBaseFoundation
//
//  Created by vaint on 16/8/21.
//  Copyright © 2016年 vaint. All rights reserved.
//

#import "YTSystemUtil.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <sys/sysctl.h>
#import <ifaddrs.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import "OpenUDID.h"
#import "YTViewUtil.h"


#define IP_ADDR_IPv4 @"ipv4"
#define IP_ADDR_IPv6 @"ipv6"

#define Key_IP_V4 @"en0/ipv4"

@implementation YTSystemUtil

+(NSString*)appName
{
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    return [infoDict objectForKey:@"CFBundleDisplayName"];
}

+ (NSString*)appVer
{
    NSDictionary *infoDict = [[NSBundle mainBundle]infoDictionary];
    return infoDict[@"CFBundleShortVersionString"];
}

+ (NSString *)appBundleId
{
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (BOOL)isSystemVerOver:(CGFloat)versionValue
{
    return [YTSystemUtil systemVer] >= versionValue;
}

+(NSString*)UDID
{
    return [OpenUDID value];
}

+ (CGFloat)systemVer
{
    return [[UIDevice currentDevice].systemVersion floatValue];
}

+(NSString *)deviceType
{
    return [UIDevice currentDevice].model;
}

+ (CGFloat)screenScale
{
    return [UIScreen mainScreen].scale;
}

+ (CGSize)screenSize
{
    return [UIScreen mainScreen].bounds.size;
}

+(UIDevicePlatform)platformType
{
    NSString *platform = [self p_devicePlatform];
    
    // The ever mysterious iFPGA
    if ([platform isEqualToString:@"iFPGA"]) return UIDeviceIFPGA;
    
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"])    return UIDevice1GiPhone;
    if ([platform isEqualToString:@"iPhone1,2"])    return UIDevice3GiPhone;
    if ([platform hasPrefix:@"iPhone2"])            return UIDevice3GSiPhone;
    if ([platform hasPrefix:@"iPhone3"])            return UIDevice4iPhone;
    if ([platform hasPrefix:@"iPhone4"])            return UIDevice4SiPhone;
    if ([platform hasPrefix:@"iPhone5"])            return UIDevice5iPhone;
    if ([platform isEqualToString:@"iPhone6,2"]
        || [platform isEqualToString:@"iPhone6,1"]) return UIDevice5SiPhone;  //6,1电信 6,2移动联通
    if ([platform isEqualToString:@"iPhone7,1"])    return UIDevice6Plus;
    if ([platform isEqualToString:@"iPhone7,2"])    return UIDevice6;
    if ([platform isEqualToString:@"iPhone8,1"])    return UIDevice6SiPhone;
    if ([platform isEqualToString:@"iPhone8,2"])    return UIDevice6SPlus;
    
    // iPod
    if ([platform hasPrefix:@"iPod1"])              return UIDevice1GiPod;
    if ([platform hasPrefix:@"iPod2"])              return UIDevice2GiPod;
    if ([platform hasPrefix:@"iPod3"])              return UIDevice3GiPod;
    if ([platform hasPrefix:@"iPod4"])              return UIDevice4GiPod;
    if ([platform hasPrefix:@"iPod5,1"])            return UIDevice5GiPod;
    
    // iPad
    if ([platform hasPrefix:@"iPad1"])              return UIDevice1GiPad;
    if ([platform hasPrefix:@"iPad2"])              return UIDevice2GiPad;
    if ([platform hasPrefix:@"iPad3"])              return UIDevice3GiPad;
    if ([platform hasPrefix:@"iPad4"])              return UIDevice4GiPad;
    
    // Apple TV
    if ([platform hasPrefix:@"AppleTV2"])           return UIDeviceAppleTV2;
    if ([platform hasPrefix:@"AppleTV3"])           return UIDeviceAppleTV3;
    
    if ([platform hasPrefix:@"iPhone"])             return UIDeviceUnknowniPhone;
    if ([platform hasPrefix:@"iPod"])               return UIDeviceUnknowniPod;
    if ([platform hasPrefix:@"iPad"])               return UIDeviceUnknowniPad;
    if ([platform hasPrefix:@"AppleTV"])            return UIDeviceUnknownAppleTV;
    
    // Simulator thanks Jordan Breeding
    if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"])
    {
        BOOL smallerScreen = YTScreenW < 768;
        return smallerScreen ? UIDeviceSimulatoriPhone : UIDeviceSimulatoriPad;
    }
    
    return UIDeviceUnknown;
}

+(NSString *)platformString
{
    switch ([self platformType])
    {
        case UIDevice1GiPhone: return IPHONE_1G_NAMESTRING;
        case UIDevice3GiPhone: return IPHONE_3G_NAMESTRING;
        case UIDevice3GSiPhone: return IPHONE_3GS_NAMESTRING;
        case UIDevice4iPhone: return IPHONE_4_NAMESTRING;
        case UIDevice4SiPhone: return IPHONE_4S_NAMESTRING;
        case UIDevice5iPhone: return IPHONE_5_NAMESTRING;
        case UIDevice5SiPhone: return IPHONE_5S_NAMESTRING;
        case UIDevice6:         return IPHONE_6_NAMESTRING;
        case UIDevice6Plus:     return IPHONE_6PLUS_NAMESTRING;
        case UIDevice6SiPhone:  return IPHONE_6S_NAMESTRING;
        case UIDevice6SPlus:    return IPHONE_6SPlus_NAMESTRING;
        case UIDeviceUnknowniPhone: return IPHONE_UNKNOWN_NAMESTRING;
            
        case UIDevice1GiPod: return IPOD_1G_NAMESTRING;
        case UIDevice2GiPod: return IPOD_2G_NAMESTRING;
        case UIDevice3GiPod: return IPOD_3G_NAMESTRING;
        case UIDevice4GiPod: return IPOD_4G_NAMESTRING;
        case UIDevice5GiPod: return IPOD_5G_NAMESTRING;
        case UIDeviceUnknowniPod: return IPOD_UNKNOWN_NAMESTRING;
            
        case UIDevice1GiPad : return IPAD_1G_NAMESTRING;
        case UIDevice2GiPad : return IPAD_2G_NAMESTRING;
        case UIDevice3GiPad : return IPAD_3G_NAMESTRING;
        case UIDevice4GiPad : return IPAD_4G_NAMESTRING;
        case UIDeviceUnknowniPad : return IPAD_UNKNOWN_NAMESTRING;
            
        case UIDeviceAppleTV2 : return APPLETV_2G_NAMESTRING;
        case UIDeviceAppleTV3 : return APPLETV_3G_NAMESTRING;
        case UIDeviceAppleTV4 : return APPLETV_4G_NAMESTRING;
        case UIDeviceUnknownAppleTV: return APPLETV_UNKNOWN_NAMESTRING;
            
        case UIDeviceSimulator: return SIMULATOR_NAMESTRING;
        case UIDeviceSimulatoriPhone: return SIMULATOR_IPHONE_NAMESTRING;
        case UIDeviceSimulatoriPad: return SIMULATOR_IPAD_NAMESTRING;
        case UIDeviceSimulatorAppleTV: return SIMULATOR_APPLETV_NAMESTRING;
            
        case UIDeviceIFPGA: return IFPGA_NAMESTRING;
            
        default: return IOS_FAMILY_UNKNOWN_DEVICE;
    }
}

//+ (BOOL)iPadDevice
//{
//    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
//}
//
//+ (BOOL)iPhone4Device
//{
//    return CGSizeEqualToSize((CGSize){320,480}, [YTSystemUtil screenSize]);
//}
//
//+ (BOOL)iPhone5Device
//{
//    return CGSizeEqualToSize((CGSize){320,568}, [YTSystemUtil screenSize]);
//    
//}
//
//+ (BOOL)iPhone6Device
//{
//    return CGSizeEqualToSize((CGSize){375,667}, [YTSystemUtil screenSize]);
//}
//
//+ (BOOL)iPhone6PlusDevice
//{
//    return CGSizeEqualToSize((CGSize){414,736}, [YTSystemUtil screenSize]);
//}

+ (BOOL)cameraAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

+ (BOOL)frontCameraAvailable
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

+ (BOOL)cameraFlashAvailable
{
    return [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear];
}

+ (BOOL)canSendSMS
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sms://"]];
}

+ (BOOL)canMakePhoneCall
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
}


+ (BOOL)isAppCameraAccessAuthorized
{
    NSString *mediaType = AVMediaTypeVideo;
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if (authStatus !=  AVAuthorizationStatusAuthorized) {
        
        return authStatus == AVAuthorizationStatusNotDetermined;
        
    }else{
        
        return YES;
    }
}

+ (BOOL)isAppPhotoLibraryAccessAuthorized
{
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    
    if (authStatus != ALAuthorizationStatusAuthorized) {
        
        return authStatus == ALAuthorizationStatusNotDetermined;
        
    }else{
        
        return YES;
    }
}

+(BOOL)isJailBroken
{
    BOOL isJailBroken = NO;
    NSArray *arrExistFilePaths = [NSArray arrayWithObjects:@"/Library/MobileSubstrate/MobileSubstrate.dylib",
                                  @"/Application/Cydia.app/",
                                  @"/etc/apt",
                                  @"/bin/bash",
                                  @"/bin/sh",
                                  @"/usr/sbin/sshd",
                                  @"/usr/libexec/ssh-keysign",
                                  @"/etc/ssh/sshd_config",nil];
    for (NSString *nsFilePath in arrExistFilePaths)
    {
        if ([[NSFileManager defaultManager] fileExistsAtPath:nsFilePath])
        {
            isJailBroken = YES;
            return isJailBroken;
        }
    }
    NSURL* url = [NSURL URLWithString:@"cydia://package/com.example.package"];
    isJailBroken = [[UIApplication sharedApplication] canOpenURL:url];
    return isJailBroken;
}

+(NSString *)macAddress
{
    static NSString *s_macAddr = nil;
    
    if(s_macAddr) return s_macAddr;
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Error: Memory allocation error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2\n");
        free(buf); // Thanks, Remy "Psy" Demerest
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    s_macAddr = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    free(buf);
    return s_macAddr;
}


+(NSString*)ipAddress
{
    static NSString *s_ipAddr = nil;
    if(s_ipAddr == nil)
    {
        s_ipAddr = [[YTSystemUtil p_ipInfo] objectForKey:Key_IP_V4];
    }
    return s_ipAddr;
}



#pragma mark- private func
+(NSDictionary *)p_ipInfo
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

+(NSString *)p_devicePlatform
{
    @synchronized(self)
    {
        static NSString* pl = nil;
        if (!pl) {
            pl = [self p_sysInfoByName:"hw.machine"];
        }
        return pl;
    }
}

+(NSString *)p_sysInfoByName:(char *)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    
    if (nil == results || 0 == results.length) {
        results = @"iPhoneUnknown";
    }
    return results;
}



@end
