//
//  HttpHelper.m
//  Drawear
//
//  Created by 何文琦 on 1/8/15.
//  Copyright (c) 2015 DrawearGroup. All rights reserved.
//

#import "HttpHelper.h"

static NSString* baseUrl=@"localhost:8888";

@implementation HttpHelper

+(void) setBaseUrl:(NSString*)url
{
    baseUrl=url;
}

+(NSData *)getWithEndpoint:(NSString*) endpoint parameters:(NSDictionary*)param
{
    NSMutableString *paramStr=[[NSMutableString alloc] initWithCapacity:10];
    [paramStr setString:@""];
    for (NSString *key in param) {
        NSLog(@"key: %@ value: %@", key, param[key]);
        [paramStr appendFormat:@"%@=%@&",key, param[key]];
    }
    NSString* path=[NSString stringWithFormat:@"%@,%@",endpoint,[paramStr substringToIndex:[paramStr length]]];
    
    NSURL* url=[NSURL URLWithString:path relativeToURL:[NSURL URLWithString:baseUrl]];
    NSLog(@"url: %@",url);
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    return received;
    
}

+(NSData *)postWithEndpoint:(NSString*) endpoint parameters:(NSDictionary*)param
{
    NSURL *url = [NSURL URLWithString:endpoint relativeToURL:[NSURL URLWithString:baseUrl]];

    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:param];
    [archiver finishEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    return received;
}

+(NSData *)getSoapRequestWithUrl:(NSString*) urlString
                                     soapBody:(NSString*)soapBody
                                   soapAction:(NSString*)soapAction
{
    NSString *soapString=[[NSString alloc] initWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                          "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>"
                          "%@"
                          "</soap:Body>"
                          "</soap:Envelope>",soapBody];
    NSURL *url=[[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    //设置请求头部
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:soapAction forHTTPHeaderField:@"SOAPAction"];
    [request addValue:[NSString stringWithFormat:@"%d",[soapString length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    
    //设置请求Body
    [request setHTTPBody:[soapString dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return returnData;
    
}

@end
