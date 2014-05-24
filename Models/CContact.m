//
//  CContact.m
//  TabBarNavBarDemo
//
//  Created by Eric Chang on 2/27/14.
//
//

#import "CContact.h"

@implementation CContact

-(void)dealloc
{
    [_firstName release];
    [_lastName release];
    [_compositeName release];
    [_image release];
    [_phoneInfo release];
    [_emailInfo release];
    
    
    _recordID = nil;
    _firstName = nil;
    _lastName = nil;
    _compositeName = nil;
    _image = nil;
    _phoneInfo = nil;
    _emailInfo = nil;
    
    [super dealloc];
}


-(NSMutableDictionary *)phoneInfo
{
    if(_phoneInfo == nil)
    {
        _phoneInfo = [[NSMutableDictionary alloc] init];
    }
    
    return _phoneInfo;
}


-(NSMutableDictionary *)emailInfo
{
    if(_emailInfo == nil)
    {
        _emailInfo = [[NSMutableDictionary alloc] init];
    }
    return  _emailInfo;
}

@end
