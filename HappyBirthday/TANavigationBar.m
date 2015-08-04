//
//  TANavigationBar.m
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 28.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import "TANavigationBar.h"
#import "PureLayout.h"



@interface TANavigationBar () {
    CGRect firstSearchFieldState;
    CGRect firstCancelButtonState;
}

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation TANavigationBar

#pragma mark - constructors
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadFromNib];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self loadFromNib];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadFromNib];
    }
    return self;
}

- (void)loadFromNib
{
    [[NSBundle mainBundle] loadNibNamed:@"TANavigationBar" owner:self options:nil];
    firstSearchFieldState = self.searchTextField.frame;
    firstCancelButtonState = self.cancelButton.frame;
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.containerView];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.containerView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.containerView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.containerView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.containerView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
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
    [self.searchButton setHidden:YES];
    [self.backButton setHidden:YES];
    [self.navBarLabel setHidden:YES];
    [self.searchTextField setHidden:NO];
    [self.cancelButton setHidden:NO];
    [self.searchTextField setAlpha:0.f];
    [self.searchTextField setText:@""];
    [UIView animateWithDuration:0.3f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.searchTextField setFrame:CGRectMake(8, self.searchTextField.frame.origin.y, self.frame.size.width - self.cancelButton.frame.size.width - 12, self.searchTextField.frame.size.height)];
        [self.searchTextField setAlpha:1.f];
        [self.cancelButton setCenter:CGPointMake(self.frame.size.width-self.cancelButton.frame.size.width/2, self.cancelButton.center.y)];
    } completion:nil];
}
- (IBAction)cancelButtonClicked:(id)sender
{
    if (self.delegate != nil) {
        if ([self.delegate respondsToSelector:@selector(navigationBar:cancelButtonClicked:)]) {
            [self.delegate navigationBar:self cancelButtonClicked:sender];
        } else {
            NSLog(@"from TANavigationBar delegate doesn't have method's realization");
        }
    } else {
        NSLog(@"from TANavigationBar delegate == nil");
    }
    [self.backButton setAlpha:0.f];
    [self.searchButton setAlpha:0.f];
    [self.navBarLabel setAlpha:0.f];
    [self.searchButton setHidden:NO];
    [self.backButton setHidden:NO];
    [self.navBarLabel setHidden:NO];
    [UIView animateWithDuration:.3f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.searchTextField setFrame:firstSearchFieldState];
        [self.searchTextField setAlpha:0.f];
        [self.cancelButton setFrame:firstCancelButtonState];
        [self.searchButton setAlpha:1.f];
        [self.backButton setAlpha:1.f];
        [self.navBarLabel setAlpha:1.f];
    } completion:^(BOOL finished){
        [self.searchTextField setHidden:YES];
        [self.cancelButton setHidden:YES];
    }];
}


@end
