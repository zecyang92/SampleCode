//
//  ViewController.m
//  SampleCode
//
//  Created by Zebin Yang on 7/20/16.
//  Copyright © 2016 Lucky . All rights reserved.
//

#import "ViewController.h"
#import "AppDataManager.h"
#import "MBProgressHUD.h"
#import "CustomCell.h"
#import "DetailsViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property(nonatomic,strong) NSMutableArray *announcementListArr;
@end

@implementation ViewController
- (NSMutableArray*)announcementListArr{
    
    
    if (!_announcementListArr) {
        
        _announcementListArr = [[NSMutableArray alloc] init];
    }
    
    return _announcementListArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Announcement";
    self.tblView.estimatedRowHeight = 83;
    self.tblView.rowHeight = UITableViewAutomaticDimension;
    [self callApiForAnnouncementData];
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark - Api call
#pragma mark   Api call method for json data

-(void)callApiForAnnouncementData{
    [self showActivityIndicator:@"Getting List..."];
    __weak ViewController *weakSelf = self;
    
    [[AppDataManager sharedApiHandler] loadData:^(id data, NSError *error) {
        
        if ([data isKindOfClass:[NSArray class]]) {
            
            [[weakSelf announcementListArr] addObjectsFromArray:data];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            [weakSelf hideActivityIndicator];
            [[weakSelf tblView] reloadData];
            
        });
        
    }];
}

#pragma mark - TableView
#pragma mark   Table view data source & delegate method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_announcementListArr count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdetifier = @"CustomCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetifier];
    
    NSDictionary *dictAnnouncementTitle = [[_announcementListArr objectAtIndex:indexPath.row] valueForKey:@"ANNOUNCEMENT_TITLE"];
    NSDictionary *dictAnnouncementDate = [[_announcementListArr objectAtIndex:indexPath.row] valueForKey:@"ANNOUNCEMENT_DATE"];
    cell.lblTitle.text = [dictAnnouncementTitle valueForKey:@"Value"];
    cell.lblDate.text = [dictAnnouncementDate valueForKey:@"Value"];
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dictAnnouncementHtml = [[_announcementListArr objectAtIndex:indexPath.row] valueForKey:@"ANNOUNCEMENT_HTML"];
    DetailsViewController *detailController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    [detailController setDictHtml:dictAnnouncementHtml];
    [self.navigationController pushViewController:detailController animated:YES];
    
}

#pragma mark - showActivityIndicator
#pragma mark   show Activity Indicator method
- (void)showActivityIndicator:(NSString*)msg{
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:msg];
    
    
}
- (void)hideActivityIndicator{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
