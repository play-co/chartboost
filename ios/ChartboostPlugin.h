#import "PluginManager.h"
#import "Chartboost.h"

@interface ChartboostPlugin : GCPlugin <ChartboostDelegate>

@property (nonatomic, retain) Chartboost *cb;

@end
