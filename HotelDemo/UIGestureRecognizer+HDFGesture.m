//
//  UIGestureRecognizer+HDFGesture.m
//  DEMO
//
//  Created by huangyibiao on 15/6/10.
//  Copyright (c) 2015年 huangyibiao. All rights reserved.
//

#import <objc/runtime.h>
#import "UIGestureRecognizer+HDFGesture.h"

static const void *s_HDFGestureReconizerBlockKey = "s_HDFGestureReconizerBlockKey";
static const void *s_HDFLongGestureReconizerBlockKey = "s_HDFLongGestureReconizerBlockKey";

@implementation UIGestureRecognizer (HDFGesture)

- (void)setHdf_gestureBlock:(HDFGestureBlock)gestureBlock {
  objc_setAssociatedObject(self, s_HDFGestureReconizerBlockKey, gestureBlock, OBJC_ASSOCIATION_COPY);
  
  [self removeTarget:self action:@selector(onGestureCallback:)];
  if (gestureBlock) {
    [self addTarget:self action:@selector(onGestureCallback:)];
  }
}

- (HDFGestureBlock)hdf_gestureBlock {
  return objc_getAssociatedObject(self, s_HDFGestureReconizerBlockKey);
}

- (void)setHdf_longGestureBlock:(HDFLongGestureBlock)hdf_longGestureBlock {
  objc_setAssociatedObject(self,
                           s_HDFLongGestureReconizerBlockKey,
                           hdf_longGestureBlock,
                           OBJC_ASSOCIATION_COPY);
  
  [self removeTarget:self action:@selector(onLongGestureCallback:)];
  
  if (hdf_longGestureBlock) {
    [self addTarget:self action:@selector(onLongGestureCallback:)];
  }
}

- (HDFLongGestureBlock)hdf_longGestureBlock {
  return objc_getAssociatedObject(self, s_HDFLongGestureReconizerBlockKey);
}

- (void)onGestureCallback:(UIGestureRecognizer *)gesture {
  HDFGestureBlock block = [self hdf_gestureBlock];
  
  if (block) {
    block(gesture);
  }
}

- (void)onLongGestureCallback:(UILongPressGestureRecognizer *)gesture {
  HDFLongGestureBlock block = [self hdf_longGestureBlock];
  
  if (block) {
    block(gesture);
  }
}

@end
