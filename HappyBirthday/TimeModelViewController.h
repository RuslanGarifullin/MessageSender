//
//  TimeModelViewController.h
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 03.08.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimeModelViewControllerDelegate;

@interface TimeModelViewController : UIViewController

@property (nonatomic, weak) id <TimeModelViewControllerDelegate> delegate;

@end

@protocol TimeModelViewControllerDelegate

- (void) timeModelViewController:(TimeModelViewController*)cancelled;
- (void) timeModelViewController:(TimeModelViewController *)viewController doneWithDate:(NSDate*)date;

@end