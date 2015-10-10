
#import "ViewController.h"

@interface ViewController ()
@property (strong , nonatomic) UIView* blackBoard;
@property (strong, nonatomic)  UIColor* randomColor;

@property (strong, nonatomic) NSMutableArray* arrayForChecker;

@end

@implementation ViewController


-(UIView*) buildChessBoard:(CGRect) rect andColor:(UIColor*)color andParentView:(UIView*) parentView {
    
    UIView* view = [[UIView alloc] initWithFrame:rect];
    //view.layer.cornerRadius = 20.0;
    view.backgroundColor = color;
    [parentView addSubview:view];
    
    view.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    return view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// Board Begin ///
    
    CGRect bounds = self.view.bounds;
    CGPoint centerOfView = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    
    // Инициализация доскм
    self.blackBoard = [[UIView alloc] initWithFrame:
    CGRectMake(centerOfView.x - CGRectGetWidth(bounds)/2,
               centerOfView.y - CGRectGetWidth(bounds)/2,
               self.view.bounds.size.width,
               self.view.bounds.size.width+20)];
    
    //Добавляем доску на экран
    self.blackBoard.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.blackBoard];
    
    // Настраивание растягивания
    self.blackBoard.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    /// Board End ///
    
    self.arrayForChecker = [[NSMutableArray alloc] init];
    

    // Выбираем размер ячейки
    float sizeCell = self.view.bounds.size.width/8;
    float x = 0;
    float y = 0;
    
    NSInteger midX = self.blackBoard.bounds.size.width - sizeCell*8; // так как 10 клеток
    NSInteger midY = self.blackBoard.bounds.size.height - sizeCell*8;  // так как 8 клеток

    // Выбираем размер шашки
    
    
    float sizeChecker = sizeCell/2; // Шашка в 2 раза меньше чем ячейка
    float xchecker    = 0;
    float ychecker    = 0;
    
    for (int i=0; i<=7; i++) {
        x=0;
        for (int j=0; j<=3; j++) {
            
            if (i%2 == 0) {
                y=i*sizeCell+midY/2;
                [self buildChessBoard: CGRectMake(x, y, sizeCell,   sizeCell)   andColor:[UIColor blueColor]   andParentView:self.blackBoard];
                 x+=sizeCell;
                
                [self buildChessBoard: CGRectMake(x, y, sizeCell, sizeCell) andColor:[UIColor greenColor] andParentView:self.blackBoard];
                x+=sizeCell;
            }
            else {
                y=i*sizeCell+midY/2;
                [self buildChessBoard: CGRectMake(x, y, sizeCell, sizeCell) andColor:[UIColor greenColor] andParentView:self.blackBoard];
                x+=sizeCell;
                
                [self buildChessBoard: CGRectMake(x, y, sizeCell, sizeCell) andColor:[UIColor blueColor] andParentView:self.blackBoard];
                x+=sizeCell;
            }
          }
        }
    
    // Рисуем белые шашки
    // цикл повторяется 3 раза , т.к. 3 - ряда шашек
    for (int line = 0; line<3; line++){
        
        xchecker=0;
        // цикл повторяется 4 раза , т.к. на одной линии должно стоять 4 шашки
         for (int numberChecker = 0; numberChecker < 4; numberChecker++) {
              // Если line четное число тогда первая клетка имеет желтый цвет
             
             if (line%2==0) {
              // y = линию * размерЯчейки+(Находим центр ячейки для шашки)
              ychecker=line*sizeCell+midY/2+sizeCell/4;
              UIView* view = [self buildChessBoard:CGRectMake(xchecker+sizeCell+sizeCell/4, ychecker, sizeCell/2, sizeCell/2)
                               andColor:[UIColor yellowColor]
                          andParentView:self.blackBoard];
              // добавляем на экран
             [self.arrayForChecker addObject:view];
             // увеличиваем х для прорисовки следующий шашки
             xchecker+=sizeCell*2;
    }
    
    else {
        ychecker=line*sizeCell+midY/2+sizeCell/4;
        UIView* view = [self buildChessBoard:CGRectMake(xchecker+sizeCell/4, ychecker, sizeCell/2, sizeCell/2)
                                    andColor:[UIColor yellowColor]  andParentView:self.blackBoard];
        [self.arrayForChecker addObject:view];
        xchecker+=sizeCell*2;
        }
        }
    }

    // Рисуем черные шашки

    for (int line = 5; line<8; line++) {
        xchecker=0;
        
        for (int numberChecker = 0; numberChecker < 4; numberChecker++) {
            
            if (line%2==0) {
                ychecker=line*sizeCell+midY/2+sizeCell/4;
              UIView* view = [self buildChessBoard:CGRectMake(xchecker+sizeCell+sizeCell/4, ychecker, sizeCell/2, sizeCell/2)
                                          andColor:[UIColor redColor] andParentView:self.blackBoard];
                [self.arrayForChecker addObject:view];
                xchecker+=sizeCell*2;
            }
            else {
                
                ychecker=line*sizeCell+midY/2+sizeCell/4;
             UIView* view = [self buildChessBoard:CGRectMake(xchecker+sizeCell/4, ychecker, sizeCell/2, sizeCell/2) andColor:[UIColor redColor] andParentView:self.blackBoard];
                
                [self.arrayForChecker addObject:view];
                xchecker+=sizeCell*2;
            } } }
    
}

    


- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}



-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    //Меняем цвет
    CGFloat redRandomColorLevel = (CGFloat)arc4random_uniform(256)/255;
    CGFloat greenRandomColorLevel = (CGFloat)arc4random_uniform(256)/255;
    CGFloat blueRandomColorLevel = (CGFloat)arc4random_uniform(256)/255;
    
    self.randomColor = [UIColor colorWithRed:redRandomColorLevel
                                       green:greenRandomColorLevel
                                        blue:blueRandomColorLevel
                                       alpha:1];
    
    for (UIView* view in self.blackBoard.subviews) {
        
        if ([view.backgroundColor isEqual:[UIColor greenColor]])
             view.backgroundColor =  self.randomColor;
    }
}


-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    NSMutableArray* Checkers = self.arrayForChecker;
    
    for (int i=0 ; i<=17; i++) {
    
    NSInteger firstNumberChecker = arc4random() % [Checkers count];
    UIView*   firstTestView = [Checkers objectAtIndex:firstNumberChecker];
    
    NSInteger secondNumberChecker = arc4random() % [Checkers count];
    UIView*   secondTestView = [Checkers objectAtIndex:secondNumberChecker];

    CGPoint point = firstTestView.center;
    [UIView animateWithDuration:1 animations:^{
        
        firstTestView.center = secondTestView.center;
        secondTestView.center = point;
    }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
