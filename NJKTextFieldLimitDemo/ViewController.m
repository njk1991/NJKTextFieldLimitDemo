//
//  ViewController.m
//  NJKTextFieldLimitDemo
//
//  Created by JiakaiNong on 15/12/24.
//  Copyright © 2015年 poco. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+Limit.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

static const NSInteger kLimitLength = 5;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.textField addTarget:self action:@selector(handleLimitedTextField) forControlEvents:UIControlEventEditingChanged];
}

- (void)handleLimitedTextField {
    if (![self.textField limitTextLength:kLimitLength]) {
        NSLog(@"NO");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
