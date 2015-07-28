//
//  ChangingViewController.m
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 26.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import "ChangingViewController.h"
#import "TABirthday.h"
#import "TANavigationBar.h"

@interface ChangingViewController ()
@property (nonatomic, strong) TABirthday *birthday;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) NSMutableArray *birthdays;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleCounter;
@property (weak, nonatomic) IBOutlet UISwitch *enableSwitch;
@property (weak, nonatomic) IBOutlet UIButton *messageLabel;
@property (strong, nonatomic) UIAlertController *alertController;
@property (strong, nonatomic) TANavigationBar *navBar;
@end

@implementation ChangingViewController

- (id) initWithBirthdaysArray:(NSMutableArray*)birthdays atIndex:(NSInteger)index
{
    self = [super init];
    if (self) {
        _birthdays = birthdays;
        _index = index;
        if (index < birthdays.count) {
            _birthday = [[birthdays objectAtIndex:index] copy];
        } else {
             _birthday = [[TABirthday alloc] initWithTitle:@"" message:@"" date:nil andSubscribers:[[NSMutableArray alloc] init] andEnable:YES];
        }
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar = [[TANavigationBar alloc] initWithType:TANavigationBarTypeBackDoneRemove andTitle:@"Редактор"];
    [self.view addSubview:self.navBar.view];
    self.titleTextField.text = self.birthday.title;
    if (self.birthday.date) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm dd.MM.yyyy"];
        //[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
        _dateLabel.text = [formatter stringFromDate:self.birthday.date];
    } else {
        _dateLabel.text = @"установить";
    }
    _peopleCounter.text = [NSString stringWithFormat:@"%d",self.birthday.subscribers.count];
    [_enableSwitch setOn:self.birthday.enable animated:NO];

    _messageLabel.titleLabel.text = self.birthday.message;
}

- (IBAction)backButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneButtonClick:(id)sender {
    self.birthday.title = [self removeAllDoubleSpaces: self.titleTextField.text];
    self.birthday.enable = [self.enableSwitch isOn];
    if ([self.birthday.title isEqual:@""]) {
        UIAlertController *someAlertController = [UIAlertController alertControllerWithTitle:@"Ошибка" message:@"Введите заголовок" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [someAlertController addAction:action];
        [self presentViewController:someAlertController animated:YES completion:nil];
        return;
    }
    if (self.index < self.birthdays.count) {
        [self.birthdays replaceObjectAtIndex:self.index withObject:self.birthday];
    } else {
        [self.birthdays addObject:self.birthday];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString*)removeAllDoubleSpaces:(NSString*)line
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@" +" options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *lineForReturn = [regex stringByReplacingMatchesInString:line options:0 range:NSMakeRange(0, [line length]) withTemplate:@" "];
    if ([lineForReturn length] == 0) {
        return @"";
    }
    if ([lineForReturn characterAtIndex:0] == ' ') {
        lineForReturn = [lineForReturn substringFromIndex:1];
    }
    return lineForReturn;
}

- (IBAction)deleteButtonClick:(id)sender {
    if (self.index < self.birthdays.count)
        [self.birthdays removeObjectAtIndex:self.index];
    [self.navigationController popViewControllerAnimated:YES];
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
