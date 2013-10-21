#!/usr/bin/env perl 
use strict;
use warnings;
use Tickit::DSL;
use Tickit::Widget::Calendar::MonthView;
use Tickit::Style;

Tickit::Style->load_style(<<'EOF');
Calendar::MonthView {
 month-fg: 248;
 weekday-fg: 243;
}
EOF

vbox {
	customwidget {
		my $w = Tickit::Widget::Calendar::MonthView->new(
			day => 2,
			month => 10,
			year => 2013,
		);
		$w->day(2);
		$w->month(10);
		$w->year(2013);
	} expand => 1;
};
tickit->run

