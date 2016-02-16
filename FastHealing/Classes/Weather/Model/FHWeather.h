//
//  FHWeather.h
//  FastHealing
//
//  Created by 赵志丹 on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHWeather_data.h"

@interface FHWeather : NSObject
@property (nonatomic, strong) NSArray *weather_data;
@property (nonatomic, copy) NSString *index;

/**
 city = {
	status = success,
	results = [
 {
	weather_data = [
 {
	nightPictureUrl = http://api.map.baidu.com/images/weather/night/qing.png,
	weather = 多云转晴,
	wind = 西北风4-5级,
	temperature = -16 ~ -27℃,
	dayPictureUrl = http://api.map.baidu.com/images/weather/day/duoyun.png,
	date = 周五 01月22日 (实时：-18℃)
 },
 {
	nightPictureUrl = http://api.map.baidu.com/images/weather/night/qing.png,
	weather = 多云转晴,
	wind = 西北风5-6级,
	temperature = -20 ~ -28℃,
	dayPictureUrl = http://api.map.baidu.com/images/weather/day/duoyun.png,
	date = 周六
 },
 {
	nightPictureUrl = http://api.map.baidu.com/images/weather/night/qing.png,
	weather = 晴,
	wind = 西北风3-4级,
	temperature = -12 ~ -28℃,
	dayPictureUrl = http://api.map.baidu.com/images/weather/day/qing.png,
	date = 周日
 },
 {
	nightPictureUrl = http://api.map.baidu.com/images/weather/night/duoyun.png,
	weather = 多云,
	wind = 西北风微风,
	temperature = -9 ~ -23℃,
	dayPictureUrl = http://api.map.baidu.com/images/weather/day/duoyun.png,
	date = 周一
 }
 ],
	currentCity = 大同区,
	pm25 = 43,
	index = [
 {
	title = 穿衣,
	zs = 寒冷,
	tipt = 穿衣指数,
	des = 天气寒冷，建议着厚羽绒服、毛皮大衣加厚毛衣等隆冬服装。年老体弱者尤其要注意保暖防冻。
 },
 {
	title = 洗车,
	zs = 较不宜,
	tipt = 洗车指数,
	des = 较不宜洗车，未来一天无雨，风力较大，如果执意擦洗汽车，要做好蒙上污垢的心理准备。
 },
 {
	title = 旅游,
	zs = 一般,
	tipt = 旅游指数,
	des = 天空状况还是比较好的，但温度很低，且风稍大，会让您感觉很冷，外出可选择雪上项目，并注意防寒保暖。
 },
 {
	title = 感冒,
	zs = 极易发,
	tipt = 感冒指数,
	des = 将有一次强降温过程，天气寒冷，且风力较强，极易发生感冒，请特别注意增加衣服保暖防寒。
 },
 {
	title = 运动,
	zs = 较不宜,
	tipt = 运动指数,
	des = 天气较好，但考虑天气寒冷，风力较强，推荐您进行室内运动，若在户外运动请注意保暖并做好准备活动。
 },
 {
	title = 紫外线强度,
	zs = 最弱,
	tipt = 紫外线强度指数,
	des = 属弱紫外线辐射天气，无需特别防护。若长期在户外，建议涂擦SPF在8-12之间的防晒护肤品。
 }
 ]
 }
 ],
	error = 0,
	date = 2016-01-22
 }
 2016-01-22 15:40:29.294 FastHealing[39282:457790] city = {
	status = success,
	results = [
 {
	weather_data = [
 {
	nightPictureUrl = http://api.map.baidu.com/images/weather/night/qing.png,
	weather = 多云转晴,
	wind = 西北风4-5级,
	temperature = -16 ~ -27℃,
	dayPictureUrl = http://api.map.baidu.com/images/weather/day/duoyun.png,
	date = 周五 01月22日 (实时：-18℃)
 },
 {
	nightPictureUrl = http://api.map.baidu.com/images/weather/night/qing.png,
	weather = 多云转晴,
	wind = 西北风5-6级,
	temperature = -20 ~ -28℃,
	dayPictureUrl = http://api.map.baidu.com/images/weather/day/duoyun.png,
	date = 周六
 },
 {
	nightPictureUrl = http://api.map.baidu.com/images/weather/night/qing.png,
	weather = 晴,
	wind = 西北风3-4级,
	temperature = -12 ~ -28℃,
	dayPictureUrl = http://api.map.baidu.com/images/weather/day/qing.png,
	date = 周日
 },
 {
	nightPictureUrl = http://api.map.baidu.com/images/weather/night/duoyun.png,
	weather = 多云,
	wind = 西北风微风,
	temperature = -9 ~ -23℃,
	dayPictureUrl = http://api.map.baidu.com/images/weather/day/duoyun.png,
	date = 周一
 }
 ],
	currentCity = 大同区,
	pm25 = 43,
	index = [
 {
	title = 穿衣,
	zs = 寒冷,
	tipt = 穿衣指数,
	des = 天气寒冷，建议着厚羽绒服、毛皮大衣加厚毛衣等隆冬服装。年老体弱者尤其要注意保暖防冻。
 },
 {
	title = 洗车,
	zs = 较不宜,
	tipt = 洗车指数,
	des = 较不宜洗车，未来一天无雨，风力较大，如果执意擦洗汽车，要做好蒙上污垢的心理准备。
 },
 {
	title = 旅游,
	zs = 一般,
	tipt = 旅游指数,
	des = 天空状况还是比较好的，但温度很低，且风稍大，会让您感觉很冷，外出可选择雪上项目，并注意防寒保暖。
 },
 {
	title = 感冒,
	zs = 极易发,
	tipt = 感冒指数,
	des = 将有一次强降温过程，天气寒冷，且风力较强，极易发生感冒，请特别注意增加衣服保暖防寒。
 },
 {
	title = 运动,
	zs = 较不宜,
	tipt = 运动指数,
	des = 天气较好，但考虑天气寒冷，风力较强，推荐您进行室内运动，若在户外运动请注意保暖并做好准备活动。
 },
 {
	title = 紫外线强度,
	zs = 最弱,
	tipt = 紫外线强度指数,
	des = 属弱紫外线辐射天气，无需特别防护。若长期在户外，建议涂擦SPF在8-12之间的防晒护肤品。
 }
 ]
 }
 ],
	error = 0,
	date = 2016-01-22
 }
 */
@end
