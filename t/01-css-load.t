#! perl -T

use strict;
use warnings;

use Test::More tests => 2;

use Template::Flute;
use Template::Flute::Specification::XML;
use Template::Flute::HTML;
use Template::Flute::Style::CSS;

my $xml = <<EOF;
<specification name="csstest">
</specification>
EOF

my $html = '<style>
.example {
	float: left;
}
</style>
<div class="example">
Example
</div>
';

# parse XML specification
my ($spec, $ret);

$spec = new Template::Flute::Specification::XML;

$ret = $spec->parse($xml);

# parse HTML template
my ($html_object);

$html_object = new Template::Flute::HTML;

$html_object->parse($html, $ret);

# CSS object
my ($css, $props);

$css = Template::Flute::Style::CSS->new(template => $html_object);

isa_ok($css, 'Template::Flute::Style::CSS');

$props = $css->properties(class => 'example');

ok($props->{float} eq 'left');
