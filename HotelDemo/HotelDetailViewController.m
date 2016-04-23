//
//  HotelDetailViewController.m
//  HotelDemo
//
//  Created by huangyibiao on 16/4/21.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HotelDetailViewController.h"
#import "UINavigationBar+HDFNavigationBarTransluent.h"
#import "BottomFloorsView.h"
#import "FloorView.h"
#import "FloorNumberView.h"

#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kIs5OrLater ([[UIScreen mainScreen] currentMode].size.height >= 960)
#define kScreenBounds ([UIScreen mainScreen].bounds)
#define kIs6Plus (kScreenHeight >= 667)
#define kIs6 (kScreenHeight > 568 && kScreenHeight < 667)

@interface HotelDetailViewController ()

@property (nonatomic, strong) BottomFloorsView *bottomView;
@property (nonatomic, strong) FloorView *floorView;
@property (nonatomic, strong) FloorNumberView *numberView;

@end

@implementation HotelDetailViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  
  [self.navigationController.navigationBar hdf_setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  
  [self.navigationController.navigationBar hdf_reset];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor whiteColor];
  self.edgesForExtendedLayout = UIRectEdgeAll;
  
  // 背景
  UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
  [self.view addSubview:bgView];
  NSString *path = [[NSBundle mainBundle] pathForResource:@"floor_background" ofType:@"png"];
  bgView.image = [UIImage imageWithContentsOfFile:path];
  
  // 最底下滚动第N层
self.bottomView = [[BottomFloorsView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 40) didScroll:^(NSUInteger floor) {
  [self onSelectBottomFloortAtFloor:floor];
}];
  [self.view addSubview:self.bottomView];
  self.bottomView.backgroundColor = [UIColor whiteColor];
  
  // 底下三楼
  path = [[NSBundle mainBundle] pathForResource:@"floor_bottom" ofType:@"png"];
  UIImage *image = [UIImage imageWithContentsOfFile:path];
  UIImageView *bottomFloorImageView = [[UIImageView alloc] initWithImage:image];
  [self.view addSubview:bottomFloorImageView];
  bottomFloorImageView.frame = CGRectMake(0, self.bottomView.frame.origin.y - image.size.height - 0.5, self.view.frame.size.width, image.size.height);
  bottomFloorImageView.center = CGPointMake(self.view.center.x, bottomFloorImageView.center.y);
  
  // 楼层
  CGFloat h = 17 * (18 - 4 + 1) + 50;
  CGFloat padding = 58 * (kScreenWidth / 320.0);
  CGFloat w = self.view.frame.size.width - padding * 2.45;
  self.floorView = [[FloorView alloc] initWithFrame:CGRectMake(padding - 10, bottomFloorImageView.frame.origin.y - h, w + 20, h) didTap:^(NSUInteger floor) {
    [self onSelectFloorViewAtFloor:floor];
  }];
  [self.view addSubview:self.floorView];
  
  // 左侧楼号
  self.numberView = [[FloorNumberView alloc] initWithFrame:CGRectMake(self.floorView.frame.origin.x - 33, self.floorView.frame.origin.y + 50 - 16.5, 19, 16.5 * (19 - 3)) didTap:^(NSUInteger floor) {
    [self onSelectLeftFloorNumber:floor];
  }];
  [self.view addSubview:self.numberView];
}

- (void)onSelectFloorViewAtFloor:(NSUInteger)floor {
  [self.bottomView scrollToFloor:floor];
  [self.numberView zoomFloor:floor];
}

- (void)onSelectBottomFloortAtFloor:(NSUInteger)floor {
  [self.floorView zoomFloor:floor];
  [self.numberView zoomFloor:floor];
}

- (void)onSelectLeftFloorNumber:(NSUInteger)floor {
  [self.bottomView scrollToFloor:floor];
  [self.floorView zoomFloor:floor];
}

@end
