//
//  DeleteViewController.h
//  SQLite Demo
//
//  Created by Suniket Wagh on 07/02/13.
//  Copyright (c) 2013 Suniket Wagh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"


@interface DeleteViewController : UIViewController
{
    IBOutlet UIButton *deleteButton;
    
     IBOutlet UITextField *nameTextField;
     IBOutlet UILabel *statusLabel;

}
- (IBAction)deleteAction:(id)sender;
@end
