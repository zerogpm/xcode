//
//  ViewController.m
//  MyFirstApplication
//
//  Created by Jian Su on 7/27/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPress:(UIButton *)sender {
    self.titleLabel.text = @"Hello Man!";
}
@end
