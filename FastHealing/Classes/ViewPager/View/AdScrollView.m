

#import "AdScrollView.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"


#define HIGHT self.bounds.origin.y //由于_pageControl是添加进父视图的,所以实际位置要参考,滚动视图的y坐标
typedef void (^FinishBlock)();

static CGFloat const chageImageTime = 3;
static NSUInteger currentImage = 1;//记录中间图片的下标,开始总是为1

@interface AdScrollView ()

{
    //广告的label
    UILabel * _adLabel;
    //循环滚动的三个视图
    UIImageView * _leftImageView;
    UIImageView * _centerImageView;
    UIImageView * _rightImageView;
    
    //用于确定滚动式由人导致的还是计时器到了,系统帮我们滚动的,YES,则为系统滚动,NO则为客户滚动(ps.在客户端中客户滚动一个广告后,这个广告的计时器要归0并重新计时)
    BOOL _isTimeUp;
    //为每一个图片添加一个广告语(可选)
    UILabel * _leftAdLabel;
    UILabel * _centerAdLabel;
    UILabel * _rightAdLabel;
}

@property (retain,nonatomic,readonly) UIImageView * leftImageView;
@property (retain,nonatomic,readonly) UIImageView * centerImageView;
@property (retain,nonatomic,readonly) UIImageView * rightImageView;
@property (nonatomic, assign) NSInteger currentPage;
//循环滚动的周期时间
@property (nonatomic, strong)NSTimer *moveTime;
@end

@implementation AdScrollView

#pragma mark - 自由指定广告所占的frame
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _myScrollView = [[UIScrollView alloc]initWithFrame:frame];
        _myScrollView.bounces = YES;
        _myScrollView.showsHorizontalScrollIndicator = NO;
        _myScrollView.showsVerticalScrollIndicator = NO;
        _myScrollView.pagingEnabled = YES;
        //  warning      _myScrollView.contentOffset = CGPointMake(UISCREENWIDTH, 0);
        _myScrollView.contentSize = CGSizeMake(UISCREENWIDTH * 3, UISCREENHEIGHT);
        _myScrollView.delegate = self;
        
        
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [_myScrollView addSubview:_leftImageView];
        
        _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [_myScrollView addSubview:_centerImageView];
        
        
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH*2, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [_myScrollView addSubview:_rightImageView];
        
        //[self.moveTime fire];
        //_isTimeUp = NO;
        
        [self addSubview:_myScrollView];
        
    }
    return self;
}


#pragma mark - 设置广告所使用的图片(名字)
- (void)setImageURLArray:(NSArray *)ImageURLArray
{
    _ImageURLArray = ImageURLArray;
    [self setImageViewImageWithURL:ImageURLArray[0] imageView:_leftImageView];
    [self setImageViewImageWithURL:ImageURLArray[1] imageView:_centerImageView];
    [self setImageViewImageWithURL:ImageURLArray[2] imageView:_rightImageView];
    
    
    [self.moveTime invalidate];
    self.moveTime = nil;
    [self cacheImageWith:^{
        [self moveTime];
        _isTimeUp = NO;
    }];
}

- (NSTimer *)moveTime{
    if (!_moveTime) {
        _moveTime = [NSTimer scheduledTimerWithTimeInterval:chageImageTime target:self selector:@selector(animalMoveImage) userInfo:nil repeats:YES];
    }
    return _moveTime;
}



/**
 *  先下载完之后, 在同一做滚动
 */
- (void)cacheImageWith:(FinishBlock)finishBlock {
    if (self.ImageURLArray.count == 0) {
        return;
    }
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (NSString *urlString in self.ImageURLArray) {
        NSURL *url = [NSURL URLWithString:urlString];
        
        if ([mgr cachedImageExistsForURL:url]) {
            continue;
        } else if ([mgr diskImageExistsForURL:url]){
            continue;
        }
        dispatch_group_enter(group);
        [mgr downloadImageWithURL:url options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            dispatch_group_leave(group);
        }];
    }
    dispatch_group_notify(group, queue, ^{
        if (finishBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                finishBlock();
            });
        }
    });
}

- (void)setImageViewImageWithURL:(NSString *)urlString  imageView:(UIImageView *)imageView{
    [imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"banner_default.jpg"] options:SDWebImageRetryFailed];
}


#pragma mark - 设置每个对应广告对应的广告语
- (void)setAdTitleArray:(NSArray *)adTitleArray withShowStyle:(AdTitleShowStyle)adTitleStyle
{
    _adTitleArray = adTitleArray;
    
    if(adTitleStyle == AdTitleShowStyleNone)
    {
        return;
    }
    
    _leftAdLabel = [[UILabel alloc]init];
    _centerAdLabel = [[UILabel alloc]init];
    _rightAdLabel = [[UILabel alloc]init];
    
    _leftAdLabel.textColor=[UIColor orangeColor];
    _centerAdLabel.textColor=[UIColor orangeColor];
    _rightAdLabel.textColor=[UIColor orangeColor];
    
    _leftAdLabel.frame      = CGRectMake(10, UISCREENHEIGHT - 50, UISCREENWIDTH-20, 20);
    [_leftImageView addSubview:_leftAdLabel];
    _centerAdLabel.frame    = CGRectMake(10, UISCREENHEIGHT - 50, UISCREENWIDTH-20, 20);
    [_centerImageView addSubview:_centerAdLabel];
    _rightAdLabel.frame     = CGRectMake(10, UISCREENHEIGHT - 50, UISCREENWIDTH-20, 20);
    [_rightImageView addSubview:_rightAdLabel];
    
    if (adTitleStyle == AdTitleShowStyleLeft) {
        _leftAdLabel.textAlignment = NSTextAlignmentLeft;
        _centerAdLabel.textAlignment = NSTextAlignmentLeft;
        _rightAdLabel.textAlignment = NSTextAlignmentLeft;
    }
    else if (adTitleStyle == AdTitleShowStyleCenter)
    {
        _leftAdLabel.textAlignment = NSTextAlignmentCenter;
        _centerAdLabel.textAlignment = NSTextAlignmentCenter;
        _rightAdLabel.textAlignment = NSTextAlignmentCenter;
    }
    else
    {
        _leftAdLabel.textAlignment = NSTextAlignmentRight;
        _centerAdLabel.textAlignment = NSTextAlignmentRight;
        _rightAdLabel.textAlignment = NSTextAlignmentRight;
    }
    
    
    _leftAdLabel.text = _adTitleArray[0];
    _centerAdLabel.text = _adTitleArray[1];
    _rightAdLabel.text = _adTitleArray[2];
    
}


#pragma mark - 创建pageControl,指定其显示样式
- (void)setPageControlShowStyle:(UIPageControlShowStyle)PageControlShowStyle
{
    if (PageControlShowStyle == UIPageControlShowStyleNone) {
        return;
    }
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.numberOfPages = _ImageURLArray.count;
    
    if (PageControlShowStyle == UIPageControlShowStyleLeft)
    {
        _pageControl.frame = CGRectMake(10, HIGHT+UISCREENHEIGHT - 10, 20*_pageControl.numberOfPages, 20);
    }
    else if (PageControlShowStyle == UIPageControlShowStyleCenter)
    {
        _pageControl.frame = CGRectMake(0, 0, 20*_pageControl.numberOfPages, 20);
        _pageControl.center = CGPointMake(UISCREENWIDTH/2.0, HIGHT+UISCREENHEIGHT - 10);
    }
    else
    {
        _pageControl.frame = CGRectMake( UISCREENWIDTH - 20*_pageControl.numberOfPages, HIGHT+UISCREENHEIGHT - 10, 20*_pageControl.numberOfPages, 20);
    }
    
    _pageControl.currentPage = _currentPage = 0;
    
    _pageControl.enabled = NO;
    
    [self performSelector:@selector(addPageControl) withObject:nil afterDelay:0.0f];
}
//由于PageControl这个空间必须要添加在滚动视图的父视图上(添加在滚动视图上的话会随着图片滚动,而达不到效果)
- (void)addPageControl
{
    [self addSubview:_pageControl];
}

#pragma mark - 计时器到时,系统滚动图片
- (void)animalMoveImage
{
    [_myScrollView setContentOffset:CGPointMake(UISCREENWIDTH * 2 , 0) animated:YES];
    _isTimeUp = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}

#pragma mark - 图片停止时,调用该函数使得滚动视图复用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (!_ImageURLArray.count) {
        return;
    }
    //    NSLog(@"%f",_myScrollView.contentOffset.x);
    //    NSLog(@"currentImage = %zd,    _pageControl.count = %zd",currentImage  ,_pageControl.currentPage);
    
    if (_myScrollView.contentOffset.x == 0)
    {
        //        if (currentImage == 0) {
        //            currentImage = 2;
        //        }
        currentImage = (currentImage-1)%_ImageURLArray.count;
        _currentPage= _pageControl.currentPage =(_pageControl.currentPage - 1)%_ImageURLArray.count;
        
    }
    else if(_myScrollView.contentOffset.x == UISCREENWIDTH * 2)
    {
        currentImage = (currentImage+1)%_ImageURLArray.count;
        _currentPage= _pageControl.currentPage= (_pageControl.currentPage + 1)%_ImageURLArray.count;
    }
    else
    {
        return;
    }
    
    [self setImageViewImageWithURL:_ImageURLArray[(currentImage-1)%_ImageURLArray.count] imageView:_leftImageView];
    [self setImageViewImageWithURL:_ImageURLArray[currentImage%_ImageURLArray.count] imageView:_centerImageView];
    [self setImageViewImageWithURL:_ImageURLArray[(currentImage+1)%_ImageURLArray.count] imageView:_rightImageView];
    _leftAdLabel.text = _adTitleArray[(currentImage-1)%_ImageURLArray.count];
    _centerAdLabel.text = _adTitleArray[currentImage%_ImageURLArray.count];
    _rightAdLabel.text = _adTitleArray[(currentImage+1)%_ImageURLArray.count];
    
    _myScrollView.contentOffset = CGPointMake(UISCREENWIDTH, 0);
    
    //手动控制图片滚动应该取消那个三秒的计时器
    if (!_isTimeUp) {
        [_moveTime setFireDate:[NSDate dateWithTimeIntervalSinceNow:chageImageTime]];
    }
    _isTimeUp = NO;
}

- (void) addTapEventForImageWithBlock: (TapImageViewButtonBlock) block{
    if (_block == nil) {
        if (block != nil) {
            _block = block;
            [self initImageViewButton];
        }
    }
}

#pragma -- mark 初始化按钮
- (void) initImageViewButton{
    
    //更改前 i < _ImageURLArray.count + 1
    for ( int i = 0; i < _ImageURLArray.count ; i ++) {
        
        CGRect currentFrame = CGRectMake(UISCREENWIDTH * i, 0, UISCREENWIDTH, UISCREENHEIGHT);
        
        UIButton *tempButton = [[UIButton alloc] initWithFrame:currentFrame];
        
        //tempButton.tag = i;
        if (i == 0) {
            tempButton.tag = _ImageURLArray.count;
        } else {
            tempButton.tag = i;
        }
        [tempButton addTarget:self action:@selector(tapImageButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [_myScrollView addSubview:tempButton];
    }
    
}

- (void) tapImageButton: (UIButton *) sender{
    if (_block) {
        _block(_currentPage + 1);
    }
}

- (UIImage *)imagewithURLStr:(NSString *)str
{
    NSData * imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
    UIImage * img = [UIImage imageWithData:imgData];
    return img;
}

- (void)dealloc {
    FHLog(@"%s",__func__);
    [_moveTime invalidate];
    _moveTime = nil;
}



@end


