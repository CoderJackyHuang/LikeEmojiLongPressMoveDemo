//
//  BottomFloorsView.m
//  HotelDemo
//
//  Created by huangyibiao on 16/4/21.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "BottomFloorsView.h"

@interface BottomFloorModel : NSObject

@property (nonatomic, assign) NSUInteger floor;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isSelected;

@end

@implementation BottomFloorModel

@end

#define kItemWidth 60

@interface BottomFloorsView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, copy) BottomFloorsDidScroll didScrollBlock;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSources;

@end

@implementation BottomFloorsView

- (instancetype)initWithFrame:(CGRect)frame didScroll:(BottomFloorsDidScroll)didScroll {
  if (self = [super initWithFrame:frame]) {
    self.didScrollBlock = didScroll;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kItemWidth, frame.size.height);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds
                                             collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    // 默认
    [self scrollToFloor:18];
  }
  
  return self;
}

- (NSMutableArray *)dataSources {
  if (_dataSources == nil) {
    _dataSources = [[NSMutableArray alloc] init];
    for (NSUInteger i = 4; i <= 18; ++i) {
      BottomFloorModel *model = [[BottomFloorModel alloc] init];
      model.title = [NSString stringWithFormat:@"%@层", @(i)];
      model.floor = i;
      [_dataSources addObject:model];
    }
  }
  
  return _dataSources;
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
  UILabel *label = [cell.contentView viewWithTag:100];
  if (label == nil) {
    label = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
    [cell.contentView addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.tag = 100;
  }
  
  BottomFloorModel *model = self.dataSources[indexPath.item];
  if (model.isSelected) {
    label.textColor = [UIColor blueColor];
    label.font = [UIFont boldSystemFontOfSize:18];
  } else {
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14];
  }
  label.text = model.title;
  
  return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.dataSources.count;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  BottomFloorModel *model = self.dataSources[indexPath.item];
  
    [self scrollToFloor:model.floor];
  
  if (self.didScrollBlock) {
    self.didScrollBlock(model.floor);
  }
}

- (void)scrollToFloor:(NSUInteger)floor {
  __block NSUInteger atIndex = 0;
  [self.dataSources enumerateObjectsUsingBlock:^(BottomFloorModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
    if (obj.floor == floor) {
      obj.isSelected = YES;
      atIndex = idx;
    } else {
      obj.isSelected = NO;
    }
  }];
  [self.collectionView reloadData];
  
  UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
  
  NSUInteger count = self.collectionView.visibleCells.count;
  NSUInteger begin = count / 2 + 1;
    if (atIndex > begin) {
      CGFloat maxOffsetX = (atIndex - 2) * layout.itemSize.width;
      if (maxOffsetX >= self.dataSources.count * layout.itemSize.width - self.collectionView.frame.size.width) {
        maxOffsetX = self.dataSources.count * layout.itemSize.width - self.collectionView.frame.size.width;
      }
      
      [self.collectionView setContentOffset:CGPointMake(maxOffsetX, 0)
                                   animated:YES];
    } else {
      [self.collectionView setContentOffset:CGPointMake(0, 0)
                                   animated:YES];
    }
}

@end
