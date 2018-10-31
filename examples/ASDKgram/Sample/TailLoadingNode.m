//
//  TailLoadingNode.m
//  Texture
//
//  Copyright (c) Pinterest, Inc.  All rights reserved.
//  Licensed under Apache 2.0: http://www.apache.org/licenses/LICENSE-2.0
//

#import "TailLoadingNode.h"

#import <AsyncDisplayKit/ASDisplayNode+Beta.h>

#define TailLoadingNodeHeight 100

@interface TailLoadingNode ()
@property (nonatomic, strong) ASDisplayNode *activityIndicatorNode;
@end

@implementation TailLoadingNode

- (instancetype)init
{
  if (self = [super init]) {
    self.automaticallyManagesSubnodes = YES;

    _activityIndicatorNode = [[ASDisplayNode alloc] initWithViewBlock:^{
      UIActivityIndicatorView *v = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
      [v startAnimating];
      return v;
    }];

    // Set a static height for the loading node
    self.style.height = ASDimensionMake(TailLoadingNodeHeight);

    [self setupYogaLayoutIfNeeded];
  }
  return self;
}

#if !YOGA && AS_ENABLE_LAYOUTSPECS
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
  return [ASCenterLayoutSpec centerLayoutSpecWithCenteringOptions:ASCenterLayoutSpecCenteringXY sizingOptions:ASCenterLayoutSpecSizingOptionMinimumXY child:self.activityIndicatorNode];
}
#endif

- (void)setupYogaLayoutIfNeeded
{
#if YOGA
  [self.style yogaNodeCreateIfNeeded];
  [self.activityIndicatorNode.style yogaNodeCreateIfNeeded];

  self.style.alignItems =  ASStackLayoutAlignItemsCenter;
  self.style.justifyContent = ASStackLayoutJustifyContentCenter;
  [self addYogaChild:self.activityIndicatorNode];
#endif
}

@end
