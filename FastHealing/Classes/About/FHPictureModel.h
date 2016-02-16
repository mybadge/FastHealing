//
//  FHPictureModel.h
//  FastHealing
//
//  Created by xiechen on 16/1/24.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FHPictureModel : NSObject
//banner_title = 热门医生,
//banner_img_url = http://hdkj-image1.chinacloudapp.cn/carelink/user/2015/12/4316336854579796.jpg,
//banner_link = http://hdkj-web2.chinacloudapp.cn:8080/web/doctor_3.html,
//banner_id = 8

@property (nonatomic,copy)NSString *banner_title;
@property (nonatomic,copy)NSString *banner_img_url;
@property (nonatomic,copy)NSString *banner_link;
@property (nonatomic,assign)int banner_id;
;




@end
