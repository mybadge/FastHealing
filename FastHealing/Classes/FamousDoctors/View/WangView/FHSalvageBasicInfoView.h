//
//  FHSalvageBasicInfoView.h
//  FastHealing
//
//  Created by 王 on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol salvageBasicInfoViewDelegate <NSObject>

- (void)showMoreChoicesWithTapView:(UIView *)chooseView;
- (void)turnToNextInterface;
- (void)alertInformationNotComplete:(NSString *)infoStr;

@end
@interface FHSalvageBasicInfoView : UIView

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) BOOL isChosenCity;

//设置代理
@property (weak, nonatomic) id<salvageBasicInfoViewDelegate> delegate;

+ (instancetype)loadSalvageBasicViewWithXib;




@property (weak, nonatomic) IBOutlet UILabel *diseaseTitle;
@property (weak, nonatomic) IBOutlet UITextField *patientChildName;
@property (weak, nonatomic) IBOutlet UITextField *patientParentName;
@property (weak, nonatomic) IBOutlet UITextField *patientTelnumber;
@property (weak, nonatomic) IBOutlet UITextField *patientchildAge;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *distictLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *poorYes;
@property (weak, nonatomic) IBOutlet UIButton *PoorNo;
@property (weak, nonatomic) IBOutlet UIButton *disableYes;
@property (weak, nonatomic) IBOutlet UIButton *disableNo;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIView *relationshipView;
@property (weak, nonatomic) IBOutlet UILabel *relationshipLabel;
@property (weak, nonatomic) IBOutlet UIView *provinceView;
@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;
@property (weak, nonatomic) IBOutlet UIView *cityView;
@property (weak, nonatomic) IBOutlet UILabel *cityChosenLabel;
@property (weak, nonatomic) IBOutlet UIView *districtView;
@property (weak, nonatomic) IBOutlet UILabel *districtChosenLabel;

@end
