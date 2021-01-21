//
//  ViewController.m
//  idcard
//
//  Created by developer on 2020/12/30.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UIColor.redColor;
    view.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:view];
}


@end
