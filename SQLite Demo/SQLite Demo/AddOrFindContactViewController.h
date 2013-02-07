//
//  AddOrFindContactViewController.h
//  SQLite Demo
//
//  Created by Suniket Wagh on 05/02/13.
//  Copyright (c) 2013 Suniket Wagh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface AddOrFindContactViewController : UIViewController <UITextFieldDelegate>
{
    sqlite3 *contactDB;
    NSString *databasePath;
}
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;

@property (strong, nonatomic) IBOutlet UITextField *addressTextField;
@property (strong, nonatomic) IBOutlet UITextField *contactNoTextField;
@property (strong, nonatomic)IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic)IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *contactNoLabel;
@property (strong, nonatomic) IBOutlet UIButton *findOrAddButton;

@property (nonatomic, assign) BOOL isAddContact;
- (IBAction)saveData:(id)sender;
- (IBAction)findContact:(id)sender;

-(void)findMe:(id)sender;

@end
