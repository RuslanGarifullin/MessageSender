//
//  TANavigationBar.h
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 28.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TANavigationBarType) {
    TANavigationBarTypeDefault,
    TANavigationBarTypeBackDoneRemove,
    TANavigationBarTypeSearchAdd,
    TANavigationBarTypeBackSearchAdd,
    TANavigationBarTypeNone
};

@protocol TANavigationBarDelegate;


@interface TANavigationBar : UIViewController

- (instancetype)initWithType:(TANavigationBarType)type andTitle:(NSString*)title;
@property (nonatomic, weak) id <TANavigationBarDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *navBarLabel;

@end


@protocol TANavigationBarDelegate <NSObject>

@optional
- (void) navigationBar:(TANavigationBar*)navBar backButtonClicked:(UIButton*)button;
- (void) navigationBar:(TANavigationBar*)navBar deleteButtonClicked:(UIButton*)button;
- (void) navigationBar:(TANavigationBar*)navBar addButtonClicked:(UIButton*)button;
- (void) navigationBar:(TANavigationBar *)navBar doneButtonClicked:(UIButton *)button;
- (void) navigationBar:(TANavigationBar *)navBar searchButtonClicked:(UIButton *)button;

@end