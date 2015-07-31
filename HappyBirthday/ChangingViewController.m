//
//  ChangingViewController.m
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 26.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import "ChangingViewController.h"
#import "TABirthday.h"
#import "TAApplicationStorage.h"
#import "TANavigationBar.h"
#import "TAChangingCell.h"

@interface ChangingViewController () <TANavigationBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) TABirthday *birthday;
@property (nonatomic, assign) NSInteger index;
@property (strong, nonatomic) UIAlertController *alertController;
@property (strong, nonatomic) TANavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UITableView *optionsTableView;
@property (weak, nonatomic) UISwitch *enableSwitch;
@property (strong, nonatomic) UITextField *generalTitleTextField;

@end

@implementation ChangingViewController

- (id) initWithIndex:(NSInteger)index {
    self = [super init];
    if (self) {
        self.index = index;
        if (index < [[self birthdayArray] count]) {
            self.birthday = [[[self birthdayArray] objectAtIndex:index] copy];
        } else {
            self.birthday = [[TABirthday alloc] initWithTitle:@"" message:@"" date:nil andSubscribers:nil andEnable:NO];
        }
        
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    //Initialize navigation bar
    self.navBar = [[TANavigationBar alloc] initWithType:TANavigationBarTypeBackDoneRemove andTitle:@"Редактор"];
    [self.navBar setDelegate:self];
    [self.view addSubview:self.navBar.view];
    
    [self.optionsTableView setDelegate: self];
    [self.optionsTableView setDataSource:self];
    
    UINib *nib = [UINib nibWithNibName:@"TAChangingCell" bundle:nil];
    [self.optionsTableView registerNib:nib forCellReuseIdentifier:@"TAChangingCell"];
}



- (NSMutableArray*) birthdayArray {
    return [[TAApplicationStorage sharedLocator] birthdaysArray];
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

#pragma mark - TANavigationBarDelegate

- (void) navigationBar:(TANavigationBar *)navBar doneButtonClicked:(UIButton *)button
{
    self.birthday.title = [self removeAllDoubleSpaces: self.generalTitleTextField.text];
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
    if (self.index < [[self birthdayArray] count]) {
        [[self birthdayArray] replaceObjectAtIndex:self.index withObject:self.birthday];
    } else {
        [[self birthdayArray] addObject: self.birthday];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) navigationBar:(TANavigationBar *)navBar deleteButtonClicked:(UIButton *)button
{
    if (self.index < [[self birthdayArray] count])
        [[self birthdayArray] removeObjectAtIndex:self.index];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) navigationBar:(TANavigationBar *)navBar backButtonClicked:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"TAChangingCell";
    TAChangingCell *cell = [self.optionsTableView dequeueReusableCellWithIdentifier:identifier];
    switch (indexPath.row) {
        case 0:
            self.generalTitleTextField = cell.generalTextField;
            [self.generalTitleTextField setHidden:NO];
            [self.generalTitleTextField setText:self.birthday.title];
            [cell.titleLabel setHidden:YES];
            [cell.rightImageView setHidden:YES];
            [cell.descriptionLabel setHidden:YES];
            [cell.leftImageView setImage:[UIImage imageNamed:@"ic_bookmark_border"]];
            break;
        case 1:
            [cell.titleLabel setText:@"Дата"];
            if (self.birthday.date) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"HH:mm dd.MM.yyyy"];
                cell.descriptionLabel.text = [formatter stringFromDate:self.birthday.date];
            } else {
                cell.descriptionLabel.text = @"установить";
            }
            cell.leftImageView.image = [UIImage imageNamed:@"ic_access_time"];
            break;
        case 2:
            [cell.titleLabel setText:@"Получатели"];
            [cell.descriptionLabel setText:[NSString stringWithFormat:@"%d",self.birthday.subscribers.count]];
            [cell.leftImageView setImage:[UIImage imageNamed:@"ic_face"]];
            break;
        case 3:
            self.enableSwitch = cell.enableSwitch;
            [cell.enableSwitch setHidden:NO];
            [cell.enableSwitch setOn:self.birthday.enable];
            [cell.descriptionLabel setHidden:YES];
            [cell.rightImageView setHidden:YES];
            [cell.leftImageView setImage: [UIImage imageNamed:@"ic_power_settings_new"]];
            [cell.titleLabel setText:@"Разрешить отправку"];
            break;
        case 4:
            [cell.titleLabel setText:@"Сообщение"];
            [cell.descriptionLabel setHidden:YES];
            [cell.leftImageView setImage: [UIImage imageNamed:@"ic_message"]];
            break;
        default:
            break;
    }
    return cell;
}



#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}














@end
