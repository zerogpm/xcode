//
//  ViewController.m
//  Demo
//
//  Created by Jian Su on 8/11/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *InputText;
@property (weak, nonatomic) IBOutlet UILabel *textBox;
@end

@implementation ViewController

- (IBAction)Button:(id)sender {
    NSString * InputString = [[self InputText] text];
    NSString * MyString = @"yes";
    
    NSString * contents = [NSString stringWithFormat:@"%@ %@", InputString, MyString];
    
    [self.textBox setText:contents];
    //self.InputText.resignFirstResponder;
    [[self InputText] resignFirstResponder];
    UIAlertView *myAlert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:contents delegate:nil cancelButtonTitle:@"go Away?" otherButtonTitles:nil, nil];
    
    [myAlert show];
    
    NSLog(@"%@", self.textBox.text);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
