//
//  TANavigationBar.h
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 28.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TANavigationBarDelegate;

@interface TANavigationBar : UIView

@property (nonatomic, weak) id <TANavigationBarDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *navBarLabel;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic) IBOutlet UIView *containerView;

@end


@protocol TANavigationBarDelegate <NSObject>

@optional
- (void) navigationBar:(TANavigationBar*)navBar backButtonClicked:(UIButton*)button;
- (void) navigationBar:(TANavigationBar*)navBar deleteButtonClicked:(UIButton*)button;
- (void) navigationBar:(TANavigationBar*)navBar addButtonClicked:(UIButton*)button;
- (void) navigationBar:(TANavigationBar *)navBar doneButtonClicked:(UIButton *)button;
- (void) navigationBar:(TANavigationBar *)navBar searchButtonClicked:(UIButton *)button;
- (void) navigationBar:(TANavigationBar *)navBar cancelButtonClicked:(UIButton *)button;

@end