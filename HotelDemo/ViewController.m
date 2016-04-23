//
//  ViewController.m
//  HotelDemo
//
//  Created by huangyibiao on 16/4/21.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "ViewController.h"
#import "HotelDetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
  // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)onEnterIntoHotelClicked:(id)sender {
  HotelDetailViewController *vc = [[HotelDetailViewController alloc] init];
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
