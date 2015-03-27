//
//  ViewController.m
//  TopButtonView
//
//  Created by apple on 15/3/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LXTopButtonScrollView.h"

@interface ViewController () <UIScrollViewDelegate, LXTopViewSelectDelegate>
{
    UIScrollView *scrollV;
    UIView *topView;
    LXTopButtonScrollView *topButtonView;
    NSInteger recodeCurrentView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Test TopView";
    
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth, 44)];
    topView.backgroundColor = LXColor(230, 230, 230);
    [self.view addSubview:topView];
    
    //创建用于放置顶部滚动按钮的view
    NSArray *buttonTitleArr = @[@"观点", @"纸条", @"互动", @"宝箱"];
    topButtonView = [[LXTopButtonScrollView alloc] initWithFrame:CGRectMake(18, 0, kMainScreenWidth - 36, 44) andTitleArray:buttonTitleArr andDelegate:self];
    [topView addSubview:topButtonView];
    
    //创建于用放三个tableView的滚动视图
    scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topView.frame.origin.y + topView.frame.size.height, kMainScreenWidth, kMainScreenHeight - topView.frame.origin.y - topView.frame.size.height)];
    [scrollV setPagingEnabled:YES];
    [scrollV setShowsHorizontalScrollIndicator:NO];
    scrollV.delegate = self;
    scrollV.bounces = NO;
    scrollV.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollV];
    
    recodeCurrentView = 1;
    for (int i = 0; i < buttonTitleArr.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(scrollV.frame.size.width * i, 0, scrollV.frame.size.width, scrollV.frame.size.height)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i]];
        [scrollV addSubview:imageView];
        [scrollV setContentSize:CGSizeMake(scrollV.frame.size.width * buttonTitleArr.count, scrollV.frame.size.height)];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = (NSInteger)(scrollView.contentOffset.x/scrollV.frame.size.width) + 1;
    
    [topButtonView changeBtnStatus:index];
}

#pragma mark --LYCTopScrollViewSelectDelegate
- (void)buttonDidSelected:(NSInteger)selectedIndex
{
    NSLog(@"%ld", selectedIndex);
    
    recodeCurrentView = selectedIndex;
    [scrollV scrollRectToVisible:CGRectMake(scrollV.frame.size.width * (selectedIndex - 1), scrollV.frame.origin.y, scrollV.frame.size.width, scrollV.frame.size.height) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


