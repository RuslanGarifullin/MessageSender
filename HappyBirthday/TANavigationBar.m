//
//  TANavigationBar.m
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 28.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import "TANavigationBar.h"



@interface TANavigationBar ()
@property (nonatomic, assign) TANavigationBarType type;
@property (nonatomic, strong) NSString *barTitle;
@end

@implementation TANavigationBar

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.barTitle != nil) {
        self.navBarLabel.text = self.barTitle;
    }
    self.view.frame = CGRectMake(0, 0, 320, 75);
    switch (self.type) {
        case TANavigationBarTypeDefault:
            [self.backButton setHidden:NO];
            break;
        case TANavigationBarTypeBackDoneRemove:
            [self.backButton setHidden:NO];
            [self.doneButton setHidden:NO];
            [self.deleteButton setHidden:NO];
            break;
        case TANavigationBarTypeSearchAdd:
            [self.searchButton setHidden:NO];
            [self.addButton setHidden:NO];
            break;
        case TANavigationBarTypeBackSearchAdd:
            [self.backButton setHidden:NO];
            [self.searchButton setHidden:NO];
            [self.addButton setHidden:NO];
            break;
        case TANavigationBarTypeNone:
            break;
        default:
            break;
    }
}

- (instancetype)initWithType:(TANavigationBarType)type andTitle:(NSString*)title
{
    self = [super init];
    if (self) {
        _type = type;
        _barTitle = title;
    }
    return self;
}

- (void) dealloc {
    NSLog(@"Our navigation bar was removed");
}

- (IBAction)backButtonClicked:(UIButton*)sender
{
    if (self.delegate != nil) {
        if ([self.delegate respondsToSelector:@selector(navigationBar:backButtonClicked:)]) {
            [self.delegate navigationBar:self backButtonClicked:sender];
        } else {
            NSLog(@"from TANavigationBar delegate doesn't have method's realization");
        }
    } else {
        NSLog(@"from TANavigationBar delegate == nil");
    }
}

- (IBAction)doneButtonClicked:(UIButton*)sender
{
    if (self.delegate != nil) {
        if ([self.delegate respondsToSelector:@selector(navigationBar:doneButtonClicked:)]) {
            [self.delegate navigationBar:self doneButtonClicked:sender];
        } else {
            NSLog(@"from TANavigationBar delegate doesn't have method's realization");
        }
    } else {
        NSLog(@"from TANavigationBar delegate == nil");
    }
}

- (IBAction)deleteButtonClicked:(UIButton*)sender
{
    if (self.delegate != nil) {
        if ([self.delegate respondsToSelector:@selector(navigationBar:deleteButtonClicked:)]) {
            [self.delegate navigationBar:self deleteButtonClicked:sender];
        } else {
            NSLog(@"from TANavigationBar delegate doesn't have method's realization");
        }
    } else {
        NSLog(@"from TANavigationBar delegate == nil");
    }
}

- (IBAction)addButtonClicked:(UIButton*)sender
{
    if (self.delegate != nil) {
        if ([self.delegate respondsToSelector:@selector(navigationBar:addButtonClicked:)]) {
            [self.delegate navigationBar:self addButtonClicked:sender];
        } else {
            NSLog(@"from TANavigationBar delegate doesn't have method's realization");
        }
    } else {
        NSLog(@"from TANavigationBar delegate == nil");
    }
}

- (IBAction)searchButtonClicked:(UIButton*)sender
{
    if (self.delegate != nil) {
        if ([self.delegate respondsToSelector:@selector(navigationBar:searchButtonClicked:)]) {
            [self.delegate navigationBar:self searchButtonClicked:sender];
        } else {
            NSLog(@"from TANavigationBar delegate doesn't have method's realization");
        }
    } else {
        NSLog(@"from TANavigationBar delegate == nil");
    }
}


@end
