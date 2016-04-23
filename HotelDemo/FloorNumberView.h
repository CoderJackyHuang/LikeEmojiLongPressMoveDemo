//
//  FloorNumberView.h
//  HotelDemo
//
//  Created by huangyibiao on 16/4/22.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FloorNumberViewDidTap)(NSUInteger floor);

// 左侧楼号
@interface FloorNumberView : UIView

- (instancetype)initWithFrame:(CGRect)frame didTap:(FloorNumberViewDidTap)didTap;

// 放大
- (void)zoomFloor:(NSUInteger)floor;

@end
