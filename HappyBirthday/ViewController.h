//
//  ViewController.h
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 26.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *birthdayTableView;
@property (strong, nonatomic) NSMutableArray *birthdaysArray;
@property (strong, nonatomic) NSMutableArray *friendsArray;
@property (weak, nonatomic) IBOutlet UIView *haveNothingNotificationView;

@end
