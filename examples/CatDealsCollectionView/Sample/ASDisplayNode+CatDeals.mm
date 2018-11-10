//
//  ASDisplayNode+CatDeals.mm
//  Texture
//
//  Copyright (c) Pinterest, Inc.  All rights reserved.
//  Licensed under Apache 2.0: http://www.apache.org/licenses/LICENSE-2.0

#import "ASDisplayNode+CatDeals.h"

struct NodeProps {
  NSString *loggingID = nil;
};

#define _props ((NodeProps &)*((NodeProps *)_userInfo))

@implementation ASDisplayNode (CatDeals)

- (void)globalInit
{
  _userInfo = new NodeProps{};
}

- (void)globalDealloc
{
  delete &_props;
}

- (void)setCatsLoggingID:(NSString *)catsLoggingID
{
  _props.loggingID = catsLoggingID;  
}

- (NSString *)catsLoggingID
{
  return _props.loggingID;
}

- (void)didEnterVisibleState
{
  if (_props.loggingID) {
    NSLog(@"Visible: %@", _props.loggingID);
  }
}

- (void)didExitVisibleState
{
  if (_props.loggingID) {
    NSLog(@"NotVisible: %@", _props.loggingID);
  }
}

// A method wrapper for the _props macro. Useful in debugger `p [self catProps]`.
- (NodeProps &)catProps
{
  return _props;  
}

@end
