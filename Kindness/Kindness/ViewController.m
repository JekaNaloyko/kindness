//
//  ViewController.m
//  Kindness
//
//  Created by Ievgen Naloiko on 2/1/15.
//  Copyright (c) 2015 naloiko. All rights reserved.
//

#import "ViewController.h"
#import "MapViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self buildView];
}

- (void)buildView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    {
        button.frame = CGRectMake(100, 100, 100, 100);
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:@"Map" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pickLocation:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pickLocation:(id)sender {
    
    MapViewController *mapVC = [MapViewController new];
    {
        [self.navigationController pushViewController:mapVC animated:YES];
    }
    
}

@end
