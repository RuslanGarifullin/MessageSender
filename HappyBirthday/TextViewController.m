//
//  TextViewController.m
//  HappyBirthday
//
//  Created by Ruslan on 04.08.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import "TextViewController.h"
#import "TANavigationBar.h"

@interface TextViewController () <TANavigationBarDelegate>
@property (strong, nonatomic) IBOutlet TANavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //Initialize navigation bar
    
    [self.navBar.doneButton setHidden:NO];
    [self.navBar.backButton setHidden:NO];
    [self.navBar.deleteButton setHidden:NO];
    self.navBar.navBarLabel.text = @"Новый шаблон";
   
    self.textView.layer.cornerRadius=15;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - TANavigationBarDelegate

- (void) navigationBar:(TANavigationBar*)navBar backButtonClicked:(UIButton*)button
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
