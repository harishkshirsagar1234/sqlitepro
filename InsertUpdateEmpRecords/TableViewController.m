//
//  TableViewController.m
//  InsertUpdateEmpRecords
//
//  Created by Student-004 on 21/10/16.
//  Copyright © 2016 Student-004. All rights reserved.
//

#import "TableViewController.h"
#import "EmployeeClass.h"
#import "UpdateRecordViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController


-(void) GetDatabasePathForEmp
{
    NSArray *documentDirectoryContents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //step 2 : Append database name to document directory path to get exact dbpath string.
    _dbpath= [NSString stringWithFormat:@"%@/EmployeeDatabase.sqlite",[documentDirectoryContents lastObject]];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    
    if([fileManager fileExistsAtPath:_dbpath])
    {
        NSLog(@"Database already exist");
        return ;
    }
    
}
-(void) InitPage
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
    
    _empRecord = [[NSMutableArray alloc] init];
    
    [self GetDatabasePathForEmp];
    
    //Step 3 : Open Database
    
    if(  sqlite3_open([_dbpath UTF8String], &_db)  ==  SQLITE_OK)
    {
        
        //Step 4: Create Table
        const char * query = "select * from emp";
        sqlite3_stmt *mystmt;
        //step 5: execute create table query:
        if(sqlite3_prepare(_db, query, -1, &mystmt, NULL)  == SQLITE_OK)
        {
            
            while(sqlite3_step(mystmt) == SQLITE_ROW)
            {
                EmployeeClass *empOb = [[EmployeeClass alloc] init];
                
                empOb.eno = (NSInteger)sqlite3_column_int(mystmt, 0);
                empOb.ename= [[NSString alloc] initWithFormat:@"%s",sqlite3_column_text(mystmt, 1)];
                empOb.eaddress =[[NSString alloc] initWithFormat:@"%s",sqlite3_column_text(mystmt, 2)];
                empOb.ephoneno = sqlite3_column_int(mystmt, 3);
                
                [_empRecord addObject:empOb];
                
            }
            
        }
        else
        {
            NSLog(@"failed to read record");
        }
        sqlite3_close(_db);
    }
    else
    {
        NSLog(@"Failed to open database for insert value");
    }
    

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitPage];
    
   
}
-(void) viewDidAppear:(BOOL)animated
{
    [self InitPage];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _empRecord.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"FirstToUpdate" sender:self];
    
    //indexPath.row
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue  identifier]  isEqualToString:@"FirstToUpdate"])
    {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]];
        
        UpdateRecordViewController *recordController = [segue destinationViewController];
        recordController.tempString = cell.textLabel.text;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
    
    cell = [cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    EmployeeClass *empObject ;
    empObject =  [_empRecord objectAtIndex:indexPath.row] ;
    cell.textLabel.text = empObject.ename;
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
