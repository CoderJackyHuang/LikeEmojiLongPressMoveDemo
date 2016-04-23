//
//  BottomFloorsView.h
//  HotelDemo
//
//  Created by huangyibiao on 16/4/21.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <UIKit/UIKit.h>

// 滚动到第几层
typedef void(^BottomFloorsDidScroll)(NSUInteger floor);

// 底部的楼层
@interface BottomFloorsView : UIView

- (instancetype)initWithFrame:(CGRect)frame didScroll:(BottomFloorsDidScroll)didScroll;

// 手动滚动到第X层
- (void)scrollToFloor:(NSUInteger)floor;

@end
