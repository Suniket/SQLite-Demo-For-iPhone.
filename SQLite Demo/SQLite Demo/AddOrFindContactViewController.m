//
//  AddOrFindContactViewController.m
//  SQLite Demo
//
//  Created by Suniket Wagh on 05/02/13.
//  Copyright (c) 2013 Suniket Wagh. All rights reserved.
//

#import "AddOrFindContactViewController.h"
#import "AppDelegate.h"


@interface AddOrFindContactViewController ()

@end

@implementation AddOrFindContactViewController

@synthesize statusLabel,addressLabel,addressTextField,contactNoLabel,contactNoTextField,findOrAddButton,nameLabel,nameTextField;
@synthesize isAddContact = _isAddContact;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    
  //  databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"contacts.sqlite"]];
    AppDelegate *del = (AppDelegate*)[[UIApplication sharedApplication]delegate];

    NSString* destPath = [del getDestPath];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: destPath ] == NO)
    {
        const char *dbpath = [destPath UTF8String];
        
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, PHONE TEXT)";
            
            if (sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                statusLabel.text = @"Failed to create table";
            }
            
            sqlite3_close(contactDB);
            
        } else {
            statusLabel.text = @"Failed to open/create database";
        }
    }
    
    [super viewDidLoad];
    if(self.isAddContact)
    {
        self.title = @"Add Contact";
        [self.findOrAddButton setTitle:@"Add" forState:UIControlStateNormal];
        [self.findOrAddButton addTarget:self action:@selector(saveData:) forControlEvents:UIControlEventTouchUpInside];
    }
//    else{
//        self.title = @"Find Contact";
//        [self.findOrAddButton setTitle:@"Find" forState:UIControlStateNormal];
//        [self.findOrAddButton addTarget:self action:@selector(findMe:) forControlEvents:UIControlEventTouchUpInside];
//        self.addressLabel.frame = CGRectMake(15, 70, 290, 110);
//        self.addressLabel.numberOfLines = 4;
//        [self.addressLabel setFont:[UIFont systemFontOfSize:17]];
//        self.addressTextField.hidden = YES;
//        self.contactNoLabel.hidden = YES;
//        self.contactNoTextField.hidden = YES;
//        self.addressLabel.text = @"";
//        self.nameLabel.text = @"Name:";
//    }

}

- (IBAction)findContact:(id)sender {
    
//    AppDelegate *del = (AppDelegate*)[[UIApplication sharedApplication]delegate];
//    
//    NSString* destPath = [del getDestPath];
//    const char *dbpath=[destPath UTF8String ];
//    sqlite3_stmt    *statement;
//    
//    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
//    {
//        NSString *querySQL = [NSString stringWithFormat: @"SELECT address, phone FROM contacts WHERE name=\"%@\"", nameTextField.text];
//        
//        const char *query_stmt = [querySQL UTF8String];
//        
//        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
//        {
//            if (sqlite3_step(statement) == SQLITE_ROW)
//            {
//                NSString *addressField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
//                //address.text = addressField;
//                
//                NSString *phoneField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
//                //phone.text = phoneField;
//                self.addressLabel.text = [NSString stringWithFormat:@"Address is %@ and Contact Number is %@", addressField, phoneField];
//                statusLabel.text = @"Match found";
//                
//            } else {
//                self.addressLabel.text = @"";
//                statusLabel.text = @"Match not found";
//                addressTextField.text = @"";
//                contactNoTextField.text = @"";
//            }
//            sqlite3_finalize(statement);
//        }
//        sqlite3_close(contactDB);
//    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)findMe:(id)sender{

    AppDelegate *del = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    NSString* destPath = [del getDestPath];
    const char *dbpath=[destPath UTF8String ];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT address, phone FROM contacts WHERE name=\"%@\"", nameTextField.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *addressField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                //address.text = addressField;
                
                NSString *phoneField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                //phone.text = phoneField;
                self.addressLabel.text = [NSString stringWithFormat:@"Address is %@ and Contact Number is %@", addressField, phoneField];
                statusLabel.text = @"Match found";
                
            } else {
                self.addressLabel.text = @"";
                statusLabel.text = @"Match not found";
                addressTextField.text = @"";
                contactNoTextField.text = @"";
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }


}
- (IBAction)saveData:(id)sender {
    
    sqlite3_stmt    *statement;
    
   // const char *dbpath = [databasePath UTF8String];
    AppDelegate *del = (AppDelegate*)[[UIApplication sharedApplication]delegate];

    NSString* destPath = [del getDestPath];
    const char *dbpath=[destPath UTF8String ];
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO CONTACTS (name, address, phone) VALUES (\"%@\", \"%@\", \"%@\")", nameTextField.text, addressTextField.text, contactNoTextField.text];
        
        NSLog(@"nameTextField--%@",nameTextField.text);
        NSLog(@"addressTextField--%@",addressTextField.text);
        NSLog(@"contactNoTextField--%@",contactNoTextField.text);

        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            statusLabel.text = @"Contact added";
            nameTextField.text = @"";
            addressTextField.text = @"";
            contactNoTextField.text = @"";
        } else {
            statusLabel.text = @"Failed to add contact";
        }
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
        
//        const char *query="INSERT INTO CONTACTS (name, address, phone) VALUES(?,?,?)";
//        
//        if(sqlite3_prepare_v2(contactDB, query, -1, &statement, NULL)==SQLITE_OK)
//        {
//            NSString *name=nameTextField.text;
//            NSString *address=addressTextField.text;
//            NSString *phone=contactNoTextField.text;
//
//            NSLog(@"nameTextField--%@",nameTextField.text);
//            NSLog(@"addressTextField--%@",addressTextField.text);
//            NSLog(@"contactNoTextField--%@",contactNoTextField.text);
//
//            
//            sqlite3_bind_text(statement, 1, [name UTF8String], -1, NULL);
//            sqlite3_bind_text(statement, 2, [address UTF8String], -1, NULL);
//            sqlite3_bind_text(statement, 3, [phone UTF8String], -1, NULL);
//           
//        }
//        
//        if(sqlite3_step(statement) != SQLITE_DONE ) {
//            NSLog( @"Error: %s", sqlite3_errmsg(contactDB) );
//        }
//        sqlite3_finalize(statement);
//        
//        
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([nameTextField isFirstResponder]) {
//        [addressTextField becomeFirstResponder];
        [nameTextField resignFirstResponder];
        
    }
    if ([contactNoTextField isFirstResponder]) {
        [contactNoTextField becomeFirstResponder];
        [contactNoTextField resignFirstResponder];
    
    }
    return YES;
}

@end
