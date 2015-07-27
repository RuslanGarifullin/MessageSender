//
//  WelcomeViewController.m
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 27.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import "WelcomeViewController.h"
#import "VKAuthViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)vkEnterButtonClick:(id)sender
{
    [[self navigationController] pushViewController:[[VKAuthViewController alloc] init] animated:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
