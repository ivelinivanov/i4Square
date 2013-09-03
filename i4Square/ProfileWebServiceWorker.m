//
//  ProfileWebServiceWorker.m
//  i4Square
//
//  Created by Ivelin Ivanov on 7/25/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "ProfileWebServiceWorker.h"

@implementation ProfileWebServiceWorker

-(id)init
{
    if(self = [super init])
    {
        self.receivedData = [NSMutableData data];
        return self;
    }
    else
    {
        return nil;
    }
}

#pragma mark - Get Results Method

-(void)getResultDictionaryForProfile:(void (^)(NSDictionary *))block
{
    self.block = block;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *accessToken = [defaults objectForKey:@"access_token"];
    
    NSString *url = [[NSString alloc] initWithFormat:kProfileRequestURL, accessToken];
    
    [self connectToServerUsingURL:url];
}

#pragma mark - Connection Methods

-(void)connectToServerUsingURL:(NSString *)url
{
    NSURL* urlPath = [NSURL URLWithString:url];
    NSURLRequest* req = [NSURLRequest requestWithURL:urlPath];
    [NSURLConnection connectionWithRequest:req delegate:self];
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.receivedData setLength:0];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                    message:@"Something went wrong with retreiving data about profile."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error = nil;
    
    NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:self.receivedData options:kNilOptions error:&error];
    
    self.block(resultDict);
}


@end
