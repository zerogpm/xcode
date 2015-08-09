//
//  ViewController.h
//  MyFirstApplication
//
//  Created by Jian Su on 7/27/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

- (IBAction)buttonPress:(UIButton *)sender;

@end

