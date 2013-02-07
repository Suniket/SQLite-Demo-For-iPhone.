//
//  FindViewController.h
//  SQLite Demo
//
//  Created by Suniket Wagh on 06/02/13.
//  Copyright (c) 2013 Suniket Wagh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface FindViewController : UIViewController <UITextFieldDelegate>
{
    sqlite3 *contactDB;
     IBOutlet UITextField *nameTextField;

    IBOutlet UIButton *findButton;
     IBOutlet UILabel *detailLabel;
}
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
- (IBAction)findAction:(id)sender;
@end
