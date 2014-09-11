//
//  XYZURLProtocol.m
//  AVPlayer Streaming Test
//
//  Created by John-Paul Gignac on 2014-09-11.
//

#import "XYZURLProtocol.h"

@interface XYZURLProtocol () <NSURLConnectionDelegate>
@property NSURLConnection* connection;
@end

@implementation XYZURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    NSLog(@"schema = %@",request.URL.scheme);
    return [request.URL.scheme isEqual: @"foobar"];
}

+ (NSURLRequest*)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    NSURL* url = [NSURL URLWithString:@"http://www.kimmysews.com/pegleg.mp3"];
    NSURLRequest* req = [NSURLRequest requestWithURL:url];
    self.connection = [NSURLConnection connectionWithRequest:req delegate:self];
}

- (void)stopLoading {
    [self.connection cancel];
    self.connection = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.client URLProtocol:self didFailWithError:error];
}

@end
