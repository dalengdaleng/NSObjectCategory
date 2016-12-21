//
//  ViewController.m
//  NSObjectCategory
//
//  Created by ios on 16/10/31.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableArray+Extension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *nilStr = nil;
    NSMutableArray *arrayM = [NSMutableArray array];
    [arrayM addObject:nilStr];
    [arrayM addObject:@"good"];
    
    for(int i = 0; i < [arrayM count];i++)
    {
        NSLog(@"%@",[arrayM objectAtIndex:i]);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
