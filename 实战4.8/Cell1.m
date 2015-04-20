
#import "Cell1.h"

@implementation Cell1
@synthesize titleLabel,arrowImageView;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)changeArrowWithUp:(BOOL)up
{
    //当第一行被选中时，图标为up.(此时为展开状态)
    if (up) {
        self.arrowImageView.image = [UIImage imageNamed:@"UpAccessory.png"];
    }else
    {
        self.arrowImageView.image = [UIImage imageNamed:@"DownAccessory.png"];
    }
}

@end
