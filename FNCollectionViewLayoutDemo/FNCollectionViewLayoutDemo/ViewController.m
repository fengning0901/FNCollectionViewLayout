//
//  ViewController.m
//  FNCollectionViewLayoutDemo
//
//  Created by 冯宁 on 2017/8/10.
//  Copyright © 2017年 demo. All rights reserved.
//

#import "ViewController.h"
#import "DemoOneViewController.h"
#import "DemoTwoViewController.h"
#import "DemoThreeViewController.h"
#import "DemoFourViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat sw = [UIScreen mainScreen].bounds.size.width;
    CGFloat top = 64;
    NSInteger boxPerLine = 2;
    CGFloat padding = sw * 0.1 / (boxPerLine + 1);
    CGFloat w = sw * 0.9 / boxPerLine;
    
    {
        NSInteger i = 0;
        NSInteger n = 1;
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(padding + (w + padding) * (n - 1), (top + (padding + w) * floor(i / boxPerLine)) + padding, w, w)];
        [button setTitle:@"DEMO1" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[self imageWithColor:[UIColor whiteColor] size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
        [button setBackgroundImage:[self imageWithColor:[UIColor blackColor] size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
        button.layer.borderColor = [UIColor grayColor].CGColor;
        button.layer.borderWidth = 1;
        button.tag = 0;
        [button addTarget:self action:@selector(goDemo:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
    }
    
    {
        NSInteger i = 1;
        NSInteger n = 2;
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(padding + (w + padding) * (n - 1), (top + (padding + w) * floor(i / boxPerLine)) + padding, w, w)];
        [button setTitle:@"DEMO2" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[self imageWithColor:[UIColor whiteColor] size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
        [button setBackgroundImage:[self imageWithColor:[UIColor blackColor] size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
        button.layer.borderColor = [UIColor grayColor].CGColor;
        button.layer.borderWidth = 1;
        button.tag = 1;
        [button addTarget:self action:@selector(goDemo:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
    }
    
    {
        NSInteger i = 2;
        NSInteger n = 1;
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(padding + (w + padding) * (n - 1), (top + (padding + w) * floor(i / boxPerLine)) + padding, w, w)];
        [button setTitle:@"DEMO3" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[self imageWithColor:[UIColor whiteColor] size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
        [button setBackgroundImage:[self imageWithColor:[UIColor blackColor] size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
        button.layer.borderColor = [UIColor grayColor].CGColor;
        button.layer.borderWidth = 1;
        button.tag = 2;
        [button addTarget:self action:@selector(goDemo:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
    }
    
    {
        NSInteger i = 3;
        NSInteger n = 2;
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(padding + (w + padding) * (n - 1), (top + (padding + w) * floor(i / boxPerLine)) + padding, w, w)];
        [button setTitle:@"DEMO4" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[self imageWithColor:[UIColor whiteColor] size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
        [button setBackgroundImage:[self imageWithColor:[UIColor blackColor] size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
        button.layer.borderColor = [UIColor grayColor].CGColor;
        button.layer.borderWidth = 1;
        button.tag = 3;
        [button addTarget:self action:@selector(goDemo:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
    }
}

- (void)goDemo:(UIButton*)sender {
    switch (sender.tag) {
        case 0:
            [self.navigationController pushViewController:[DemoOneViewController new] animated:YES];
            break;
            
        case 1:
            [self.navigationController pushViewController:[DemoTwoViewController new] animated:YES];
            break;
            
        case 2:
            [self.navigationController pushViewController:[DemoThreeViewController new] animated:YES];
            break;
        
        case 3:
            [self.navigationController pushViewController:[DemoFourViewController new] animated:YES];
            break;
            
        default:
            break;
    }
}


- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
